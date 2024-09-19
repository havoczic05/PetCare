class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @booking = Booking.find(params[:booking_id])
    @message = Message.new(message_params)
    @current_user = current_user
    @message.sender_id = current_user.id
    @message.booking_id = @booking.id
    @other_user = current_user == @booking.pet.user ? @booking.service.user : @booking.pet.user
    @message.receiver_id = @other_user.id

    if @message.save
      # respond_to do |format|
        # format.html { redirect_to conversation_path(params[:conversation_id], booking_id: params[:booking_id]) }
        turbo_stream.prepend "booking_#{@booking.id}", partial: 'messages/message', locals: { current_user: @current_user, message: @message }
      # end
    else
      respond_to do |format|
        format.html { render "conversations/show" }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
