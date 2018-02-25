class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    redirect_to documents_path
    return
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    redirect_to document_path(@review.document.id)
  end

  # GET /reviews/new
  def new
    @document = Document.find(params[:document_id])
    @review = @document.reviews.build

    build_review_children
  end

  # GET /reviews/1/edit
  def edit
    @document = @review.document
    build_review_children
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @document = Document.find(params[:document_id])
    @review = @document.reviews.build(review_params)
    @review.user = current_user

    respond_to do |format|
      if @review.save
        format.html { redirect_to @document, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def build_review_children
      current_rating_count = @review.ratings.size
      (5 - current_rating_count).times do
        @review.ratings.build
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(
        :lawyer_id,
        :body,
        ratings_attributes: [
          :id,
          :score,
          :bullet_point_id,
          :description
        ]
      )
    end
end
