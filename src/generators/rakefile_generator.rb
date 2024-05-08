module Foobara
  module Generators
    module ResqueConnectorGenerator
      module Generators
        # Kind of tricky... for the first time we will be loading an existing file in the working directory
        # and modifying it.
        class RakefileGenerator < ResqueConnectorGenerator
          def applicable?
            gemspec_contents !~ /^\s*require\s*['"]resque\/tasks['"]/
          end

          def template_path
            "Rakefile"
          end

          def target_path
            template_path
          end

          def generate(_elements_to_generate)
            "#{gemspec_contents.chomp}\n\nrequire \"resque/tasks\"\ntask \"resque:work\" => :environment\n"
          end

          def gemspec_contents
            File.read(template_path)
          end
        end
      end
    end
  end
end
