class GalleryWidget < Widget
	field :gallery_id

	def images
		Image.from_gallery(gallery_id)
	end  
end