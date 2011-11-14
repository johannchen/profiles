describe Setting do
  subject { Setting }

  describe '.s' do
    it "returns the nested object value given a key of foo.bar format" do
      subject.s('site.name').should_not be_nil
      subject.s('site.name').should eq(Setting::SETTINGS['SITE_NAME']) 
    end
  end
end
