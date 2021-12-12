class PetitionsController < ApplicationController
  helper :hot_glue
  include HotGlue::ControllerHelper

  before_action :authenticate_user!
  
  before_action :load_petition, only: [:show, :edit, :update, :destroy]
  after_action -> { flash.discard }, if: -> { request.format.symbol ==  :turbo_stream }



  

  



  def load_petition
    @petition = current_user.petitions.find(params[:id])
  end
  

  def load_all_petitions
    @petitions = current_user.petitions.page(params[:page])
  end

  def index
    load_all_petitions
    respond_to do |format|
       format.html
    end
  end

  def new 
    @petition = Petition.new(user: current_user)
   
    respond_to do |format|
      format.html
    end
  end

  def create
    modified_params = modify_date_inputs_on_params(petition_params.dup.merge!(user: current_user ) , current_user)
    @petition = Petition.create(modified_params)

    if @petition.save
      flash[:notice] = "Successfully created #{@petition.to_label}"
      load_all_petitions
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to petitions_path }
      end
    else
      flash[:alert] = "Oops, your petition could not be created."
      respond_to do |format|
        format.turbo_stream
        format.html
      end
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def destroy
    begin
      @petition.destroy
    rescue StandardError => e
      flash[:alert] = "Petition could not be deleted"
    end
    load_all_petitions
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to petitions_path }
    end
  end

  def petition_params
    params.require(:petition).permit( [:question1, :question2, :question3] )
  end

  def default_colspan
    3
  end

  def namespace
    ""
  end
end


