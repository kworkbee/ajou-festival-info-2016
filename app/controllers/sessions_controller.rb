class SessionsController < ApplicationController
  def new
    if logged_in? then
      redirect_to '/fest_manage'
    end
  end
  def create
   user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      flash[:indigo] = '멋쟁이사자처럼 여러분 환영합니다! 성공적으로 로그인되었습니다.'
      redirect_to '/fest_manage'
    else
      flash[:red] = 'Invalid email/password combination. Try again.' # Not quite right!
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
end
