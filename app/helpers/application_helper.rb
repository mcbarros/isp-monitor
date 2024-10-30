module ApplicationHelper
  def safe_l(value)
    value.nil? ? "no data" : l(value)
  end

  def time_span(value)
    Time.at(value).gmtime.strftime("%H:%M:%S")
  end

  def badge(text, color = "primary")
    tag.span(text, class: "tag is-#{color}")
  end

  def active_text
    tag.strong("active", class: "has-text-success")
  end

  def inactive_text
    tag.strong("inactive", class: "has-text-danger")
  end
end
