class RegistrationsController < Devise::RegistrationsController

  def create
    super
    if @user.persisted?
      UserMailer.welcome(@user).deliver_now
    end
  end

  protected

  def after_update_path_for(resource)
    user_path(current_user)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
