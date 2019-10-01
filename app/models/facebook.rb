class Facebook < ApplicationRecord
  belongs_to  :friend

  def self.from_auth_hash(auth_hash, friend_id = nil)
    # friend_id is only necessary when connecting a fb account for the first time
    # auth_hash documentation at:
    # https://github.com/mkdynamic/omniauth-facebook
    raise TypeError if friend_id && !friend_id.is_a?(Integer)
    auth = auth_hash_parse(auth_hash)
    fb = Facebook.find_by(id: auth[:uid]) || Facebook.find_by(link: auth[:link]) || Facebook.new
    fb.update(link: auth[:link], email: auth[:email], id: auth[:uid])
    token, token_exp = token_exchange(auth_hash[:credentials][:token])
    return false if (friend_id && fb.friend_id && (fb.friend_id != friend_id))
    # return false if the facebook profile is associated with anyone other than the current user
    fb.update(token: token, token_expiration: token_exp, friend_id: (fb.friend_id || friend_id))
    fb
  end

  def self.auth_hash_parse(auth_hash)
    {
        link: auth_hash[:extra][:raw_info][:link],
        email: auth_hash[:info][:email],
        uid: Integer(auth_hash[:uid]) # returns ArgumentError if uid is not an integer
    }
  end

  def self.token_exchange(short_term_token)
    # https://developers.facebook.com/docs/facebook-login/access-tokens/portability
    uri = URI('https://graph.facebook.com/v4.0/oauth/access_token')
    params = {
        grant_type: 'fb_exchange_token',
        client_id: "#{ENV['FB_APP_ID']}",
        client_secret: "#{ENV['FB_APP_SECRET']}",
        fb_exchange_token: "#{short_term_token}",
        appsecret_proof: appsecret_proof(short_term_token)
    }
    uri.query = URI.encode_www_form(params)
    response = JSON.parse(Net::HTTP.get_response(uri).body)
    expires_at = Time.now + response['expires_in']
    [response['access_token'], expires_at]
  end

  def self.appsecret_proof(token)
    # The app secret proof is a sha256 hash of your access token, using the app secret as the key
    # https://developers.facebook.com/docs/graph-api/securing-requests
    # remember to add this to the query string of all facebook api calls as appsecret_proof
    digest = OpenSSL::Digest::SHA256.new
    key = ENV['FB_APP_SECRET']
    OpenSSL::HMAC.hexdigest(digest, key, token)
  end

end
