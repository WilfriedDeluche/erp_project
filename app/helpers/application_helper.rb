module ApplicationHelper
  def rolable_error_messages!(resource, user)
    return "" if resource.errors.empty? && user.errors.empty?

    messages = rolable_messages = ""

    if !resource.errors.empty?
      messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    end

    if !user.errors.empty?
      rolable_messages = user.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    end

    messages = rolable_messages + messages 
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count + user.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
    <h2>#{sentence}</h2>
    <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
