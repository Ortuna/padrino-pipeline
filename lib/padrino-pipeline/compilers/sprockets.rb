module Padrino
  module Pipeline 
    module Compiler
      class Sprockets
        def initialize(config)
          @config = config
        end

        def compile(type)
          create_directory(@config.compiled_output)
          create_directory("#{@config.compiled_output}/#{@config.js_compiled_output}")
          return unless @config.app
          case type
          when :js  then compile_js
          when :css then compile_css
          else 
            throw RuntimeError, "Can not compile #{type} asset"
          end
        end

        private
        def assets
          @config.app.assets
        end

        def output_path(directory_name)
          output_path = Pathname.new(@config.compiled_output).join(directory_name)
        end

        def js_output_path(file_name)
          output_path(@config.js_compiled_output).join(file_name)
        end

        def css_output_path(file_name)
          output_path(@config.css_compiled_output).join(file_name)
        end

        def compile_css
          asset  = assets[@config.css_compiled_asset]
          asset.write_to css_output_path('application.min.css')
          asset.write_to css_output_path('application.min.css.gz')
        end

        def compile_js
          asset  = assets[@config.js_compiled_asset]
          asset.write_to js_output_path('application.min.js')
          asset.write_to js_output_path('application.min.js.gz')
        end

        def create_directory(path)
          FileUtils.mkdir_p(path) unless File.exists?(path)
        end
      end
    end
  end
end
