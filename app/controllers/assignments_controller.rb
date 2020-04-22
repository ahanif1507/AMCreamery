class AssignmentsController < ApplicationController
  
  before_action :set_assignment, only: [:destroy, :terminate]
  
  def index
      @current_assignments = Assignment.current.chronological.paginate(page: params[:page]).per_page(15)
	  @past_assignments = Assignment.past.chronological.paginate(page: params[:page]).per_page(15)
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
    if @assignment.terminate
      redirect_to assignments_path, notice: "Assignment for #{@assignment.employee.proper_name} terminated."
    end
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
      params.require(:assignment).permit(:store_id, :employee_id, :start_date)
    end

end