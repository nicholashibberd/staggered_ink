class GalleryWidget < Widget
	field :gallery_id

	def gallery
		Gallery.find(gallery_id) 	
	end  
end