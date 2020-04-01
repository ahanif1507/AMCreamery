class StoresController < ApplicationController
  
  before_action :set_store, only: [:edit, :update, :show]
  
  def index
		@active_stores = Store.active
		@inactive_stores = Store.inactive
  end
  
  def show
    @current_managers =  Assignment.current.for_store(@store.id).for_role("manager").map!{|a| a.employee}
    @current_employees = Assignment.current.for_store(@store.id).for_role("employee").map!{|a| a.employee}
  end
  
  def new
      @store = Store.new
  end

  def create
       @store = Store.new(store_params)
    if @store.save
      # if saved to database
      flash[:notice] = "Successfully added #{@store.name} as a store"
      redirect_to store_path(@store) # go to show store page
    else
      # return to the 'new' form
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
      if @store.update_attributes(store_params)
      flash[:notice] = "Updated store information for #{@store.name}."
      redirect_to @store
    else
      render action: 'edit'
    end
  end
  
  private
    def set_store
      @store = Store.find(params[:id])
    end
    
    def store_params
      params.require(:store).permit(:name, :street, :city, :state, :zip, :phone, :active) 
    end
  
end
