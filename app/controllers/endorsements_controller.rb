class EndorsementsController < ApplicationController
  respond_to :html, :json
  
  def index
    @endorsement  = Endorsement.new
    @endorsements = Endorsement.visible.page params[:page]
  end

  def create
    Endorsement.create! params[:endorsement]
    redirect_to endorsements_path, notice: 'Your endorsement was succesfully saved'
  end
end
