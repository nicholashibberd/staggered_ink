class GalleriesController < AdminController

	def index
		@galleries = Gallery::GALLERIES.map { |name, info| Gallery.new(info)  }
	end

  def order_images
    gallery = Gallery.find(params[:id])
    gallery.order_nav_items(params)
    render :nothing => true
  end  
end