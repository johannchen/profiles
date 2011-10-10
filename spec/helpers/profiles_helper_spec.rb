require 'spec_helper'

describe ProfilesHelper do
  describe '#profile_bio' do
    context 'given two line breaks and no <p> tags' do
      subject { profile_bio Factory.build(:profile, :bio => "This is a bio.\n\nThis is the second paragraph.") }

      it 'converts the line breaks to <br /> tags' do
        subject.should eq("This is a bio.<br />\n<br />\nThis is the second paragraph.")
      end
    end

    context 'given two line breaks and existing <p> tags' do
      subject { profile_bio Factory.build(:profile, :bio => "<p>This is a bio.</p>\n\n<p>This is the second paragraph.</p>") }

      it 'does not convert the line breaks to <br /> tags' do
        subject.should eq("<p>This is a bio.</p>\n\n<p>This is the second paragraph.</p>")
      end
    end

    context 'given dangerous markup' do
      subject { profile_bio Factory.build(:profile, :bio => "<p>hi</p> <script>alert('bad')</script>") }

      it 'sanitizes the content' do
        subject.should eq("<p>hi</p> ")
      end
    end
  end
end
