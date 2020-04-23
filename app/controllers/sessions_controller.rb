class SessionsController < ApplicationController
  def new
    # rendering the view
  end

  def create
    employee = Employee.authenticate(params[:username], params[:password])
    if employee # the employee exists and authentication is successful
      session[:employee_id] = employee.id 
      # flash[:notice]='Logged in!'
      redirect_to home_path, notice: 'Logged in!'
    else 
      flash.now.alert = "Username and/or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:employee_id] = nil
    redirect_to home_path, notice: 'Logged out!'
  end
end

