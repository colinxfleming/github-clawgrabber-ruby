require 'erb'

module GithubClawgrabber
  class Templater
    class << self
      def template(content, *helper_modules)
        content = ERB.new content

        b = apply_context helper_modules
        content.result(b)
      end

      private

      def apply_context(helper_modules)
        return if helper_modules.empty?

        context_shell = ContextClass.new helper_modules
        context_shell.access_binding
      end
    end
  end

  # a dummy class to hold our modules
  class ContextClass
    def initialize(helper_modules)
      helper_modules.each do |helper|
        self.class.send :include, helper
      end
    end

    def access_binding
      binding
    end
  end
end
