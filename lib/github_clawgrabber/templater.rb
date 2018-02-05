require 'erb'

module GithubClawgrabber
  class Templater
    class << self
      def template(content, context = nil)
        content = ERB.new content

        b = apply_context context
        content.result(b)
      end

      private

      def apply_context(context)
        return if context.nil?

        context.binding
      end
    end
  end
end
