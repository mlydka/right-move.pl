class Image < ActiveRecord::Base
  require 'RMagick'

  belongs_to :offer

  has_attachment :content_type => :image, 
                 :storage      => :file_system,
								 :path_prefix  => '/public/images/attachments/',
                 :processor    => :Rmagick, 
                 :max_size     => 5.megabytes,
                 #:resize_to    => '507x363>',
 								 :thumbnails   => {:medium =>'crop: 507x359', :small => 'crop: 65x64'}

  validates_as_attachment

  def reset_serial
    update_attribute(:serial, nil)
  end

	protected

  def resize_image(img, size)
    if(size.is_a?(String) && size =~ /^crop: (\d*)x(\d*)/i) || (size.is_a?(Array) && size.first.is_a?(String) && size.first =~ /^crop: (\d*)x(\d*)/i)
      img.crop_resized!($1.to_i, $2.to_i)
      self.temp_path = write_to_temp_file(img.to_blob)
    else
      super
    end
  end 

end