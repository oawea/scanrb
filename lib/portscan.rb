$LOAD_PATH << "."
require 'socket'
require 'lib/host'
require 'celluloid'
require 'lib/portutils'

class Scanner
  include Celluloid
  def initialize
    @open = {}  
  end
  def scan host, ports
    ports.each do |port|
      begin
        sock = Socket.new(:INET, :STREAM)
        raw = Socket.sockaddr_in(port, host)
        puts "port #{port} open" if sock.connect(raw)
        @open["#{host}"].push(port) if @open["#{host}"]
        @open["#{host}"] = [port] if @open["#{host}"] === nil
      rescue
        if sock != nil
          sock.close
        end
      end
    end
  end
  def open
    print "\n\n#{@open}\n\n"
  end
end

class PortScanner
  def initialize hosts
    @hosts = hosts
    @open = {}
    @responses = {}
    @ports = []
    @putil = PortUtils.new
    load_ports
  end
  def load_ports
    puts "please enter a space separated list of ports you would like to scan. or, specify a range with x-y"
    print ">> "
    @putil.evaluate($stdin.gets.chomp)
    @putil.p.each {|key, val| @ports.push(key) unless val === nil}
    scan_overlay
  end
  def organize
    
  end
  def post_scan
    puts @open
    cmdline
  end
  def open
    @pools.each do |x|
      puts x.async.open
    end
  end
  def cmdline
    print ">> "
    cmd = $stdin.gets.chomp
    eval_cmd cmd
  end
  def eval_cmd cmd
    if cmd === "help"
      puts "show hosts   -> show hosts"
      puts "top ports    -> show top ports"
      puts "get versions -> get versions"
      puts "organize     -> organize hosts into data structure"
      puts "help         -> print this message"
    end
    if cmd === "exit"
      return
    end
    if cmd === "open"
      open
    end
    if cmd === "check"
      @pools.each do |p|
  
      end
    end
    cmdline
  end
  def scan_overlay
    @putil.segment
    @putil.segment_ports
    segments = @putil.segments
    @hosts.each do |host|
      make_thread segments, host
    end
  end
  def make_thread segments, host
    @pools = []
    segments.each do |key, val|
      pp = Scanner.new
      @pools.push(pp)
      pp.async.scan(host, val)
    end
    post_scan
  end
end
