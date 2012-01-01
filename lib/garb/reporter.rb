require 'yaml'

module Garb
  class Reporter
    def initialize(web_property_id = nil)
      @web_property_id = web_property_id
      consumer = OAuth::Consumer.new config['consumer_key'], config['consumer_secret'], {
        :signature_method   => 'HMAC-SHA1',
        :site               => 'https://www.google.com',
        :request_token_path => '/accounts/OAuthGetRequestToken',
        :authorize_path     => '/accounts/OAuthAuthorizeToken',
        :access_token_path  => '/accounts/OAuthGetAccessToken',
      }
      access_token = OAuth::AccessToken.new(consumer, config['access_token'], config['access_secret'])
      Garb::Session.access_token = access_token
    end

    def profile
      @profile ||= Garb::Management::Profile.all.detect do |p|
        p.web_property_id == (@web_property_id || config['web_property_id'])
      end
    end

    def config
      @config ||= YAML.load_file 'config/garb.yml'
    end
  end
end
