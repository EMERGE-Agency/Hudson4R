require 'pp'
require 'rubygems'
gem 'test-unit'
require 'test/unit'
$LOAD_PATH << './lib'
require 'lib/hudson_tool'

class TC_Hudson4R_HudsonTool < Test::Unit::TestCase
  def setup
    @hudson = Hudson4R::HudsonTool.new("Your Server")
  end
  
  def test_get_projects
    result = @hudson.get_projects
    assert_kind_of(Hash, result)
  end
  
  def test_trigger_build
    
  end
  
  def teardown
    
  end
end
