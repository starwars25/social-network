require 'net/https'
require 'uri'

module Requests
  class GetRequest
    def initialize(url, headers=nil)
      @url = url
      @headers = headers
    end
    @url
    @headers

    def request
      uri = URI.parse(@url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      get_request = Net::HTTP::Get.new(uri.request_uri, @headers)
      http.request(get_request)
    end
  end



  class PostRequest
    def initialize(url, params=nil, cookies=nil)
      @url = url
      @params = params
      @cookies = cookies
    end
    @url
    @headers
    @cookies



    def request
      uri = URI.parse(@url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(@params)
      request['Cookie'] = @cookies
      # request.each_header do |key, value|
      #   puts "#{key}: #{value}"
      # end
      # puts request.body
      response = http.request request
      # puts 'Response headers'
      # response.each_header do |key, value|
      #   puts "#{key}: #{value}"
      # end
      return response

    end
  end


end