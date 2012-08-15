# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :fog
  
  process :dynamic_resize_to_fit, :if => :dimensions_valid?
  
  version :thumb do
    process :resize_to_fit => [500, 100]
  end
  
  version :gallery_thumb, :if => :gallery_image? do
    process :resize_to_fit => [500, 140]
  end
  
  def dynamic_resize_to_fit
    dimensions = [model.width, model.height]
    resize_to_fit *(dimensions)
  end

  def dimensions_valid? image
    collection_image? && model.width.is_a?(Integer) && model.height.is_a?(Integer) 
  end
  
  def gallery_image? image
    model.gallery_type == 'gallery'
  end
  
  def collection_image?
    model.gallery_type == 'collection'
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.gallery}/#{model.id}"
  end
  
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

end