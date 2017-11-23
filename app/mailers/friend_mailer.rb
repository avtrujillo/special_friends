class FriendMailer < ApplicationMailer
  def fm_notification(fm)
    mg_client = Mailgun::Client.new ENV['PRIVATE_MAILGUN_API']
    message_params = notification_params(fm)
    mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params
  end

  def test_email
    mg_client = Mailgun::Client.new ENV['PRIVATE_MAILGUN_API']
    message_params = {
      from: "messenger_bot@#{ENV['MAILGUN_DOMAIN']}",
      to: ENV['MY_EMAIL'],
      subject: "mailer test",
      text: "Test was a success"
    }
    mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params
  end

  def test_second_email
    mg_client = Mailgun::Client.new ENV['PRIVATE_MAILGUN_API']
    message_params = {
      from: "messenger_bot@#{ENV['MAILGUN_DOMAIN']}",
      to: ENV['SECOND_EMAIL'],
      subject: "mailer test",
      text: "Test was a success"
    }
    mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params
  end

  def test_with_parameter(test_address)
    mg_client = Mailgun::Client.new ENV['PRIVATE_MAILGUN_API']
    message_params = {
      from: "messenger_bot@#{ENV['MAILGUN_DOMAIN']}",
      to: Friend.find_by(name: 'Jesse').email,
      subject: "mailer test",
      text: "Test was a success"
    }
    mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params
  end

  def test_email_jesse
    mg_client = Mailgun::Client.new ENV['PRIVATE_MAILGUN_API']
    message_params = {
      from: "messenger_bot@#{ENV['MAILGUN_DOMAIN']}",
      to: Friend.find_by(name: 'Jesse').email,
      subject: "mailer test",
      text: "Test was a success"
    }
    mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params
  end

  private

  def notification_params(fm)
    {
      from: "special_friends_messenger@#{ENV['MAILGUN_DOMAIN']}",
      to: fm.recipient.email,
      subject: notification_subject(fm),
      text: notification_text(fm)
    }
  end

  def notification_subject(fm)
    if fm.recipient == fm.match_recipient
      'You have a new message from your giver.'
    elsif fm.recipient == fm.match_giver
      "You have a new message from your recipient #{fm.match_recipient.name}."
    else
      raise 'invalid recipient'
    end
  end

  def notification_text(fm)
    if fm.recipient == fm.match_recipient
      'You have a new message from your giver.' +
      "View it at #{Rails.root}/friend_messages/#{fm.id} or view your full" +
      "correspondence at #{Rails.root}/messages_as_recipient."
    elsif fm.recipient == fm.match_giver
      "You have a new message from your recipient #{fm.match_recipient}." +
      "View it at #{Rails.root}/friend_messages/#{fm.id} or view your full" +
      "correspondence at #{Rails.root}/messages_as_giver."
    else
      raise 'invalid recipient'
    end
  end

end
