  json.id    message.id
  json.subject message.subject
  json.user_id message.user.try(:id)
