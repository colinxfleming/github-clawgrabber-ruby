require 'test_helper'
require_relative '../samples/helpers/date_helper'

# Test that the context shell initializes and makes binding accessible
class ContextShellTest < TestClass
  before do
    @context = GithubClawgrabber::ContextShell.new [DateHelper]
  end

  describe 'initializing the context shell with modules' do
    it 'should have methods in the modules functional' do
      assert_equal Date.today.strftime('%Y-%m-%d'),
                   @context.today
      assert_equal (Date.today - 1).strftime('%Y-%m-%d'),
                   @context.yesterday
    end
  end

  it 'should make binding available' do
    assert @context.respond_to? :access_binding
  end
end
