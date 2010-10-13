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
  
  def test_get_jobs
    result = @hudson.get_jobs
    assert_kind_of(Hash, result)
    assert(result['justin_sandbox_com'])
  end
  
  def test_trigger_build
    result = @hudson.trigger_build('koopmanostbo_com')
    assert(result)
  end
  
  def test_find_job
    result = @hudson.find_job('koopmanostbo_com')
    assert_equal(result['name'], 'koopmanostbo_com')
  end
  
  def teardown
    @hudson = nil
  end
end
