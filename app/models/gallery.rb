class Gallery
  include Mongoid::Document
  #attr_accessor :name, :image_type, :variable, :gallery_type
  
  field :name
  field :image_type
  field :variable
  field :gallery_type

  GALLERIES = {
    'content' => {:name => 'content', :gallery_type => 'collection', :image_type => 'ContentImage', :variable => true},
    'background' => {:name => 'background', :gallery_type => 'collection', :image_type => 'BackgroundImage', :variable => false},
    'slideshow' => {:name => 'slideshow', :gallery_type => 'gallery', :image_type => 'SlideshowImage', :variable => false}
  }

  def self.galleries
    galleries = GALLERIES.select {|name, info| info[:gallery_type] == 'gallery'}
    galleries.map {|name, info| info}
  end

  def self.collections
    GALLERIES.select {|name, info| info[:gallery_type] == 'collection'}
  end

  def order_images(params)
    images.each do |image|
      image.position = params['image'].index(image.id.to_s) + 1
      image.save!
    end
  end

  def images
    image_type.classify.constantize.all
  end

  def self.find(name)
    self.new(GALLERIES[name])
  end 

end
