require_relative 'requests'
require 'json'
include Requests

module API
  class Friend
    @id
    @first_name
    @last_name

    def initialize(id, first_name, last_name)
      @id = id
      @first_name = first_name
      @last_name = last_name
    end

    def self.get_friends(token)
      url = 'https://api.vk.com/method/friends.get'
      params = {'order' => 'hints', 'fields' => 'nickname', 'access_token' => token}
      request = PostRequest.new(url, params)
      response = request.request
      return parse_json response.body

    end


    def to_s
      "ID: #{@id}; First name: #{@first_name}; Last name: #{@last_name}."
    end

    private
    def self.parse_json(string)
      output = []
      json = JSON.parse(string)
      friends = json['response']
      friends.each do |friend|
        output << Friend.new(friend['uid'], friend['first_name'], friend['last_name'])
      end
      return output
    end
  end
end