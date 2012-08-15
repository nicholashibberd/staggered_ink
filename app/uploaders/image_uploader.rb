# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :fog
  
  version :thumb do
    process :resize_to_fit => [500, 100]
  end
  
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

end