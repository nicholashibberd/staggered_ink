class SlideshowImageUploader < ImageUploader
	process :resize_to_fit => [900, 600]
	version :gallery_thumb do
		process :resize_to_fit => [500, 150]
	end
end