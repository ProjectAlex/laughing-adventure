class MessagesController < ApplicationController
 
 before_filter :set_user
 
 def index
   
 #if params[:mailbox] == "sent"
 #@messages = @user.sent_messages
 #elsif params[:mailbox] == "inbox"
 @messages = @user.received_messages
 #@messages = Message.all
 #@messages = Message.where(:recepient_id => @user.id).all
 #elsif params[:mailbox] == "archieved"
 # @messages = @user.archived_messages
 #end
 end
 
 def unreadcount
  @count = current_user.unread_message_count
  render :text => '<span class="unreadmessages badge">'+@count.to_s+'</span>'
 end
 
 def sent   
 @sent_messages = @user.sent_messages
 end
 
 def new
 debugger
 @message = Message.new
 if params[:reply_to]
 @reply_to = User.find_by_user_id(params[:reply_to])
 unless @reply_to.nil?
 @message.recepient_id = @reply_to.user_id
 end
 end
 debugger
 end
 
 def create
 @message = Message.new(params[:message].permit(:recepient_id,:subject,:body))
 @message.sender_id = current_user.id

 @message.sent_at = Time.now
 if @message.save
 flash[:notice] = "Message has been sent"
 #redirect_to user_messages_path(current_user, :mailbox=>:inbox)
 redirect_to root_path
 else
 render :action => :new
 end
 end
 
 def reply
 @reply_message = Message.new(params[:message].permit(:subject,:body))
 @reply_message.recepient_id = Message.friendly.find(params[:id]).sender_id
 @reply_message.sender_id = current_user.id
 @reply_message.sent_at = Time.now
 if @reply_message.save
 flash[:notice] = "Message has been sent"
 #redirect_to user_messages_path(current_user, :mailbox=>:inbox)
 redirect_to root_path
 else
 render :action => :new
 end
 end
 
def show
 @message = Message.readingmessage(params[:id],@user.id)
 end
 
 def trash
   @message=Message.friendly.find(params[:id])
   @message.destroy 
   redirect_to messages_path
 end
 
 def delete_multiple
 if params[:delete]
 params[:delete].each { |id|
 @message = Message.friendly.find(id)
 @message.mark_message_deleted(@message.id,@user.user_id) unless @message.nil?
 }
 flash[:notice] = "Messages deleted"
 end
 redirect_to user_messages_path(@user, @messages)
 end
 
 private
 def set_user
 @user = current_user
 end
end
