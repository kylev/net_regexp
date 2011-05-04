require 'ipaddr'

class NetRegexp < Regexp
  def initialize(ip, cidr=32)
    if cidr < 0 || cidr > 32
      raise ArgumentError.new("CIDR must be between 0 and 32 inclusive.")
    end

    @ip = IPAddr.new(ip) # Should force ArgumentError on non-valid IPs
    @ip_str = ip
    @cidr = cidr

    if cidr == 32
      super "^#{ip.tr('.', '\.')}$"
    elsif [8, 16, 24].include? cidr
      super "^#{classful_pattern(cidr / 8)}$"
    else
      raise "TODO"
    end
  end

  private

  def classful_pattern(octets)
    parts = @ip_str.split('.')
    parts[0...octets].join('\.') + ('\.\d+' * (4 - octets))
  end
end