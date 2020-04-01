class AssignmentsController < ApplicationController
  
  before_action :set_assignment, only: [:destroy]
  
  def index
      @current_assignments = Assignment.current.chronological
	  @past_assignments = Assignment.past.chronological
  end
  
  def new
      @assignment = Assignment.new
  end

  def create 
      @assignment = Assignment.new(assignment_params) 
    if @assignment.save
      # if saved to database
      flash[:notice] = "Successfully added the assignment."
      redirect_to assignments_url 
    else
      # return to the 'new' form
      render action: 'new'
    end
  end
  
  def terminate
      @assignment = Assignment.terminate
  end
  
  def destroy
    @assignment.destroy
    flash[:notice] = "Removed assignment from the system."
    redirect_to assignments_url
  end
  
  private
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end
    
    def assignment_params
      params.require(:assignment).permit(:store_id, :employee_id, :start_date, :end_date)
    end

end
