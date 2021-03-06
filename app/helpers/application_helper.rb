# encoding: utf-8
module ApplicationHelper

    #    Returns the full title on a per-page basis.
    def full_title(page_title)
        base_title = "古今書廊管理系統"
        if page_title.empty?
            base_title
        else
            "#{base_title} | #{page_title}"
        end
    end

    def sunspot_commit_reindex()
      # Sunspot.commit_if_dirty
      # system("yes | bundle exec rake sunspot:reindex")
    end

  def flash_class(level)
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end

end
