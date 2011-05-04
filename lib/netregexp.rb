require 'ipaddr'

class NetRegexp < Regexp
  def initialize(ip, cidr=32)
    if cidr < 0 || cidr > 32
      raise ArgumentError.new("CIDR must be between 0 and 32 inclusive.")
    end

    @ip = IPAddr.new(ip)
    @ip_str = ip
    @cidr = cidr

    if cidr == 32
      super "^#{ip.tr('.', '\.')}$"
    else
      raise "TODO"
    end
  end

end