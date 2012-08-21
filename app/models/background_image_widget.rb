class BackgroundImageWidget < Widget
	belongs_to :image
  mount_uploader :file, BackgroundImageUploader
end