class ImagesController < AdminController
  before_filter :set_gallery

  def new
    @image = Image.new_instance(params)
  end

  def edit
    @image = Image.find(params[:id])
  end

  def index
    @images = @gallery.images
  end

  def create
    image = Image.new_instance(params)
    if image.save
      redirect_to gallery_images_path(@gallery.name)
    else
      flash[:error] = "Image could not be created"
      render :action => "new"
    end
  end

  def update
    image = Image.find(params[:id])
    if image.update_attributes(params[:image])
      redirect_to gallery_images_path(@gallery.name)
    else
      flash[:error] = "Image could not be updated"      
      render :action => "edit"
    end
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy
    redirect_to gallery_images_path(@gallery.name)
  end

  def set_gallery
    gallery_info = Gallery::GALLERIES[params[:gallery_id]]
    @gallery = Gallery.new(gallery_info)
  end

  def order_images
    gallery = Gallery.find(params[:gallery])
    gallery.order_images(params)
    render :nothing => true
  end  
end