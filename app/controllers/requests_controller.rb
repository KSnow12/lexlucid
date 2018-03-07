class RequestsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_admin, only: [:destroy]

  def index
    @requests = Request.order('completed_at DESC').uncompleted
  end

  def new
    @request = Request.new(title: params[:name], url: params[:url])
  end

  def create
    @request = Request.new(request_params)

    if @request.save
      redirect_to documents_path, notice: "Your request has been sent. Thank You!"
    else
      render :new
    end
  end

  def destroy
    @request = Request.find(params[:id])

    if @request.destroy
      redirect_to documents_path, notice: "Request for contract was deleted."
    end
  end

  protected

    def request_params
      params.require(:request).permit(
        :title,
        :url
      )
    end
end
