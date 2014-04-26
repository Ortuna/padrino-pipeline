require 'padrino-helpers'

module Padrino
  module Helpers
    module AssetTagHelpers

      def pipeline_asset_folder_name(kind)
        pipeline = settings.pipeline
        case kind
        when :css    then pipeline.css_prefix
        when :js     then pipeline.js_prefix
        when :images then pipeline.image_prefix
        when :fonts  then pipeline.font_prefix
        else kind.to_s
        end
      end

      alias_method :original_asset_folder_name, :asset_folder_name
      alias_method :asset_folder_name, :pipeline_asset_folder_name

      alias_method :original_javascript_include_tag, :javascript_include_tag
      def javascript_include_tag(*sources)
        options = sources.extract_options!.symbolize_keys
        options.reverse_merge!(:type => 'text/javascript')
        sources.flatten.map { |source|
          content_tag(:script, nil, options.reverse_merge(:src => resolve_js_path(source.to_s)))
        }.join("\n").html_safe
      end

      alias_method :original_stylesheet_link_tag, :stylesheet_link_tag
      def stylesheet_link_tag(*sources)
        options = sources.extract_options!.symbolize_keys
        options.reverse_merge!(:media => 'screen', :rel => 'stylesheet', :type => 'text/css')
        sources.flatten.map { |source|
          tag(:link, options.reverse_merge(:href => asset_path(:css, resolve_css_path(source.to_s))))
        }.join("\n").html_safe
      end

      private
      def resolve_css_path(source)
        resolve_path(:css, source)
      end

      def resolve_js_path(source)
        resolve_path(:js, source)
      end

      def resolve_path(type, source)
        digested_source       = digested_source(source)
        digested_source_path  = digested_source_path(type, digested_source)
        File.exists?(digested_source_path) ? asset_path(type, digested_source) : asset_path(type, source)
      end

      ##
      # Get the full path of the digested_source
      def digested_source_path(type, digested_source)
        #hackzor
        settings.pipeline.asset_compiler.send("#{type.to_s}_output_path", digested_source)
      rescue
        ''
      end

      ##
      # Add the hex digest to the source path
      def digested_source(source)
        digest = asset_digest(source)
        parts  = source.split('.')
        (parts[0...parts.count-1]).join('.') << "-#{digest}.#{parts.last}"
      end

      ##
      # Get the hex digest for a particular asset
      def asset_digest(source)
        return '' unless defined? settings
        return '' unless settings.respond_to?(:assets)
        return '' unless settings.assets.respond_to?(:[])
        settings.assets[source] && settings.assets[source].digest
      end

    end #AssetTagHelpers
  end #Helpers
end #Padrino
