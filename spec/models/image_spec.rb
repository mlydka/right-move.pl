require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Image do
  fixtures :images

  before(:each) do
    @image = images(:uploaded_image)
  end

  it 'should reset serial' do
    @image.serial.should_not be_nil
    @image.reset_serial
    @image.serial.should be_nil
  end

end
