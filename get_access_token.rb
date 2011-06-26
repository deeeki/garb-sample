require File.expand_path('../boot', __FILE__)

consumer = OAuth::Consumer.new CONSUMER_KEY, CONSUMER_SECRET, {
	:signature_method   => 'HMAC-SHA1',
	:site               => 'https://www.google.com',
	:request_token_path => '/accounts/OAuthGetRequestToken',
	:authorize_path     => '/accounts/OAuthAuthorizeToken',
	:access_token_path  => '/accounts/OAuthGetAccessToken',
}

request_token = consumer.
	get_request_token({}, :scope => "https://www.google.com/analytics/feeds/")

print "access following url.\n"
print request_token.authorize_url
print "\nand input access code. >> \n"
ACCESS_CODE = STDIN.gets.gsub!(/\n/,'')

access_token = request_token.get_access_token(:oauth_verifier => ACCESS_CODE)

print "success! paste following code to config file.\n"
print "ACCESS_TOKEN = '" + access_token.token + "'\n"
print "ACCESS_SECRET = '" + access_token.secret + "'\n"
