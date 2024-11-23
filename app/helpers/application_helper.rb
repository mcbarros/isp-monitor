module ApplicationHelper
  def safe_l(value)
    value.nil? ? "no data" : l(value)
  end

  def time_span(value)
    days, value = value.divmod(86400)
    hours, value = value.divmod(3600)
    mins, value = value.divmod(60)
    { days: days, hours: hours, minutes: mins, seconds: value.truncate }
  end

  def time_span_l(value)
    span = time_span(value)
    "#{span[:days]} day(s), #{span[:hours]} hours and #{span[:minutes]} minutes"
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
