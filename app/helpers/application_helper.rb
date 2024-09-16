module ApplicationHelper
  def position_badge(user)
    case user.position
    when 'intern'
      tag.span 'インターン', class: 'badge badge__intern'
    when 'staff'
      tag.span '社員', class: 'badge badge__staff'
    when 'manager'
      tag.span 'マネージャー', class: 'badge badge__manager'
    when 'executive'
      tag.span '役員', class: 'badge badge__executive'
    else
      tag.span user.position, class: 'badge'
    end
  end

  def event_status_badge(event)
    case event.state
    when 'entry'
      tag.span '受付中', class: 'large-badge large-badge__event-entry'
    when 'closed'
      tag.span '終了', class: 'large-badge large-badge__event-closed'
    else
      tag.span '無効', class: 'large-badge large-badge__event-disable'
    end
  end
  
end
