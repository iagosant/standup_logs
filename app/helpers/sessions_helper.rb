module SessionsHelper

  def searchByUser(users)
    found_users = []
     users.each do |id|
       found_users << User.find(id)
     end
    found_users
  end

  def session_includes_user(found_sessions, users_found)
    @sessions_result = []
    found_sessions.each do |s|
      users_found.each do |u|
        if s.users.include?(u)
          @sessions_result << s
        end
      end
      @sessions_result
      byebug
    end
  end


end
