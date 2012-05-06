require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Category do
   
  describe 'being created' do
    it 'requires name' do
      lambda do
        c = Category.create(:name => nil)
        c.errors.on(:name).should_not be_nil
      end.should_not change(Category, :count)
    end

    describe 'allows legitimate names:' do
      ['mieszkania', 'domy', 'działki', 'lokale komercyje', 'obiekty komercyjne'
      ].each do |name_str|
        it "'#{name_str}'" do
          lambda do
            c = Category.create(:name => name_str)
            c.errors.on(:name).should be_nil
          end.should change(Category, :count).by(1)
        end
      end
    end

    describe 'disallows illegitimate names' do
      ['23', 'działka 1', '@dom', '_mieszkanie', 'lokale-komercyjne'
      ].each do |name_str|
        it "'#{name_str}'" do
          lambda do
            c = Category.create(:name => name_str)
            c.errors.on(:name).should_not be_nil
          end.should_not change(Category, :count)
        end
      end
    end
  end

  describe 'act as tree' do
    fixtures :categories

    it 'should return paremt' do
      categories(:oneroom_apartments).parent.should == categories(:apartments)
    end
  end

  describe 'positions' do
    #is_last is_first
  end

end