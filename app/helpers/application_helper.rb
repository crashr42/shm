module ApplicationHelper
  def link_to_active(*args, &block)
    name = args[0]
    options = args[1] || {}
    html_options = args[2]
    if current_page?(options)
      if html_options.present? && html_options.include?(:class)
        html_options[:class] += " active"
      else
        html_options = {:class => "active"}
      end
    end
    link_to(name, options, html_options)
  end

  def link_to_active_wrapper(*args, &block)
    name = args[0]
    wrapper = args[1]
    options = args[2] || {}
    html_options = args[3]
    content_tag(wrapper, link_to(name, options, html_options, &block), current_page?(options) ? {:class => 'active'} : {})
  end
end
