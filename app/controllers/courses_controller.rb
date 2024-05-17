
class CoursesController < MotherClassController
  before_action :index

  def parse_xml(detail)
    @title = detail.xpath("//title").text
    @course_type = detail.xpath("//courseType").text
    @semester = detail.xpath("//semesterCode").text
    @course_nr = detail.xpath("//courseNumber").text
    @institution = detail.xpath("//instituteName").text
    @teaching_content = detail.xpath("//teachingContent").text
  end
end
