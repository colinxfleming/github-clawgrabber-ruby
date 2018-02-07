require 'erb'

module GithubClawgrabber
  # Takes a template and context, spits out some properly formatted data
  class Templater
    class << self
      def template(item, context = ContextShell.new)
        raw = ERB.new item[:content]
        template_result = raw.result(context.access_binding)
        {
          file: item[:file],
          content: template_result
        }
      end
    end
  end
end
