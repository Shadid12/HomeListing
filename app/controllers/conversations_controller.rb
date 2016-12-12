class ConversationsController < ApplicationController
    
    before_action :authenticate_user!
    
    def index
        @conversations = current_user.mailbox.conversations
    end
    
    def new
        @reciever = User.find(params[:reciever_id])
    end
    
    def create
        reciever = User.find(params[:user_id])
        recit = current_user.send_message(reciever, params[:body], params[:subject])
        redirect_to conversation_path(recit.conversation)
    end
    
    def show
        @conversation = current_user.mailbox.conversations.find(params[:id])
        @conversation.mark_as_read(current_user)
    end
end
