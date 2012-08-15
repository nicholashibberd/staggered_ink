require 'spec_helper'

describe ImageWidget do
  it "should upload the image at the original size if no dimensions provided" do
    image = ImageWidget.new(:name => 'Test', :width => nil, :height => nil)
    image_uploader.should_not_receive(:dynamic_resize_to_fit)
    image_uploader.should_receive(:thumb)
    image.save
  end

  it "should resize the image if dimensions provided" do
    image = ImageWidget.new(:name => 'Test', :width => 200, :height => 200)
    image_uploader.should_receive(:dynamic_resize_to_fit).with(:variable)
    image_uploader.should_receive(:thumb)
    image.save
  end
end

describe GalleryWidget do
  it "should create a gallery thumb, a thumb and resize the original to the max width " do
    image = GalleryImageWidget.new(:name => 'Test', :width => nil, :height => nil)
    image_uploader.should_not_receive(:dynamic_resize_to_fit)
    image_uploader.should_receive(:thumb)
    image_uploader.should_receive(:gallery_thumb)
    image.save
  end

  it "should resize the image if dimensions provided" do
  end
end
