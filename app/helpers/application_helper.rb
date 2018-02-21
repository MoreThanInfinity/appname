module ApplicationHelper
  include Rails.application.routes.url_helpers

  def cancel_link
    return link_to 'Cancel', request.env["HTTP_REFERER"],
    :class => 'cancel',
    :confirm => 'Are you sure? Any changes will be lost...'
  end

  def creating(obj)
    obj.created_at.to_s.chomp(" UTC")
  end

  def updating(obj)
    obj.updated_at.to_s.chomp(" UTC") if obj.updated_at
  end

  def separate(record)
    if record.to_s.size > 20
      record.to_s[0..20]+'...'
    else
      record
    end
  end

  def belonging?(item)
    (item.class == Post && current_user.posts.include?(item)) || (item.class == Comment && current_user.posts.include?(Post.find(item.commentable_id)))
  end
end
