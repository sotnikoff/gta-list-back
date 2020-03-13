class ApplicationController < ActionController::API
  class NotAuthenticated < StandardError
  end

  rescue_from NotAuthenticated, with: :not_authenticated

  protected

  def authenticate_user!
    @current_user = UserToken.user_by_token(request.headers['Authorization'])
    raise NotAuthenticated if @current_user.blank?
  end

  def current_user
    return nil if request.headers['Authorization'].blank?

    @current_user ||= UserToken.user_by_token(request.headers['Authorization'])
  end

  private

  def not_authenticated
    render json: { error: 'not_authenticated' }, status: 401
  end
end
