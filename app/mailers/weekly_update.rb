class WeeklyUpdate < ApplicationMailer

  default from: 'sgarzaceja@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.weekly_update.wips.subject
  #

  def sample_email(user)
      @user = user
      mail(to: @user.email, subject: 'Sample Email')

    end


  def get_date

    @dow = Time.now.strftime("%I%M")
    if @dow  == "0147"
      wips
    end

  end

  def all_users

    @users = User.all

  end

  def wips

    User.find_each do |user|
    @email = user.email
    @blockers = user.blockers.last
    WeeklyUpdate.deliver_now
    mail to: @email, subject: "these are your blockers"
    end

  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.weekly_update.completeds.subject
  #
  def completeds
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.weekly_update.blockers.subject
  #
  def blockers
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

end
