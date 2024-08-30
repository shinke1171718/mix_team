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
end
