module SessionsHelper

  def searchByUser(users)
    found_users = []
     users.each do |id|
       found_users << User.find(id)
     end
    found_users
  end

  def session_includes_user(found_sessions, users_found)
    # byebug
    @sessions_result = []
    found_sessions.each do |sn|
      # byebug
      users_found.each do |u|
        # byebug
        if sn.users.include?(u) && !@sessions_result.include?(sn)
          @sessions_result << sn
        end
      end
    end
    @sessions_result
    # byebug
  end

end
