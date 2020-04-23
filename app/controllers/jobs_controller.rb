class JobsController < ApplicationController

  before_action :check_login 
  before_action :set_job, only: [:edit, :show, :update]

  def new
		@job = Job.new
	end

  def edit
  end

  def index
		@jobs = Job.alphabetical.paginate(page: params[:page]).per_page(15)
  end

  def show
  end

  def create
    @job = Job.new(job_params)
		if @job.save
			# if saved to database
			flash[:notice] = "Successfully add the job: #{@job.name}."
			redirect_to job_path(@job)
		else
			# return to the 'new' form
			render :action => 'new'
		end
  end

  def update
		if @job.update_attributes(job_params)
			flash[:notice] = "Successfully updated Job: #{@job.name}."
			redirect_to @job
		else
			render :action => 'edit'
		end
  end
  
  def destroy
    @job.destroy
    flash[:notice] = "Removed job from the system."
    redirect_to jobs_url
  end
  
  private
    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:name, :description, :active) 
    end

end
