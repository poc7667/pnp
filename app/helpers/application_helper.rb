module ApplicationHelper

    #    Returns the full title on a per-page basis.
    def full_title(page_title)
        base_title = "Poc Station"
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

end
