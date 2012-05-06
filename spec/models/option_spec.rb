require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Option do

  describe 'being created' do
    it 'requires name' do
      lambda do
        o = Option.create(:name => nil)
        o.errors.on(:name).should_not be_nil
      end.should_not change(Option, :count)
    end

    describe 'allows legitimate names:' do
      ['siatka', 'płot', 'przęsła', 'betonowe', 'brak'
      ].each do |name_str|
        it "'#{name_str}'" do
          lambda do
            o = Option.create(:name => name_str, :variable_id => 13)
            o.errors.on(:name).should be_nil
          end.should change(Option, :count).by(1)
        end
      end
    end
  end

end