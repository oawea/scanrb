class FTPUtils
  def banner_grab

  end
end
class Host
  def initialize host, ports
    @host[hostname] = host
    @host[ports] = ports
  end
  def interface 
    print ">> "
  end
  def eval_cmd cmd
    if cmd === "help"
      puts "banner grab -> grab banner off of one"
      puts "help    -> show this screen"
    end
  end
  def banner_grab 
    
  end
end
