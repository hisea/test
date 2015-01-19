json.messages @messages do |message|
  json.id    message.id
  json.subject message.subject

  json.user_id message.user ? message.user.id : nil
end