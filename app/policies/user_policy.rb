class UserPolicy
  attr_reader :current, :model

  def initialize(current, model)
    @logged_user = current
    @user = model
  end

  def index?
    @logged_user.role == "master" || "manager"
  end

  def show?
    @logged_user.role == "master" || @logged_user == @user
  end

  def new?
    @logged_user.role == "master" || @logged_user.role == "manager" || @logged_user.role == "admin"
  end

  def create?
    @logged_user.role == "master" || @logged_user.role == "manager" || @logged_user.role == "admin"
  end

  def destroy?
    @logged_user.role == "master"
  end

  def edit?
    @logged_user.role == "master"
  end

  def update?
    @logged_user.role == "master"
  end

end
