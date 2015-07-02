require 'net/https'
require 'uri'
require 'nokogiri'
require_relative 'requests'

module Authentication
  class Auth
    def initialize
      @cookies = []
      @params = Hash.new
    end

    @cookies = []
    @params
    @post_url

    def self.hello
      puts "Hello, world"
    end

    def authenticate(email, password)
      get_home
      res = post_home email, password
    end

    private
    def get_home
      string_url = "https://oauth.vk.com/authorize?client_id=4615047&scope=messages,friends,audio,wall,photos,groups,stats,ads&redirect_uri=https://oauth.vk.com/blank.html&display=page&v=5.34&response_type=token"

      request = Requests::GetRequest.new(string_url)
      response = request.request
      save_cookies response.get_fields 'Set-Cookie'
      parse_html response.body
      @post_url = Nokogiri::HTML(response.body).css('form')[0].attributes['action'].value

    end

    def save_cookies(cookies)
      cookies.each do |cookie|
        @cookies << cookie.split(';')[0]
      end
    end

    def parse_html(html)
      html_doc = Nokogiri::HTML(html)
      inputs = html_doc.css 'input'
      inputs.each do |input|
        if is_hidden? input
          @params[input.attributes['name'].value] = input.attributes['value'].value
        end
      end
    end

    def is_hidden?(element)
      attrs = element.attributes
      (attrs['type'].value == 'hidden') ? true : false
    end

    def form_cookies
      output = ""
      counter = 0
      @cookies.each do |cookie|
        if counter == 0
          output += cookie;
        elsif counter == @cookies.size - 1
          output += "; #{cookie}"
        else
          output += "; #{cookie}"
        end
        counter += 1

      end
      return output
    end

    def post_home(email, pass)
      # uri = URI.parse(@post_url)
      # http = Net::HTTP.new(uri.host, uri.port)
      # http.use_ssl = true
      # request = Net::HTTP::Post.new(uri.request_uri)
      # @params['email'] = email
      # @params['pass'] = pass
      # headers = {'Cookie' => form_cookies}
      # request.set_form_data(@params, headers)
      # response = http.request(request)
      #
      # save_cookies response.get_fields 'Set-Cookie'
      # uri = URI.parse(response['Location'])
      # http = Net::HTTP.new(uri.host, uri.port)
      # http.use_ssl = true
      # response = http.request(Net::HTTP::Get.new(uri.request_uri))
      # uri = URI.parse(response['Location'])
      # http = Net::HTTP.new(uri.host, uri.port)
      # http.use_ssl =true
      # headers = {'Cookie' => form_cookies}
      # response = http.request(Net::HTTP::Get.new(uri.request_uri, headers))
      # puts response

      headers = {'Cookie' => form_cookies}
      @params['email'] = email
      @params['pass'] = pass
      request = Requests::PostRequest.new(@post_url, @params, form_cookies)
      # request['Cookie'] = form_cookies
      response = request.request
      save_cookies response.get_fields 'Set-Cookie' unless response.get_fields('Set-Cookie').nil?
      headers = {'Cookie' => form_cookies}
      request = Requests::GetRequest.new(response['Location'], headers)
      response = request.request
      save_cookies response.get_fields 'Set-Cookie' unless response.get_fields('Set-Cookie').nil?

      if response.code.to_i < 300
        return permit(response.body)

      end
      headers = {'Cookie' => form_cookies}
      request = Requests::GetRequest.new(response['Location'], headers)
      response = request.request
      save_cookies response.get_fields 'Set-Cookie' unless response.get_fields('Set-Cookie').nil?
      token = get_token response['Location']
      # puts response['Location']
      return token

    end

    def get_token(url)
      begin
        string = url.split('#')[1]
        string = string.split('&')[0]
        return string.split('=')[1]
      rescue
        return 'error'
      end

    end

    def permit(body)
      File.open('permit.html', 'w') { |file| file.write(body) }
      url = parse_permit body
      headers = {'Cookie' => form_cookies}
      request = Requests::GetRequest.new(url, headers)
      response = request.request
      get_token response['Location']

    end

    def parse_permit(body)


      Nokogiri::HTML(body).css('form')[0].attributes['action'].value


    end

  end
end