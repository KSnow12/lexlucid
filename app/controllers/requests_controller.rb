class RequestsController < ApplicationController
  skip_before_action :require_login, only: [:new]
  before_action :require_admin, only: [:index]

  def index
    @requests = Request.uncompleted.order('completed_at DESC')
  end

  def new
    @request = Request.new(title: params[:title], url: params[:url])
  end

  def create
    @request = Request.new(request_params)

    if request.save
      redirect_to documents_path, notice: "Your request has been sent. Thank You!"
    else
      render :new
    end
  end

  protected

    def request_params
      params.require(:request).permit(
        :title,
        :url,
        :description
      )
    end
end
