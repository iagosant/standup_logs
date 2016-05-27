class UserPolicy
  attr_reader :current, :model

  def initialize(current, model)
    @logged_user = current
    @user = model
  end

  def index?
    @logged_user.role == "manager"
  end

  def show?
    @logged_user.role == "manager" || @logged_user == @user
  end
  def destroy?
    @logged_user.role == "manager"
  end

  def edit?
    @logged_user.role == "manager"
  end

  def new?

    @logged_user.role == "manager"
  end
end
