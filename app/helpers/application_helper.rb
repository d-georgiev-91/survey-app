module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice' then 'alert-success'
    when 'alert' then 'alert-danger'
    when 'error' then 'alert-danger'
    else 'alert-info'
    end
  end

  def display_flash_messages
    return if flash.empty?

    content_tag(:ul, class: 'list-unstyled mt-3') do
      flash.map do |key, value|
        concat(content_tag(:li, value, class: "text-center alert #{flash_class(key)}"))
      end
    end
  end
end
