module GithubClawgrabber
  # a dummy class to hold our modules
  class ContextShell
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
