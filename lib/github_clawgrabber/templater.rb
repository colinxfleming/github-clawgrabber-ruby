require 'erb'

module GithubClawgrabber
  class Templater
    class << self
      def template(content, context = nil)
        content = ERB.new content
        b = context&.binding
        content.result(b)
      end
    end
  end
end
