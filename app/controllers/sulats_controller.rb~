class MailsController < ApplicationController
def index #for received messages
    recipient_id = current_user.id
    @mails = Mail.where(:receiver_id => recipient_id).paginate(page: params[:page], :per_page => 10)
  end

  def index_sent
    sender_id = current_user.id
    @mails = Mail.where(:sender_id => sender_id).paginate(page: params[:page], :per_page => 10)
  
  end

  def read
    recipient_id = current_user.id
    @temp = Mail.where(:receiver_id => recipient_id)
    @mails = @temp.where(:read => true).paginate(page: params[:page], :per_page => 10)
  end

  def unread
    recipient_id = current_user.id
    @temp = Mail.where(:receiver_id => recipient_id)
    @mails = @temp.where(:read => !true).paginate(page: params[:page], :per_page => 10)

  end
 
  def new
    if params[:product_id]
      @product = Product.where(id: params[:product_id]).first
      @recipient = @product.user
      @mail = Mail.new
      @mail.subject = "Inquiry on #{@product.name}"
      @mail.msgbody = "Good Day! I would like to inquire about #{@product.name} "

    else
      @recipient = User.where(id: params[:user_id]).first if params[:user_id]
      @mail = Mail.new
    end

  end

  def create
    @mail = Mail.new(params[:mail])
    @mail.sender_id = current_user.id
    @mail.save
    redirect_to index_sent_mail_path(current_user.id)
  end

  def show
    @mail = Mail.find(params[:id])
    @sender = @mail.sender
    @recipient = @mail.receiver
    @mail.read = true
    @mail.save
  end

  def edit
    @mail = Mail.find(params[:id])
    @reply = @mail.dup
    @reply.save
    @reply.read = false
    @reply.subject = "Re: #{@reply.subject}"
    @reply.msgbody = "Sent: #{@reply.created_at} #{@reply.msgbody}"
    @sender = @reply.sender
    @recipient = @reply.receiver
  end

  def update
    @mail = Mail.find(params[:id])
    @mail.update_attributes(params[:mail])
    redirect_to index_sent_mail_path(current_user.id)
  end

  def destroy
    Mail.find(params[:id]).destroy
    redirect_to (:back)
  end
end
