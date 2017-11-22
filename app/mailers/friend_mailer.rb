class FriendMailer < ApplicationMailer
  def fm_notification(fm)
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = notification_params(fm)
    mg_client.send_message ENV['domain'], message_params
  end

  def test_email
    mg_client = Mailgun::Client.new ENV['api_key']
    {
      from: "messenger_bot@#{Rails.application.secrets.mailgun_domain}",
      to: Rails.application.secrets.my_email,
      subject: "mailer test",
      text: "Test was a success"
    }
  end

  private

  def notification_params(fm)
    {
      from: "messenger_bot@#{Rails.application.secrets.mailgun_domain}",
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
