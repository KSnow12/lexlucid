class BulletPointsController < ApplicationController
  before_action :set_bullet_point, only: [:show, :edit, :update, :destroy]

  # GET /bullet_points
  # GET /bullet_points.json
  def index
    @bullet_points = BulletPoint.all
  end

  # GET /bullet_points/1
  # GET /bullet_points/1.json
  def show
  end

  # GET /bullet_points/new
  def new
    @bullet_point = BulletPoint.new
  end

  # GET /bullet_points/1/edit
  def edit
  end

  # POST /bullet_points
  # POST /bullet_points.json
  def create
    @bullet_point = BulletPoint.new(bullet_point_params)

    respond_to do |format|
      if @bullet_point.save
        format.html { redirect_to bullet_points_path, notice: 'Bullet point was successfully created.' }
        format.json { render :show, status: :created, location: @bullet_point }
      else
        format.html { render :new }
        format.json { render json: @bullet_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bullet_points/1
  # PATCH/PUT /bullet_points/1.json
  def update
    respond_to do |format|
      if @bullet_point.update(bullet_point_params)
        format.html { redirect_to @bullet_point, notice: 'Bullet point was successfully updated.' }
        format.json { render :show, status: :ok, location: @bullet_point }
      else
        format.html { render :edit }
        format.json { render json: @bullet_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bullet_points/1
  # DELETE /bullet_points/1.json
  def destroy
    @bullet_point.destroy
    respond_to do |format|
      format.html { redirect_to bullet_points_url, notice: 'Bullet point was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bullet_point
      @bullet_point = BulletPoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bullet_point_params
      params.require(:bullet_point).permit(:human_title, :human_description, :lawyer_title, :lawyer_description)
    end
end
