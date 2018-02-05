require 'httparty'

module GithubClawgrabber
  # Handle Github GraphQL interactions
  class Fetcher
    GITHUB_GRAPHQL_ENDPOINT = 'https://api.github.com/graphql'.freeze

    class << self
      def fetch(auth_token, repo, filepath, branch)
        response = make_api_call auth_token, repo, filepath, branch
        response
      end

      private

      def make_api_call(auth_token, repo, filepath, branch)
        headers = define_headers auth_token
        post_json = define_post_json repo, filepath, branch
        HTTParty.post GITHUB_GRAPHQL_ENDPOINT, body: post_json, headers: headers
      end

      def define_headers(auth_token)
        {
          'Authorization' => "bearer #{auth_token}",
          'User-Agent' => 'github_clawgrabber_ruby'
        }
      end

      def define_post_json(repo, filepath, branch)
        repository = "repository(owner: \"#{repo.split('/')[0]}\", name: \"#{repo.split('/')[1]}\")"
        object = "object(expression: \"#{branch}:#{filepath}\")"
        json = "query { #{repository} { #{object} { ... on Blob { text } } } }"
        { query: json }.to_json
      end
    end
  end
end
