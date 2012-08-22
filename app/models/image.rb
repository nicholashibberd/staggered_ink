class Image
  include Mongoid::Document
  default_scope asc(:position)
  
  field :name
  field :position
  field :width, :type => Integer
  field :height, :type => Integer
  field :thumbnail_width, :type => Integer
  field :thumbnail_height, :type => Integer
  field :gallery

  GALLERIES = {
    :content => {:name => 'Content', :slug => 'content', :gallery => false, :variable => true},
    :cards => {:name => 'Cards', :slug => 'cards', :thumbnail_height => 200, :gallery => true, :variable => true}
  }

  scope :by_gallery, lambda {|gallery| where(:gallery => gallery)}
  
  mount_uploader :file, ImageUploader
  before_create :set_position
  
  def set_position
    self.position = Image.max_position + 1
  end

  def self.max_position
    existing_images = self.all.select {|image| !image.position.nil?}
    current_highest = existing_images.map(&:position).max
    current_highest ||= 0
  end  

  def self.from_gallery(gallery)
    gallery ? by_gallery(gallery) : all
  end

  def self.order(params)
    images = from_gallery(params[:gallery])
    images.each do |image|
      image.position = params['image'].index(image.id.to_s) + 1
      image.save!
    end
  end

end
