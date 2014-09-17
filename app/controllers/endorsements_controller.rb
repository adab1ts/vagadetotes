class EndorsementsController < ApplicationController
  respond_to :html
  respond_to :json, only: :index
  
  # GET /manifesto
  def manifesto
    @endorsements_counter = Endorsement.count
  end
  
  # GET /endorsements
  # GET /endorsements.json
  def index
    @endorsement  = Endorsement.new
    @endorsements = Endorsement.visible.page params[:page]
    @endorsements_counter = Endorsement.count
  end

  # POST /endorsements
  def create
    @endorsement = Endorsement.new endorsement_params

    if @endorsement.save
      redirect_to endorsements_url, notice: t('endorsements.valid_endorsement')
    else
      @endorsements = Endorsement.visible.page "1"
      @endorsements_counter = Endorsement.count
      flash.now[:error] = t('endorsements.invalid_endorsement')
      render :index
    end
  end
  
  private
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def endorsement_params
    params.require(:endorsement).permit(
      :name,
      :lastname,
      :doctype,
      :docid,
      :email,
      :birthdate,
      :postal_code,
      :activity,
      :subscribed,
      :hidden,
      :group
    )
  end
end
