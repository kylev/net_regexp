require 'netregexp'

describe NetRegexp do
  describe "#initialize" do
    it "should present an exact match for /32" do
      NetRegexp.new('191.168.4.2').source.should == "^191\.168\.4\.2$"
    end
    
    it "should raise an error on bad arguments" do
      lambda {NetRegexp.new("555.555.555.555")}.should raise_exception(ArgumentError)
      lambda {NetRegexp.new("10.0.0.1", -1)}.should raise_exception(ArgumentError)
      lambda {NetRegexp.new("32.0.0.1", 33)}.should raise_exception(ArgumentError)
    end
  end

  describe "classful matches" do
    it "should handle /8" do
      re = NetRegexp.new('10.0.0.0', 8)
      puts re
      "10.10.32.43".should match re
      '110.10.42.23'.should_not match re
    end
  end
end