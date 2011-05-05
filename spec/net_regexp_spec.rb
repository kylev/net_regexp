require 'net_regexp'

describe NetRegexp do
  describe "#initialize" do
    it "should present an exact match for /32" do
      NetRegexp.new('191.168.4.2').source.should == "^191\.168\.4\.2$"
    end

    it "should raise an error on bad arguments" do
      lambda { NetRegexp.new("555.555.555.555") }.should raise_exception(ArgumentError)
      lambda { NetRegexp.new("10.0.0.1", -1) }.should raise_exception(ArgumentError)
      lambda { NetRegexp.new("32.0.0.1", 33) }.should raise_exception(ArgumentError)
    end
  end

  describe "FULL_OCTET_RE" do
    before(:each) do
      # Test exact match only because it'll be pinned that way inside a larger regexp
      @octet = Regexp.new("^#{NetRegexp::FULL_OCTET_RE}$")
    end

    it "should match .0-255" do
      (0..255).each do |i|
        ".#{i}".should match @octet
      end
    end

    it "should not match a bare number" do
      '1'.should_not match @octet
    end

    it "should not match out of bounds values" do
      '.256'.should_not match @octet
      '.2550'.should_not match @octet
    end
  end

  describe "classful matches" do
    it "should handle /8" do
      re = NetRegexp.new('10.0.0.0', 8)
      "10.10.32.43".should match re
      '110.10.42.23'.should_not match re
    end
  end

  describe "#range_regexp" do
    it "should raise on an invalid range" do
      lambda { NetRegexp.range_regexp(42, 24) }.should raise_exception(ArgumentError)
      lambda { NetRegexp.range_regexp(33, 33) }.should_not raise_exception(ArgumentError)
    end

    it "should handle single digit ranges" do
      re = Regexp.new("^#{NetRegexp.range_regexp(2, 7)}$")
      '1'.should_not match re
      '2'.should match re
      '5'.should match re
      '7'.should match re
      '8'.should_not match re
      '25'.should_not match re
    end

    it "should handle single to double digit ranges" do
      # re = Regexp.new("^#{NetRegexp.range_regexp(4, 21)}$")
      # '1'.should_not match re
    end
  end
end