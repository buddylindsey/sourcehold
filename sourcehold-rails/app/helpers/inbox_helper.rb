module InboxHelper
  def parent(message)
    if(message.parent.nil?)
      return message.id
    else
      return message.parent
    end
  end
end
