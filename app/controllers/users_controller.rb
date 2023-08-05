class UsersController < ApplicationController
  before_action :set_user, only: %i[ edit update destroy ]

  # GET /users or /users.json
  def index
    @users = Rails.cache.fetch('all_users_with_address', expires_in: 1.hour) do
      puts "Fetching data from the database"
      User.includes(:address).all
    end
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.cached_user(params[:id])
  end

  def import
    if params[:file].present?
      User.import_users_from_csv(params[:file])
      flash[:success] = 'Users imported successfully.'
    else
      flash[:error] = 'Please select a CSV file to import.'
    end
    redirect_to users_path
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end