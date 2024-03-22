RSpec.describe Foobara::Generators::ResqueConnectorGenerator::GenerateResqueConnector do
  let(:inputs) do
    {}
  end
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }

  it "generates a resque_connector" do
    expect(outcome).to be_success

    expect(result.keys).to contain_exactly("boot/resque.rb", "Procfile", "Gemfile")
  end
end
