require 'test_helper'

# Test that the context shell initializes and makes binding accessible
class FetcherTest < TestClass
  describe 'constants' do
    it 'should set the GraphQL endpoint' do
      assert_equal 'https://api.github.com/graphql',
                   GithubClawgrabber::Fetcher::GITHUB_GRAPHQL_ENDPOINT
    end
  end

  describe 'fetching' do
    before do
      stub_request(:get, 'api.github.com/graphql')
        .to_return()

    end

    it 'should make an api call' do

    end
  end
end
