def sf_radio_button(recipient)
  "<input type=\"radio\" value=\"#{recipient.id}\" name=\"gift[recipient_id]\" id=\"gift_recipient_id_#{recipient.id}\" onclick=\"document.getElementById(#{recipient.name}wishes).style.display='block'\" />".html_safe
end
