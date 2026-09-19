module Foobara
  module Generators
    module ResqueConnectorGenerator
      module Generators
        class ResqueConnectorGenerator < Foobara::FilesGenerator
          class << self
            def manifest_to_generator_classes(manifest)
              case manifest
              when ResqueConnectorConfig
                [
                  Generators::GemfileGenerator,
                  Generators::GemspecGenerator,
                  Generators::RakefileGenerator,
                  Generators::ProcfileGenerator
                ]
              else
                # simplecov:disable
                raise "Not sure how build a generator for a #{manifest}"
                # simplecov:enable
              end
            end
          end

          alias resque_connector_config relevant_manifest

          def templates_dir
            # simplecov:disable
            "#{__dir__}/../../templates"
            # simplecov:enable
          end
        end
      end
    end
  end
end
