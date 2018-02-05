require 'erb'

module GithubClawgrabber
  class Templater
    class << self
      def template(content, *context_modules)
        content = ERB.new content

        b = apply_context context_modules
        content.result(b)
      end

      private

      def apply_context(context_modules)
        return if context_modules.empty?

        context_shell = ContextClass.new context_modules
        context_shell.access_binding
      end
    end
  end

  # a dummy class to hold our modules
  class ContextClass
    def initialize(modules)
      modules.each do |mod|
        self.class.send :include, mod
      end
    end

    def access_binding
      binding
    end
  end
end
