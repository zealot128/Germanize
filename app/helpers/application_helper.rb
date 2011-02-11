module ApplicationHelper
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end


  def link_to_with_highlight(name, options = {}, html_options = {})  # same sig as #link_to
    html_options.merge!({ :class => 'current' }) if current_page?(options)
    link_to(name, options, html_options)
  end
end
