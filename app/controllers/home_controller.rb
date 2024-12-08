class HomeController < ApplicationController
  def index
  end

  def contacts
    @feedback = Feedback.new
  end

  def create_feedback
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      redirect_to contacts_path, notice: "Thank you for your feedback!"
    else
      render :contacts, status: :unprocessable_entity
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:name, :email, :message)
  end
end