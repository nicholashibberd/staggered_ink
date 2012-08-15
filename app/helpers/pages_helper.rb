module PagesHelper
  
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    markdown.render(text).html_safe if text
  end
  
  def render_layout(page)
    begin
      custom_page_path = Rails.root.join('app', 'views', 'pages', 'custom_layouts', page.layout)
      layout = File.exist?(custom_page_path) ? "pages/custom_layouts/#{page.layout}" : "pages/default_layouts//#{page.layout}"
      render layout
    rescue ActionView::MissingTemplate => e
      render "pages/default_layouts/default"
    end
  end
  
  def path_for_page(page)
    page.new_record? ? pages_path : page_path(page)
  end
  
end