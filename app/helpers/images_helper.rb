module ImagesHelper
  def image_form_path(gallery, image)
    image.new_record? ? gallery_images_path(gallery) : gallery_image_path(gallery, image)
  end

  def galleries_select
  	Gallery.galleries.map {|gal| [gal[:name].titleize, gal[:name]]}
  end
end