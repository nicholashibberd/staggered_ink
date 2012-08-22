# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :fog
  
  version :thumb do
    process :resize_to_fit => [500, 100]
  end

  version :gallery_thumb, :if => :gallery_image? do
    process :resize_to_fit => [300, 200]
  end

  process :dynamic_resize_to_fit, :if => :content_image?
  process :resize_to_fit => [900, 600], :if => :gallery_image?

  def content_image? image
    return false unless gallery = find_gallery(model.gallery)
    gallery[:content]
  end

  def gallery_image? image
    return false unless gallery = find_gallery(model.gallery)
    gallery[:gallery]
  end

  def find_gallery(gallery)
    Image::GALLERIES[gallery.to_sym]
  end

  def dynamic_resize_to_fit
    width = model.width.is_a?(Integer) ? model.width : 900
    height = model.height.is_a?(Integer) ? model.height : 600
    resize_to_fit *([width, height])
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

end