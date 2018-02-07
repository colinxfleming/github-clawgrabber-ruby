require 'test_helper'
require_relative '../samples/helpers/date_helper'

# Test templater behavior
class TemplaterTest < TestClass
  describe 'without context' do
    before { @loop_item = STOCK_FETCHER_LOOP_OUTPUT.first }

    it 'should template' do
      output = GithubClawgrabber::Templater.template @loop_item

      assert_equal @loop_item[:file],
                   output[:file]

      assert_includes output[:content], '1 * 2 = 2'
      assert_includes output[:content], '2 * 2 = 4'
      assert_includes output[:content], '3 * 2 = 6'
      assert_includes output[:content], '4 * 2 = 8'
      assert_includes output[:content], '5 * 2 = 10'
    end
  end

  describe 'with context' do
    before do
      @date_item = STOCK_FETCHER_DATE_OUTPUT.first
      @context = GithubClawgrabber::ContextShell.new [DateHelper]
    end

    it 'should template' do
      output = GithubClawgrabber::Templater.template @date_item,
                                                     @context

      today = Date.today.strftime('%Y-%m-%d')
      yesterday = (Date.today - 1).strftime('%Y-%m-%d')

      assert_equal @date_item[:file],
                   output[:file]
      assert_includes output[:content], "Today is #{today}"
      assert_includes output[:content], "Yesterday was #{yesterday}"
    end
  end
end
