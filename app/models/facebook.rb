class Facebook < ApplicationRecord
  belongs_to  :friend

  def self.from_auth_hash(auth_hash, friend_id = nil)
    # friend_id is only necessary when connecting a fb account for the first time
    # auth_hash documentation at:
    # https://github.com/mkdynamic/omniauth-facebook
    auth_hash ||= request.env['omniauth.auth']
    fb = Facebook.find(auth_hash[:uid].to_i) || Facebook.new(link: auth_hash[:extra][:raw_info][:link],
                      email: auth_hash[:info][:email], friend_id: friend_id, id: auth_hash[:uid].to_i)
    token, token_exp = token_exchange(auth_hash[:credentials][:token])
    return false unless fb.friend_id == friend_id
    fb.update(token: token, token_expiration: token_exp)
    fb
  end

  def self.token_exchange(short_term_token)
    # https://developers.facebook.com/docs/facebook-login/access-tokens/portability
    response = HTTParty.get(
        'https://graph.facebook.com/{graph-api-version}/oauth/access_token',
        grant_type: 'fb_exchange_token',
        client_id: "#{ENV['FACEBOOK_KEY']}",
        client_secret: "#{ENV['FACEBOOK_SECRET']}",
        fb_exchange_token: "#{short_term_token}",
        appsecret_proof: appsecret_proof(short_term_token)
    ).body
    expires_at = response['expires_in'] + Time.now
    [response['access_token'], expires_at]
  end

  def self.appsecret_proof(token)
    # The app secret proof is a sha256 hash of your access token, using the app secret as the key
    # https://developers.facebook.com/docs/graph-api/securing-requests
    # remember to add this to the query string of all facebook api calls as appsecret_proof
    digest = OpenSSL::Digest::SHA256.new
    key = ENV['FACEBOOK_SECRET']
    OpenSSL::HMAC.hexdigest(digest, key, token)
  end

end
