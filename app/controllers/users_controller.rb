class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @tags = current_user.tags(:parent_id => params[:parent_id])
  end
  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = current_user
    @tags = current_user.tags
    @tag = current_user.tags.new
    case params[:form]
        when "profile"
          render  "update_profile"
        when "password"
          render "update_password"
        when "labels"
          render "update_labels"
        else
          render :action => :show
        end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to titles_path, success: 'Thanks for signing up!' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render template: 'pages/home' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar)
    end
end
