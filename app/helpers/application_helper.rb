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
  
  def account_status(user)
    return "badge-success" unless user.invitation_accepted_at.nil?
    if user.invitation_sent_at.nil?
      "badge-inverse"
    elsif !user.invitation_token.nil?
      "badge-warning"
    end
  end
  
  def account_status_for_show(user)
    return unless user.invitation_accepted_at.nil?
    content_tag(:span, :class => "label label-warning") do
      if user.invitation_sent_at.nil?
        "Cet utilisateur n'a pas encore recu d'invitation"
      elsif !user.invitation_token.nil?
        "Cet utilisateur n'a pas encore active son compte"
      end
    end + 
    content_tag(:br)
  end
end
