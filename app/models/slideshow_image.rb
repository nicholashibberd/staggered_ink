class SlideshowImage < Image
	field :caption
	mount_uploader :file, SlideshowImageUploader
end