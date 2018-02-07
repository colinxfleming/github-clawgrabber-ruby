$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'github_clawgrabber'

require 'minitest/autorun'
require 'minitest/spec'

require 'webmock/minitest'
WebMock.disable_net_connect!

class TestClass < Minitest::Spec
  # for samples/each_loop.txt.erb
  SUCCESSFUL_CALL_HEADERS = { "server"=>["GitHub.com"], "date"=>["Wed, 07 Feb 2018 03:10:48 GMT"], "content-type"=>["application/json; charset=utf-8"], "content-length"=>["129"], "connection"=>["close"], "status"=>["200 OK"], "x-ratelimit-limit"=>["5000"], "x-ratelimit-remaining"=>["4996"], "x-ratelimit-reset"=>["1517975935"], "cache-control"=>["no-cache"], "x-oauth-scopes"=>["read:gpg_key, read:org, read:public_key, read:repo_hook, repo, user"], "x-accepted-oauth-scopes"=>["repo"], "x-github-media-type"=>["github.v4; format=json"], "access-control-expose-headers"=>["ETag, Link, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval"], "access-control-allow-origin"=>["*"], "content-security-policy"=>["default-src 'none'"], "strict-transport-security"=>["max-age=31536000; includeSubdomains; preload"], "x-content-type-options"=>["nosniff"], "x-frame-options"=>["deny"], "x-xss-protection"=>["1; mode=block"], "x-runtime-rack"=>["0.055496"], "x-github-request-id"=>["D86B:23D7:2353B7:463236:5A7A6E38"] }
  SUCCESSFUL_CALL_STATUS = 200
  SUCCESSFUL_CALL_BODY = "{\"data\":{\"repository\":{\"object\":{\"text\":\"<% [1, 2, 3, 4, 5].each do |num| %>\\n  <%= num %> * 2 = <%= num * 2 %>\\n<% end %>\\n\"}}}}"

  # for samples/each_loop.txt.erbaa
  FAILURE_CALL_BAD_FILE_HEADERS = { "server"=>["GitHub.com"], "date"=>["Wed, 07 Feb 2018 03:12:36 GMT"], "content-type"=>["application/json; charset=utf-8"], "content-length"=>["39"], "connection"=>["close"], "status"=>["200 OK"], "x-ratelimit-limit"=>["5000"], "x-ratelimit-remaining"=>["4995"], "x-ratelimit-reset"=>["1517975935"], "cache-control"=>["no-cache"], "x-oauth-scopes"=>["read:gpg_key, read:org, read:public_key, read:repo_hook, repo, user"], "x-accepted-oauth-scopes"=>["repo"], "x-github-media-type"=>["github.v4; format=json"], "access-control-expose-headers"=>["ETag, Link, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval"], "access-control-allow-origin"=>["*"], "content-security-policy"=>["default-src 'none'"], "strict-transport-security"=>["max-age=31536000; includeSubdomains; preload"], "x-content-type-options"=>["nosniff"], "x-frame-options"=>["deny"], "x-xss-protection"=>["1; mode=block"], "x-runtime-rack"=>["0.059818"], "x-github-request-id"=>["D86D:23D8:38B7DD:64FA8C:5A7A6EA4"] }
  FAILURE_CALL_BAD_FILE_STATUS = 200
  FAILURE_CALL_BAD_FILE_BODY = "{\"data\":{\"repository\":{\"object\":null}}}"

  # for a repo that doesn't exist
  FAILURE_CALL_BAD_REPO_HEADERS = { "server"=>["GitHub.com"], "date"=>["Wed, 07 Feb 2018 03:16:21 GMT"], "content-type"=>["application/json; charset=utf-8"], "content-length"=>["207"], "connection"=>["close"], "status"=>["200 OK"], "x-ratelimit-limit"=>["5000"], "x-ratelimit-remaining"=>["4994"], "x-ratelimit-reset"=>["1517975935"], "cache-control"=>["no-cache"], "x-oauth-scopes"=>["read:gpg_key, read:org, read:public_key, read:repo_hook, repo, user"], "x-accepted-oauth-scopes"=>["repo"], "x-github-media-type"=>["github.v4; format=json"], "access-control-expose-headers"=>["ETag, Link, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval"], "access-control-allow-origin"=>["*"], "content-security-policy"=>["default-src 'none'"], "strict-transport-security"=>["max-age=31536000; includeSubdomains; preload"], "x-content-type-options"=>["nosniff"], "x-frame-options"=>["deny"], "x-xss-protection"=>["1; mode=block"], "x-runtime-rack"=>["0.037937"], "x-github-request-id"=>["D874:23D8:391CB6:65A199:5A7A6F85"] }
  FAILURE_CALL_BAD_REPO_STATUS = 200
  FAILURE_CALL_BAD_REPO_BODY = "{\"data\":{\"repository\":null},\"errors\":[{\"message\":\"Could not resolve to a Repository with the name 'xxgithub_clawgrabber_ruby'.\",\"type\":\"NOT_FOUND\",\"path\":[\"repository\"],\"locations\":[{\"line\":1,\"column\":9}]}]}"

  # For a bad or null token
  FAILURE_CALL_BAD_TOKEN_HEADERS = { "server"=>["GitHub.com"], "date"=>["Wed, 07 Feb 2018 03:18:07 GMT"], "content-type"=>["application/json; charset=utf-8"], "content-length"=>["83"], "connection"=>["close"], "status"=>["401 Unauthorized"], "x-github-media-type"=>["github.v4; format=json"], "x-ratelimit-limit"=>["0"], "x-ratelimit-remaining"=>["0"], "x-ratelimit-reset"=>["1517977087"], "access-control-expose-headers"=>["ETag, Link, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval"], "access-control-allow-origin"=>["*"], "content-security-policy"=>["default-src 'none'"], "strict-transport-security"=>["max-age=31536000; includeSubdomains; preload"], "x-content-type-options"=>["nosniff"], "x-frame-options"=>["deny"], "x-xss-protection"=>["1; mode=block"], "x-runtime-rack"=>["0.016028"], "x-github-request-id"=>["D87A:23D9:249E52:67D8A3:5A7A6FEF"] }
  FAILURE_CALL_BAD_TOKEN_STATUS = 401
  FAILURE_CALL_BAD_TOKEN_BODY = "{\"message\":\"Bad credentials\",\"documentation_url\":\"https://developer.github.com/v3\"}"

  def stub_github(response_headers = SUCCESSFUL_CALL_HEADERS,
                  response_body = SUCCESSFUL_CALL_BODY,
                  response_status = SUCCESSFUL_CALL_STATUS)
    stub_request(:post, 'https://api.github.com/graphql')
      .to_return(body: response_body,
                 status: response_status,
                 headers: response_headers)
  end

  STOCK_FETCHER_DATE_OUTPUT = [{
    file: 'samples/today_via_context.txt.erb',
    content: "Today is <%= today %>.\n\nYesterday was <%= yesterday %>.\n"
  }]

  STOCK_FETCHER_LOOP_OUTPUT = [{
    file: 'samples/each_loop.txt.erb',
    content: "<% [1, 2, 3, 4, 5].each do |num| %>\n  <%= num %> * 2 = <%= num * 2 %>\n<\% end %>\n"
  }]
end
