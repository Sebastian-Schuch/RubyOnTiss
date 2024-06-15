module FavoritesHelper
  def favoritable_path(favoritable)
    case favoritable
    when Person
      person_detail_path(favoritable)
    when Course
      course_detail_path(id: favoritable.custom_id)
    when Project
      projects_detail_path(favoritable)
    when Thesis
      theses_detail_path(favoritable)
    else
      raise "Unknown favoritable type"
    end
  end

  def favoritable_display_name(favoritable)
    case favoritable
    when Person
      favoritable.full_name
    when Course, Project, Thesis
      favoritable.title
    else
      raise "Unknown favoritable type"
    end
  end
end
