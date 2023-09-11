# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_signin, except: %i[new create]
  before_action :require_correct_user, only: %i[edit update]
  before_action :require_admin, only: [:destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.not_admins
  end

  def show
    @reviews = @user.reviews
    @favourite_movies = @user.favourite_movies
  end

  def new
    @user = User.new
  end

  def create
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Thanks for signing up!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Account updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to root_url, status: :see_other,
                          alert: 'Account successfully deleted!'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end

  def require_correct_user
    @user = User.find_by!(slug: params[:id])

    redirect_to root_url, status: :see_other unless current_user?(@user)
  end

  def set_user
    @user = User.find_by!(slug: params[:id])
  end
end
