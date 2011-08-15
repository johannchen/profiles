require 'spec_helper'

describe ApplicationController do
  describe "#s" do
    it "returns the nested object value given a key of foo.bar format" do
      subject.instance_eval("s('site.name')").should eq(Setting::SETTINGS['site']['name']) 
    end
  end
end
