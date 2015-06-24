$LOAD_PATH << "."
class WriteLoot
  def initialize host, service, user, pass
    @host, @service, @user, @pass = host, service, user, pass
    write_loot
  end
  def write_loot
    fd = File.open("assets/loot/#{@host}_#{@service}", "a+")
    fd.write("#{@user}:#{@pass}")
  end
end
