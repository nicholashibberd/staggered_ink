class ContentImage < Image
  field :width, :type => Integer
  field :height, :type => Integer

  has_many :image_widgets
	mount_uploader :file, ContentImageUploader

end