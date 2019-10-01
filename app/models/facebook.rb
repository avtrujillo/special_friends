class Facebook < ApplicationRecord
  belongs_to  :friend

  def self.from_auth_hash(auth_hash, friend_id = nil)
    # friend_id is only necessary when connecting a fb account for the first time
    # auth_hash documentation at:
    # https://github.com/mkdynamic/omniauth-facebook
    raise TypeError if friend_id && !friend_id.is_a?(Integer)
    user_token = auth_hash[:credentials][:token]
    koala_graph = Koala::Facebook::API.new(user_token)
    user_token, token_exp = token_exchange(user_token, koala_graph)
    auth = auth_hash_parse(auth_hash)
    fb = Facebook.find_or_initialize_by(id: auth[:uid]) # || Facebook.find_by(link: auth[:link])
    return false if (friend_id && fb.friend_id && (fb.friend_id != friend_id))
    # return false if the facebook profile is associated with anyone other than the current user
    fb.update(token: user_token, token_expiration: token_exp, email: auth[:email], id: auth[:uid],
              friend_id: (fb.friend_id || friend_id ||
                  analyst_friend_id(koala_graph)
              )
    )
    fb.save
    fb
  end

  def self.analyst_friend_id(koala_graph)
    # This is a hack to create a whitelist of facebook profiles.
    # Upon logging in for the first time, the user is asked for a list of pages
    # that they manage (the "pages_show_list" permission, which does not require app review).
    # If the user is has the "analyst" role on the Special-friends facebook page, we then search
    # for a Friend whose name matches the first name of the facebook profile used for login.
    # That facebook profile's friend_id is set to the id of the matching Friend
    first_name = koala_graph.get_object('me?fields=first_name')['first_name']
    connections = koala_graph.get_connection('me', 'accounts')
    has_page_role = connections.any?{|conn| conn['name'] == 'Special-friends'}
    analyst_friend = has_page_role ? Friend.find_by(name: first_name) : nil
    analyst_friend ? analyst_friend.id : nil
  end

  def self.auth_hash_parse(auth_hash)
    {
        link: auth_hash[:extra][:raw_info][:link],
        # link will currently always return nil; changing this would require app review
        # https://developers.facebook.com/docs/facebook-login/permissions/#reference-user_link
        email: auth_hash[:info][:email],
        uid: Integer(auth_hash[:uid]) # returns ArgumentError if uid is not an integer
    }
  end

  def self.token_exchange(short_term_token, koala_graph)
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
    expires_in = response['expires_in']
    expires_at = if expires_in
                   Time.now + response['expires_in']
                 else
                   koala_graph.debug_token(short_term_token)['expires_at']
                 end
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
