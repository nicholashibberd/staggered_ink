class BackgroundImage < Image
	DIMENSIONS = [1160, 300]
	mount_uploader :file, BackgroundImageUploader
end