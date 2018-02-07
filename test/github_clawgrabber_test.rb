require 'test_helper'
require_relative '../samples/helpers/date_helper'

class GithubClawgrabberTest < TestClass
  describe 'clawgrabber core' do
    it 'it has a version number' do
      refute_nil ::GithubClawgrabber::VERSION
    end
  end

  describe 'without context' do
    before { stub_github }

    it 'should grab and format' do
      grab = GithubClawgrabber.grab 'token',
                                    'colinxfleming/github_clawgrabber_ruby',
                                    'samples/each_loop.txt.erb'
                                    # 'master',
                                    # DateHelper
      result = grab.first

      assert_equal 'samples/each_loop.txt.erb', result[:file]
      assert_includes result[:content], '1 * 2 = 2'
      assert_includes result[:content], '2 * 2 = 4'
      assert_includes result[:content], '3 * 2 = 6'
      assert_includes result[:content], '4 * 2 = 8'
      assert_includes result[:content], '5 * 2 = 10'
    end
  end

  # describe 'with context' do
  #   before { stub_github }
  #   it 'should grab and format' do
  #     grab = GithubClawgrabber.grab 'token',
  #                                   'colinxfleming/github_clawgrabber_ruby',
  #                                   'samples/today_via_context.txt.erb',
  #                                   'master',
  #                                   DateHelper
  #     result = grab.first

  #     today = Date.today.strftime('%Y-%m-%d')
  #     yesterday = (Date.today - 1).strftime('%Y-%m-%d')

  #     assert_equal 'samples/today_via_context.txt.erb', result[:file]
  #     assert_includes result[:content], "Today is #{today}"
  #     assert_includes result[:content], "Yesterday was #{yesterday}"
  #   end
  # end
end
