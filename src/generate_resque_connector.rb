require "pathname"

require_relative "resque_connector_config"

module Foobara
  module Generators
    module ResqueConnectorGenerator
      class GenerateResqueConnector < Foobara::Generators::Generate
        class MissingManifestError < RuntimeError; end

        possible_error MissingManifestError

        inputs ResqueConnectorConfig

        def execute
          include_non_templated_files

          add_initial_elements_to_generate

          each_element_to_generate do
            generate_element
          end

          paths_to_source_code
        end

        attr_accessor :manifest_data

        def base_generator
          Generators::ResqueConnectorGenerator
        end

        # TODO: delegate this to base_generator
        def templates_dir
          # TODO: implement this?
          # simplecov:disable
          "#{__dir__}/../templates"
          # simplecov:enable
        end

        def add_initial_elements_to_generate
          elements_to_generate << resque_connector_config
        end

        def resque_connector_config
          @resque_connector_config ||= ResqueConnectorConfig.new(inputs)
        end
      end
    end
  end
end
