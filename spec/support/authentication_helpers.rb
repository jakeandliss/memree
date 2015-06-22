module AuthenticationHelpers
  module Controller
    def sign_in(user)
       allow(controller).to receive(:current_user) { user }
    end
  end

  module Feature
    def sign_in(user, options={})
      visit "/login"
      fill_in "Email", with: user.email
      fill_in "Password", with: options[:password]
      click_button "Log In"
    end
  end
end