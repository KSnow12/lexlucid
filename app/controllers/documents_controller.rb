class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :show, :find, :score]

  def index
    @documents = Document.search(params[:q])

    render layout: 'welcome'
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @summarized_ratings = @document.summarize_scores
  end

  # GET /documents/new
  def new
    @document = Document.new(name: params[:name], url: params[:url])

    if current_user.has_reviewed_document?(@document) && !current_user.admin?
      redirect_to document_path(@document), notice: "You have already reviewed that"
    end
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    if current_user.has_reviewed_document?(@document) && !current_user.admin?
      redirect_to document_path(@document), notice: "You have already reviewed that"
    end

    respond_to do |format|
      if @document.save
        format.html { redirect_to new_document_review_path(@document.id), notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update_attributes(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /documents/find.json?document_url=url
  def find
    @document = Document.find_by_url(params[:document_url])
    @review = Review.find_review_for(@document, cookies[:email])
  end

  # GET /documents/score.json?document_url=url
  def score
    @document = Document.find_by_url(params[:document_url])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:name, :url, :description, :version, :document_type_id, :company_name)
    end
end
