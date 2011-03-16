module PagesHelper
  def is_active?(page_name)
    "current-page" if params[:action] == page_name
  end
end
