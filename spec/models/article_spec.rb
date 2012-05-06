require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Article, 'being created' do
    it 'should create valid article' do
      lambda do
        Article.create({:title => 'title', :introduction => 'introduction', :content => 'content'})
      end.should change(Article, :count).by(1)
    end

    it 'should require title' do
      lambda do
        a = Article.create({:title => nil, :introduction => 'introduction', :content => 'content'})
        a.errors.on(:title).should_not be_nil
      end.should_not change(Article, :count)
    end
    
    it 'should require introduction' do
      lambda do
        a = Article.create({:title => 'title', :introduction => nil, :content => nil})
        a.errors.on(:introduction).should_not be_nil
      end.should_not change(Article, :count)
    end
    
    it 'should require content' do
      lambda do
        a = Article.create({:title => 'title', :introduction => 'introduction', :content => nil})
        a.errors.on(:content).should_not be_nil
      end.should_not change(Article, :count)
    end

end
