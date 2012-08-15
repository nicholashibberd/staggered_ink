class Image
  include Mongoid::Document
  default_scope asc(:position)
  
  field :name
  field :position
    
  mount_uploader :file, ImageUploader
  
  def self.new_instance(params)
    gallery_id = params[:gallery_id]
    case gallery_id
      when 'content' then ContentImage.new(params[:content_image])
      when 'background' then BackgroundImage.new(params[:background_image])
      when 'slideshow' then SlideshowImage.new(params[:slideshow_image])
      else Image.new(params[:image])
    end
  end

  before_create :set_position
  
  def set_position
    self.position = gallery.max_position + 1
  end

  def self.max_position
    existing_images = self.all.select {|image| !image.position.nil?}
    current_highest = existing_images.map(&:position).max
    current_highest ||= 0
  end  

end
