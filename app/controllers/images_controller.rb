class ImagesController < AdminController
  before_filter :set_gallery

  def new
    @image = Image.new
  end

  def edit
    @image = Image.find(params[:id])
  end

  def index
    @images = Image.from_gallery(params[:gallery])
  end

  def create
    image = Image.new(params[:image])
    if image.save
      redirect_to images_path(:gallery => image.gallery)
    else
      flash[:error] = "Image could not be created"
      render :action => "new"
    end
  end

  def update
    image = Image.find(params[:id])
    if image.update_attributes(params[:image])
      redirect_to images_path(:gallery => image.gallery)
    else
      flash[:error] = "Image could not be updated"      
      render :action => "edit"
    end
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy
    redirect_to images_path
  end

  def set_gallery
    if gallery = params[:gallery]
      @gallery = Image::GALLERIES[gallery.to_sym]
    end
  end

  def order_images
    #gallery = ImageCollection.find(params[:collection])
    #collection.order_images(params)
    render :nothing => true
  end  
end