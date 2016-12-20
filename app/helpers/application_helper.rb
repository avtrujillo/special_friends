module ApplicationHelper

  def full_title(page_title = " ")
    base_title = "Special Friends App"
    if page_title.empty?
      return base_title
    else
      return (page_title + " | " + base_title)
    end
  end

end
