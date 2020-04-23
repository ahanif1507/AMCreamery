class ShiftJobsController < ApplicationController

  before_action :check_login 
  before_action :set_shift_job, only: [:edit, :show, :update]

  def new
		@shift_job = ShiftJob.new
	end

  def edit
  end

  def index
		@shift_jobs = ShiftJob.alphabetical.paginate(page: params[:page]).per_page(15)
  end

  def show
  end

  def create
    @shift_job = ShiftJob.new(shift_params)
		if @shift_job.save
			# if saved to database
			flash[:notice] = "Successfully added the shift: #{@shift_job}."
			redirect_to shift_job_path(@shift_job)
		else
			# return to the 'new' form
			render :action => 'new'
		end
  end

  def update
		if @shift_job.update_attributes(shift_job_params)
			flash[:notice] = "Successfully updated shift job to #{@shift_job}."
			redirect_to @shift_job
		else
			render :action => 'edit'
		end
  end
  
  def destroy
    @shift_job.destroy
    flash[:notice] = "Removed shift_job from the system."
    redirect_to shift_jobs_url
  end


  private
    def set_shift_job
      @shift = Shift.find(params[:id])
    end

    def shift_job_params
      params.require(:shift_job).permit(:job_id, :shift_id) 
    end

end
end
