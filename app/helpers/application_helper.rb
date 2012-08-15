module ApplicationHelper
  def logo
      link_to image_tag("/assets/logo.png"), root_path
  end
  
  def current_controller
    request[:controller].gsub('cms/', '')
  end
  
  def show_editing_tools?
    request[:action] == 'edit'
  end
  
  def layouts
    dir = Dir.new(Rails.root.join("app", "views", "pages", "default_layouts")) rescue nil
    return nil unless dir
    file_names = dir.entries
    file_names.delete_if { |file_name| [".", "..", ".DS_Store"].include?(file_name)  }
    file_names.map {|file_name| file_name.gsub('.html.erb', '')[1..-1] }    
  end

  def groups?
    Site.instance.has_groups
  end
  
  def host_page_path(page)
    "/pages/#{page.slug}"
  end
  
  def view_document_path(document)
    document.file.url
  end
    
end
