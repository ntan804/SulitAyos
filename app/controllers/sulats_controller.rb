class SulatsController < ApplicationController
def index #for received messages
    recipient_id = current_user.id
    @sulats = Sulat.where(:recipient_id => recipient_id).paginate(page: params[:page], :per_page => 10)
  end

  def index_sent
    sender_id = current_user.id
    @sulats = Sulat.where(:sender_id => sender_id).paginate(page: params[:page], :per_page => 10)
  # raise @sulats.to_yaml
  end

  def read
    recipient_id = current_user.id
    @temp = Sulat.where(:recipient_id => recipient_id)
    @sulats = @temp.where(:read => true).paginate(page: params[:page], :per_page => 10)
  end

  def unread
    recipient_id = current_user.id
    @temp = Sulat.where(:recipient_id => recipient_id)
    @sulats = @temp.where(:read => !true).paginate(page: params[:page], :per_page => 10)

  end

  def new
    if params[:product_id]
      @product = Product.where(id: params[:product_id]).first
      @recipient = @product.user
      @sulat = Sulat.new
      @sulat.subject = "Inquiry on #{@product.name}"
      @sulat.msgbody = "Good Day! I would like to inquire about #{@product.name} "

    else
      @recipient = User.where(id: params[:user_id]).first if params[:user_id]
      @sulat = Sulat.new
    end
  end

  def create
    @sulat = Sulat.new(params[:sulat])
    @sulat.sender_id = current_user.id 
    @sulat.save
    redirect_to index_sent_sulat_path(current_user.id)
  end

  def show
    @sulat = Sulat.find(params[:id])
    @sender = @sulat.sender
    @recipient = @sulat.recipient
    @sulat.read = true
    @sulat.save
  end

  def edit
    @sulat = Sulat.find(params[:id])
    @reply = @sulat.dup
    @reply.save
    @reply.read = false
    @reply.subject = "Re: #{@reply.subject}"
    @reply.msgbody = "Sent: #{@reply.created_at} #{@reply.msgbody}"
    @sender = @reply.sender
    @recipient = @reply.recipient
  end

  def update
    @sulat = Sulat.find(params[:id])
    @sulat.update_attributes(params[:mail])
    redirect_to index_sent_sulat_path(current_user.id)
  end

  def destroy
    Sulat.find(params[:id]).destroy
    redirect_to (:back)
  end
end
