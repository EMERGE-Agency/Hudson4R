require 'net/http'
require 'uri'
require 'json'

=begin
  This modules purpose is two-fold. 
  It is meant to pull information 
  from Hudson and make it availible. 
  In addition, it should trigger 
  build using passed in parameters.
=end

module	Hudson4R
  class HudsonTool
    def initialize(server)
      @hudson = server
    end
    
    #Get the availible jobs and returns them in a hash. The job names are the key.
    def get_jobs
      jobs = {}
      get_api['jobs'].each do |job|
        jobs.store(job['name'],job)
      end
      jobs
    end
    
    def trigger_build(job_name, options = {})
      
    end
    
    
    def find_job(job_name)
      get_api['jobs'].detect{|job| job['name'].eql? job_name}
    end
    
    
    private
    def get_api
      url = URI.parse(@hudson + '/api/json')
      req = Net::HTTP::Get.new(url.path)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      JSON::Pure::Parser.new(res.body).parse
    end
  end
end
