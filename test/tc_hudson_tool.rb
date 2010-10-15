require 'pp'
require 'yaml'
require 'rubygems'
gem 'test-unit'
require 'test/unit'
$LOAD_PATH << './lib'
require 'lib/hudson'

class TC_Hudson4R_HudsonTool < Test::Unit::TestCase
  def setup
    @fixtures = YAML.load_file("test/fixtures.yaml")
    @hudson = Hudson4R::Hudson.new(@fixtures['hudson_server'])
  end
  
  def test_get_jobs
    result = @hudson.get_jobs
    assert_kind_of(Hash, result)
    assert(result[@fixtures['known_job'].first])
  end
  
  def test_get_queue
    result = @hudson.get_queue
    assert(result.has_key? 'items')
  end
  
  def test_trigger_build_good_job_with_params
    assert(@hudson.trigger_build(*@fixtures['known_job_with_params']))
  end
  
  def test_trigger_build_good_job_without_params
    assert(@hudson.trigger_build(@fixtures['known_job'].first))
  end
  
  def test_trigger_build_bad_job
    assert_false(@hudson.trigger_build(@fixtures['non_existent_job']))
  end
  
  def test_find_job
    result = @hudson.find_job(@fixtures['known_job'].first)
    assert_equal(result['name'], @fixtures['known_job'].first)
  end
  
  def teardown
    @hudson = nil
  end
end
