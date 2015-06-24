class PortUtils
  def initialize
    @ports = {}
    @rangereg = /([0-9]+)-([0-9]+)/
  end
  def evaluate string
    cleanup if string.length === 0
    if string.include?("-")
      @rangereg =~ string
      md = Regexp.last_match
      evaluate(make_range(string, md))
    end
    unless string.include?("-")
      string.split(" ").each {|x| @ports[x.to_i]=x.to_i}
    end
  end
  def cleanup
    if @ports[0]
      @ports[0] = nil
    end
  end
  def make_range str, matchdata
    matchdata[1].to_i.upto(matchdata[2].to_i) {|x| @ports[x.to_i]=x.to_i}
    str.gsub!(/#{matchdata[1]}-#{matchdata[2]}/, "")
    a = str.split(", ,")
    a.each_index {|x| a[x].lstrip!}
    str = a.join(", ")
    return str
  end
  def segment
    if @ports.to_a.length < 16
      if @ports.to_a.length < 8 && @ports.to_a.length > 4
        @segsize = 4
      else
        @segsize = 1
      end
    elsif @ports.to_a.length >= 16
      @segsize = @ports.to_a.length/8
    end
  end
  def segment_ports
    np = []
    @port_segments = {}
    num_segments = 0
    iter = -1
    @ports.each do |key,val|
      np[iter+=1] = val unless val === nil
      if iter === @segsize
        iter = -1
        @port_segments[num_segments+=1] = np
        np = []
      end
    end
  end
  def segments 
    @port_segments
  end
  def segs
    @segsize
  end
  def p
    @ports.to_a
  end
  def to_s
    puts @ports
  end
end
