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

  process :dynamic_resize_to_fit, :if => :variable_image?
  process :resize_to_gallery, :if => :fixed_size_image?

  def variable_image? image
    return false unless gallery = find_gallery(model.gallery)
    gallery[:variable] && dimensions_valid?(model.width, model.height)
  end

  def fixed_size_image? image
    return false unless gallery = find_gallery(model.gallery)
    gallery[:variable] == false && dimensions_valid?(gallery[:width], gallery[:height])
  end

  def gallery_image? image
    return false unless gallery = find_gallery(model.gallery)
    gallery[:gallery] && gallery
  end

  def find_gallery(gallery)
    Image::GALLERIES[gallery.to_sym]
  end

  def dynamic_resize_to_fit
    dimensions = [model.width, model.height]
    resize_to_fit *(dimensions)
  end

  def resize_to_gallery
    return nil unless gallery = find_gallery(model.gallery)
    dimensions = [gallery[:width], gallery[:height]]
    resize_to_fill *(dimensions)
  end

  def dimensions_valid?(width, height)
    width.is_a?(Integer) && height.is_a?(Integer)
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

end