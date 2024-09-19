class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def show
    @receiver = User.find(params[:id])
    @booking = Booking.find(params[:booking_id])

    @current_user = current_user
    @pet_owner = @booking.pet.user
    @pet_sitter = @booking.service.user

    if current_user == @pet_owner
      @receiver = @pet_sitter
      @sender = @pet_owner
    else
      @receiver = @pet_owner
      @sender = @pet_sitter
    end

    if @receiver.nil?
      redirect_to root_path, alert: "User not found"
    else
      @messages = Message.where(sender: [current_user, @receiver], receiver: [current_user, @receiver])
                          .or(Message.where(sender: [@receiver, current_user], receiver: [@receiver, current_user]))
                          .order(created_at: :asc)
      @message = Message.new
    end
  end
end
