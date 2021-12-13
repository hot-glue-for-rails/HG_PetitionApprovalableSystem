class Admin::PetitionsController < Admin::BaseController
  helper :hot_glue
  include HotGlue::ControllerHelper

  
  
  before_action :load_petition, only: [:show, :edit, :update, :destroy]
  after_action -> { flash.discard }, if: -> { request.format.symbol ==  :turbo_stream }



  

  



  def load_petition
    @petition = Petition.find(params[:id])
  end
  

  def load_all_petitions
    @petitions = Petition.page(params[:page])
  end

  def index
    load_all_petitions
    respond_to do |format|
       format.html
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def update
    if petition_params[:accept]
      begin
        res = @petition.accept!
        res = "Accepted." if res === true
        flash[:notice] = (flash[:notice] || "") <<  (res ? res + " " : "")
      rescue ActiveRecord::RecordInvalid => e
        @petition.errors.add(:base, e.message)
        flash[:alert] = (flash[:alert] || "") << 'There was ane error accepting your petition: '
      end
    end
    if petition_params[:reject]
      begin
        res = @petition.reject!
        res = "Rejected." if res === true
        flash[:notice] = (flash[:notice] || "") <<  (res ? res + " " : "")
      rescue ActiveRecord::RecordInvalid => e
        @petition.errors.add(:base, e.message)
        flash[:alert] = (flash[:alert] || "") << 'There was ane error rejecting your petition: '
      end
    end
    if @petition.update(modify_date_inputs_on_params(petition_params).tap{ |ary| ary.delete('accept') }.tap{ |ary| ary.delete('reject') })
      flash[:notice] = (flash[:notice] || "") << "Saved #{@petition.to_label}"
    else
      flash[:alert] = (flash[:alert] || "") << "Petition could not be saved."

    end
    load_all_petitions
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end



  def petition_params
    params.require(:petition).permit( [:user_id, :question1, :question2, :question3, :accepted_at, :rejected_at, :accept, :reject] )
  end

  def default_colspan
    6
  end

  def namespace
    "admin/" 
  end
end


