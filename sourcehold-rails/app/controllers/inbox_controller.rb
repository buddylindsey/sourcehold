class InboxController < ApplicationController
  before_filter :authenticate_user!

  def index
    @messages = Message.find_all_by_to_id(current_user.id)
  end

  def new
  end

  def create

    hash = ["user_id" => current_user.id,
            "to_id" => User.find_by_username(params[:user_to]).id,
            "subject" => params[:subject],
            "body" => params[:body]]

    if(Message.create(hash))
      flash[:notice] = "The message was sent successfully"
    end
    redirect_to :action => "sent"
  end

  def sent
    @messages = Message.find_all_by_user_id(current_user.id)
  end

  def show
    @parent = Message.find(params[:id])

    @child_messages = Message.find_all_by_parent(@parent.id)
  end

  def reply
    message = Message.find(params[:parent])
    new_message = Message.new
    new_message.user_id = current_user.id
    new_message.parent = params[:parent]
    new_message.subject = "RE: #{message.subject}"
    new_message.body = params[:reply_field]

    if(current_user.id == message.user_id)
      new_message.to_id = message.to_id
    else
      new_message.to_id = message.user_id
    end

    if(new_message.save)
      redirect_to "/inbox/message/#{message.id}/"
    else
      flash[:notice] = "Something went wrong you reply wasn't added"
      redirect_to "/inbox/message/#{message.id}/"
    end
  end
end
