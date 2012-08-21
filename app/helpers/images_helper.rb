module ImagesHelper
  def image_form_path(gallery, image)
    image.new_record? ? images_path(:gallery => gallery) : image_path(image, :gallery => gallery)
  end

  def galleries_select
  	Image::GALLERIES.map {|name, gallery| [gallery[:name], gallery[:slug]]}
  end
end