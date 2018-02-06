require 'test_helper'

class GithubClawgrabberTest < TestClass
  describe 'clawgrabber core' do
    it 'it has a version number' do
      refute_nil ::GithubClawgrabber::VERSION
    end
  end


  # def test_it_does_something_useful
  #   assert false
  # end
end
