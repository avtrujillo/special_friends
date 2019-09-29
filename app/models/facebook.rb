class Facebook < ApplicationRecord
  belongs_to  :friend

  def from_auth_hash(auth_hash)
    # auth_hash documentation at:
    # https://github.com/mkdynamic/omniauth-facebook
    auth_hash ||= request.env['omniauth.auth']
    token, token_exp = token_exchange(auth_hash[:credentials][:token])
    fb = Facebook.new(link: auth_hash[:extra][:raw_info][:link], token: token,
                      token_expiration: token_exp, email: auth_hash[:info][:email])
    fb.id = auth_hash.uid
    fb.save
  end

  def token_exchange(short_term_token)
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

  def appsecret_proof(token)
    # The app secret proof is a sha256 hash of your access token, using the app secret as the key
    # https://developers.facebook.com/docs/graph-api/securing-requests
    # remember to add this to the query string of all facebook api calls as appsecret_proof
    digest = OpenSSL::Digest::SHA256.new
    key = ENV['FACEBOOK_SECRET']
    OpenSSL::HMAC.hexdigest(digest, key, token)
  end

  def long_term_token_expiration()

end
