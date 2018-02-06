$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'github_clawgrabber'

require 'minitest/autorun'
require 'minitest/spec'

require 'webmock/minitest'
WebMock.disable_net_connect!

class TestClass < Minitest::Spec
end
