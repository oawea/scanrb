require 'net/ssh'
require 'celluloid'

#need to clean up a whole bunch of code, and also start commenting out..
#sorry i've been lazy


module SSHBrute
  class SECSH
    include Celluloid
    def initialize host, options={}
      @host = host
      @parsed = 0
      parse_options options
    end
    def parse_options object
      if object[:userfile]
        @userfile = object[:userfile]
      elsif object[:username]
        @username = object[:username]
      elsif object[:password]
        @password = object[:password]
      elsif object[:passfile]
        @passfile = object[:passfile]
      elsif object[:portno]
        @portno = object[:portno]
      end
      @parsed += 1
      if @parsed > object.length
        raise ArgumentError, "invalid argument somewhere. fix later!"
      end
    end
    def load
      begin
        Net::SSH.start(@host, @user, :password=>@password, :number_of_password_prompts=>0) do |ssh|
          puts "connected with #{@user}:#{@password}"
        end
      rescue Exception => e
        return false
      end
    end
  end
end


a = SSHBrute::SECSH.new('localhost', :username=>'michael', :password=>'pokemon123')
