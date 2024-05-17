class ThesesController < MotherClassController

  before_action :index

  def parse_xml(xml)
    @title = xml.xpath("//title").text
    @instituteName = xml.xpath("//instituteName").text
    @facultyName = xml.xpath("//facultyName").text
    @keywords = xml.xpath("//keywords").text
    @url = xml.xpath("//url").text
    @advisor = xml.xpath("//advisor").text
    @assistant = xml.xpath("//assistant").text
  end

  def addFavorite(id)
    @id = id
    @time = Time.now
  end

end
