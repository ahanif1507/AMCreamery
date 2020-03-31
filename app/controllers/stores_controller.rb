class StoresController < ApplicationController
  
  before_action :set_store
  
  def index
		@active_stores = Store.active
		@inactive_stores = Stores.inactive
  end
  
  def new
  end

  def create
  end
  
  private
    def set_store
      @store = Store.find(params[:id])
    end
    
    def store_params
      params.require(:store).permit(:name, :street, :city, :state, :zip, :phone, :active)
    end
  
end
