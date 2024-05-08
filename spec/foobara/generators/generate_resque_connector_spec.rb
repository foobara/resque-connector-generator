RSpec.describe Foobara::Generators::ResqueConnectorGenerator::GenerateResqueConnector do
  let(:inputs) do
    {}
  end
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }

  around do |example|
    project_fixture_dir = "#{__dir__}/../../fixtures/test-project"

    Dir.chdir project_fixture_dir do
      example.run
    end
  end

  it "generates a resque_connector" do
    expect(outcome).to be_success

    expect(result.keys).to contain_exactly(
      "boot/async.rb",
      "Procfile",
      "Gemfile",
      "test-org-test-domain.gemspec",
      "Rakefile"
    )
  end
end
