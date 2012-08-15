class ContentImageUploader < ImageUploader

	process :dynamic_resize_to_fit, :if => :dimensions_valid?

  def dynamic_resize_to_fit
    dimensions = [model.width, model.height]
    resize_to_fit *(dimensions)
  end

  def dimensions_valid? image
    test = model.width.is_a?(Integer) && model.height.is_a?(Integer)
  end
end