class FriendMailer < ApplicationMailer
  def fm_notification(fm)
    mg_client = Mailgun::Client.new Rails.application.secrets.private_mailgun_api
    message_params = notification_params(fm)
    mg_client.send_message Rails.application.secrets.mailgun_domain, message_params
  end

  def test_email
    mg_client = Mailgun::Client.new Rails.application.secrets.private_mailgun_api
    mg_events = Mailgun::Events.new(mg_client, mailgun_domain)
    message_params = {
      from: "messenger_bot@#{mailgun_domain}",
      to: Rails.application.secrets.my_email,
      subject: "mailer test",
      text: "Test was a success"
    }
    mg_client.send_message mailgun_domain, message_params
  end

  private

  def mailgun_domain
    Rails.application.secrets.mailgun_domain
  end

  def notification_params(fm)
    {
      from: "special_friends_messenger@#{mailgun_domain}",
      to: fm.recipient.email,
      subject: notification_subject(fm),
      text: notification_text(fm)
    }
  end

  def notification_subject(fm)
    if fm.recipient == fm.match_recipient
      'You have a new message from your giver.'
    elsif fm.recipient == fm.match_giver
      "You have a new message from your recipient #{fm.match_recipient}."
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
