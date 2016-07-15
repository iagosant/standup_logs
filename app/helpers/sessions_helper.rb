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
    found_sessions.each do |sn|
      users_found.each do |u|
        if sn.users.include?(u) && !@sessions_result.include?(sn)
          @sessions_result << sn
        end
      end
    end
    @sessions_result
  end

end
