require 'erb'

module GithubClawgrabber
  class Templater
    class << self
      def template(item, context)
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
