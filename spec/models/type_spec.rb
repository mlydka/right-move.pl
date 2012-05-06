require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Type do
  fixtures :types
	  
  describe 'being created' do
    it 'requires name' do
      lambda do
        t = Type.create(:name => nil)
        t.errors.on(:name).should_not be_nil
      end.should_not change(Type, :count)
    end

    describe 'allows legitimate names:' do
      ['dzierżawa', 'string', 'ŻNółQ'
      ].each do |name_str|
        it "'#{name_str}'" do
          lambda do
            t = Type.create(:name => name_str)
            t.errors.on(:name).should be_nil
          end.should change(Type, :count).by(1)
        end
      end
    end

    describe 'disallows illegitimate names' do
      ['23', '_sprzedaz', 'wy-na-jem', 345
      ].each do |name_str|
        it "'#{name_str}'" do
          lambda do
            t = Type.create(:name => name_str)
            t.errors.on(:name).should_not be_nil
          end.should_not change(Type, :count)
        end
      end
    end
  end

  it 'should validate uniqueness of name' do
    lambda do
      t = Type.create(:name => 'sprzedaż')
      t.errors.on(:name).should_not be_nil
    end.should_not change(Type, :count)
  end

end
