class SessionsController < ApplicationController

  
  before_filter :not_signed_user, only: [:create, :new]

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user

    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def new
  end

  def destroy
    sign_out
    redirect_to '/signin' 
  end
  
  private

    def not_signed_user
         redirect_to root_path if signed_in? 
    end
end
      
      
      