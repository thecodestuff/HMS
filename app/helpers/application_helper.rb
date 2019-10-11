module ApplicationHelper
  include Rails.application.routes.url_helpers
  # Displays object errors
  def form_errors_for(object = nil)
    render('shared/form_errors', object: object) unless object.blank?
  end

  def format_date(date)
    date.strftime('%d %B %Y') if date.present?
  end

  def active_nav_link(path, optional=nil)
    current_page?(path) ? 'current active' : ''
  end

  def filter_original_path
    request.original_fullpath.split("/").last.humanize
  end
end
