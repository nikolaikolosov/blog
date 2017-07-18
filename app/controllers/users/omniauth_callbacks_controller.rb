class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte
    ap auth = request.env['omniauth.auth']

    @user = User.find_by(provider: auth.provider, uid: auth.uid)

    if @user.blank?
      @user = User.create(
          provider: auth.provider,
          uid: auth.uid,
          first_name: auth.info.first_name,
          last_name: auth.info.last_name,
          email: "#{auth.uid}@vkontakte-social.com",
          password: SecureRandom.hex(10),
          gender: auth.info.sex.eql?(1) ? :female : :male,
          birthday: Time.parse(auth.extra.raw_info.bdate),
          avatar: URI.parse(auth.extra.raw_info.photo_400_orig)
      )

      @user.add_role :user
    end

    sign_in(@user)

    redirect_to root_path
  end

  def failure
    flash[:warning] = "There was an error while trying to authenticate you..."
    redirect_to root_path
  end
end