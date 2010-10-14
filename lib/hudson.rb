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
  class Hudson
    def initialize(server)
      @hudson = server
    end
    
    #Get the availible jobs and returns them in a hash. The hash keys are the job names.
    def get_jobs
      jobs = {}
      get_api['jobs'].each do |job|
        jobs.store(job['name'],job)
      end
      jobs
    end
    
    def get_queue
      hudson_request('/queue/api/json')
    end
    
    def trigger_build(job_name, options = {})
      if get_jobs.has_key? job_name
        if options.empty?
          hudson_request("/job/#{job_name}/build")
        else
          hudson_request("/job/#{job_name}/buildWithParameters", options)          
        end
      else
        false
      end
    end
    
    def find_job(job_name)
      get_api['jobs'].detect{|job| job['name'].eql? job_name}
    end
    
    private
    def get_api
      hudson_request('/api/json')
    end

    #This wraps the http calls and returns ruby data structures.
    def hudson_request(method, options = {})
      uri = URI.parse("#{@hudson}#{method}")
      unless options.empty?
        res = Net::HTTP::post_form(uri, options)
      else
        res = Net::HTTP.get_response(uri)
      end
      
      if res.code =~ /2\d\d/
        JSON::Pure::Parser.new(res.body).parse unless res.body.empty?
      elsif res.code =~ /3\d\d/
        true
      else 
        false
      end
    end
  end
end
