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
                  Generators::ProcfileGenerator
                ]
              else
                # :nocov:
                raise "Not sure how build a generator for a #{manifest}"
                # :nocov:
              end
            end
          end

          alias resque_connector_config relevant_manifest

          def templates_dir
            # :nocov:
            "#{__dir__}/../../templates"
            # :nocov:
          end
        end
      end
    end
  end
end
