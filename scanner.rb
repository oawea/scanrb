$LOAD_PATH << "."
require "lib/portscan.rb"
require "lib/bruteforce.rb"

module CLI
  def initialize
    puts "Welcome to ruby port scanner v.01"
    puts "Programmed by oawea"
    @hosts = []
    interface
  end
  def interface
    print ">> "
    cmd = $stdin.gets.chomp
    load_opts cmd
  end
  def set_ports
    
  end
  def load_opts cmd
    if cmd === "help"
      puts "commands are as follows"
      puts "load hosts -> load hosts from stdin or file "
      puts "scan       -> begin the scanning process"
      puts "get hosts  -> download 10,000 random domains"
      puts "set port   -> set/add ports for all hosts "
      puts "bruteforce -> bruteforce host(s)"
      puts "help       -> show this screen"
      interface
    end
    if cmd === "get hosts"
      get_random_domains
    end
    if cmd === "load hosts"
      get_deets
    end
    if cmd === "scan"
      scanner = PortScanner.new(@hosts)
    end
    if cmd === "bruteforce"
      if @pfile === nil || @ufile === nil
        print "Enter full path for username file: "
        @ufile = $stdin.gets.chomp
        print "Enter full path for password file: "
        @pfile = $stdin.gets.chomp
        BruteForcer.new(@pfile, @ufile)
      else
        BruteForcer.new(@pfile, @ufile)
      end
    end
    if cmd === "exit"
      return
    end
    if cmd === "show hosts"
      show_hosts
    end
    interface
  end
  def get_deets
    print "Load hosts/ports from file or read from stdin? (1/2) "
    ans = $stdin.gets.chomp
    if ans === '1'
      load_hosts_file 
    elsif ans === '2'
      read_from_std_in
    else
      puts "unknown option"
      interface
    end
  end
  def read_from_std_in
    host = $stdin.gets.chomp
    if host != "exit"
      @hosts.push(host)
      read_from_std_in
    else
      interface
    end
  end
  def load_hosts_file
    print "enter full path to hosts file: "
    path = $stdin.gets.chomp
    fd = File.open(path, "r")
    fd.each_line do |line|
      str = line.split(" ")
      load_hosts str[0], str[1]
    end
    interface
  end
  def load_hosts host, ports
    @ports = ports
    @hosts = hosts
  end
  def show_hosts
    puts @hosts
    interface
  end
  def get_random_domains
    puts "initializing download of 10,000 random domain names..."
    system "./script"
    puts "done"
    interface
  end
end
c = CLI.new
