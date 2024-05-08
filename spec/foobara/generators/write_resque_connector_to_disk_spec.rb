RSpec.describe Foobara::Generators::ResqueConnectorGenerator::WriteResqueConnectorToDisk do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:inputs) do
    {
      resque_connector_config:,
      output_directory:
    }
  end
  let(:resque_connector_config) do
    {}
  end
  let(:output_directory) { "#{__dir__}/../../../tmp/resque_connector_test_suite_output" }

  around do |example|
    FileUtils.rm_rf output_directory
    FileUtils.mkdir_p output_directory

    project_fixture_dir = "#{__dir__}/../../fixtures/test-project"

    Dir["#{project_fixture_dir}/*", "#{project_fixture_dir}/.*"].each do |f|
      next if f.end_with?(".")

      FileUtils.cp_r f, output_directory
    end

    Dir.chdir output_directory do
      example.run
    end
  end

  describe "#run" do
    it "contains base files" do
      expect(outcome).to be_success

      expect(command.paths_to_source_code.keys).to include("boot/async.rb")
    end

    it "updates the Gemfile" do
      expect(outcome).to be_success

      expect(
        command.paths_to_source_code["Gemfile"]
      ).to include('gem "foobara-resque-connector", github: "foobara/resque-connector"')
    end

    context "when there's no Procfile" do
      before do
        FileUtils.rm "#{output_directory}/Procfile"
      end

      it "creates one" do
        expect(outcome).to be_success

        expect(command.paths_to_source_code.keys).to include("Procfile")
      end
    end
  end

  describe "#output_directory" do
    context "with no output directory" do
      let(:inputs) do
        {
          resque_connector_config:
        }
      end

      it "writes files to the current directory" do
        command.cast_and_validate_inputs
        expect(command.output_directory).to eq(".")
      end
    end
  end

  describe ".generator_key" do
    subject { described_class.generator_key }

    it { is_expected.to be_a(String) }
  end
end
