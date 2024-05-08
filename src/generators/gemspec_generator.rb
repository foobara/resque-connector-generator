module Foobara
  module Generators
    module ResqueConnectorGenerator
      module Generators
        # Kind of tricky... for the first time we will be loading an existing file in the working directory
        # and modifying it.
        class GemspecGenerator < ResqueConnectorGenerator
          def applicable?
            gemspec_contents !~ /^\s*spec.add_dependency\s*['"]resque['"]/
          end

          def template_path
            Dir["*.gemspec"].first
          end

          def target_path
            template_path
          end

          def generate(_elements_to_generate)
            match = gemspec_contents.match(/^\s*spec\.add_dependency\b[^\n]*\n/)
            match ||= gemspec_contents.match(/^end\s*\z/)

            if match
              new_entry = 'spec.add_dependency "resque"'
              "#{match.pre_match}\n#{new_entry}\n#{match}#{match.post_match}"
            else
              # TODO: maybe print a warning and return the original gemspec
              # :nocov:
              raise "Not sure how to inject #{name.inspect} into the gemspec's executables"
              # :nocov:
            end
          end

          def gemspec_contents
            File.read(template_path)
          end
        end
      end
    end
  end
end
