require 'github_clawgrabber/version'
require 'github_clawgrabber/fetcher'
require 'github_clawgrabber/templater'

module GithubClawgrabber
  def self.grab(auth_token, repo, filepath, branch = 'master')
    content = fetch auth_token, repo, filepath, branch
    template
    output
  end

  private

  def fetch
    Fetcher.fetcher auth_token, repo, filepath, branch
  end

  def template
    Templater.something
  end

  def output
    Outputter.something
  end
end
