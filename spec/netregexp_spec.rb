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
end