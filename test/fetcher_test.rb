require 'test_helper'

# Test that the context shell initializes and makes binding accessible
class FetcherTest < TestClass
  describe 'constants' do
    it 'should set the GraphQL endpoint' do
      assert_equal 'https://api.github.com/graphql',
                   GithubClawgrabber::Fetcher::GITHUB_GRAPHQL_ENDPOINT
    end
  end
end
