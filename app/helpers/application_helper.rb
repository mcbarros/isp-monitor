module ApplicationHelper
  def badge(text, color = "primary")
    tag.span(text, class: "tag is-#{color}")
  end
end
