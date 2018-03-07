class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:show, :new, :create, :login, :logout, :clear]
  before_action :require_admin, only: [:index, :destroy]
  before_action :require_admin_or_self, only: [:edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @requests = Request.order('completed_at DESC').uncompleted
  end

  # GET /users/new
  def new
    redirect_to root_path if logged_in?

    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        cookies.permanent[:email] = @user.email
        format.html { redirect_to documents_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def login
    if request.post?
      @user = User.where("lower(email) = :email", email: params[:email].to_s.downcase).first
      if @user.try(:authenticate, params[:password])
        session[:user_id] = @user.id
        cookies.permanent[:email] = @user.email
        redirect_to return_to_path || documents_path
      else
        flash[:notice] = "Bad username or password"
      end
    end
  end

  def logout
    reset_session
    redirect_to login_path
  end

  def clear
    reset_session
    cookies.clear
    redirect_to root_path
  end

  private
    def require_admin_or_self
      #raise "!#{require_admin} && #{current_user.id} != #{@user.id} = #{!require_admin && current_user.id != @user.id}"
      return true if current_user.admin? || current_user.id == @user.id
      flash[:error] = "You do not have permission to view that page"
      redirect_to root_path
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :website, :description, :company_name, :states, :attorney_registration_number)
    end
end
