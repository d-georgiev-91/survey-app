module Users
  class SessionsController < Devise::SessionsController
    def destroy
      if Devise.sign_out_all_scopes
        sign_out
      else
        sign_out(resource_name)
      end

      yield if block_given?
      respond_to_on_destroy
    end
  end
end
