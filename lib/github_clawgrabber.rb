require 'github_clawgrabber/version'
require 'github_clawgrabber/fetcher'
require 'github_clawgrabber/templater'
require 'github_clawgrabber/context_shell'

module GithubClawgrabber
  class << self
    def grab(auth_token, repo, filepath, branch = 'master', *helper_modules)
      content = fetch auth_token, repo, filepath, branch
      context = ContextShell.new helper_modules
      results = template content, context
      puts results
      results
    end

    private

    def fetch(auth_token, repo, filepath, branch)
      Fetcher.fetch auth_token, repo, filepath, branch
    end

    def template(content, context)
      content.map do |item|
        Templater.template item, context
      end
    end

    def output
      Outputter.something
    end
  end
end
