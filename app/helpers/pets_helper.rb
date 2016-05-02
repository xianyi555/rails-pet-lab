module PetsHelper
  def my_format_age_helper age_in_days
    if age_in_days.nil?
      years = '?'
    else
      years = '%.1f' % age_in_days
    end
    "#{years}"
  end
end
