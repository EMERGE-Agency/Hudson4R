require 'pp'
require 'rubygems'
gem 'test-unit'
require 'test/unit'
$LOAD_PATH << './lib'
require 'lib/hudson'

class TC_Hudson4R_HudsonTool < Test::Unit::TestCase
  def setup
    @hudson = Hudson4R::Hudson.new("Your Server")
  end
  
  def test_get_jobs
    result = @hudson.get_jobs
    assert_kind_of(Hash, result)
    assert(result['justin_sandbox_com'])
  end
  
  def test_get_queue
    result = @hudson.get_queue
    assert(result.has_key? 'items')
  end
  
  def test_trigger_build_good_job_with_params
    assert(@hudson.trigger_build('justin_sandbox_com', {'issue_key'=>'SP-4'}))
  end
  
  def test_trigger_build_good_job_without_params
    assert(@hudson.trigger_build('irispmt_com'))
  end
  
  def test_trigger_build_bad_job
    assert_false(@hudson.trigger_build('bad_company_com'))
  end
  
  def test_find_job
    result = @hudson.find_job('justin_sandbox_com')
    assert_equal(result['name'], 'justin_sandbox_com')
  end
  
  def teardown
    @hudson = nil
  end
end
