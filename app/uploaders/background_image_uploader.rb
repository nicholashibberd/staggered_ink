class BackgroundImageUploader < ImageUploader
	process :resize_to_fill => BackgroundImage::DIMENSIONS
end