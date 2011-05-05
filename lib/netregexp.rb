require 'ipaddr'

class NetRegexp < Regexp
  FULL_OCTET_RE = '\.(?:\d|1?\d\d|2[0-4]\d|25[0-5])'

  def initialize(ip_str, cidr=32)
    if cidr < 0 || cidr > 32
      raise ArgumentError.new("CIDR must be between 0 and 32 inclusive.")
    end

    @ip = IPAddr.new(ip_str) # Should force ArgumentError on non-valid IPs
    @ip_str = ip_str
    @cidr = cidr

    if cidr == 32
      super "^#{ip_str.tr('.', '\.')}$"
    elsif [8, 16, 24].include? cidr
      super "^#{NetRegexp.classful_pattern(ip_str, cidr / 8)}$"
    else
      raise "TODO"
    end
  end

  private

  def self.classful_pattern(ip_str, octets)
    parts = ip_str.split('.')
    parts[0...octets].join('\.') + (FULL_OCTET_RE * (4 - octets))
  end

  def self.range_regexp(low, high)
    raise ArgumentError.new("Range invalid (#{low}-#{high})") if low > high
    "[#{low}-#{high}]" # TODO
  end
end