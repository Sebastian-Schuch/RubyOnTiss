class ProjectsController < MotherClassController
  before_action :index

  def parse_xml(xml)
    @title_de = xml.xpath("//titleDe").text
    @title_en = xml.xpath("//titleEn").text
    @short_description = xml.xpath("//shortDescription").text
    @contract_begin = xml.xpath("//contractBegin").text
    @contract_end = xml.xpath("//contractEnd").text
    @project_begin = xml.xpath("//projectBegin").text
    @project_end = xml.xpath("//projectEnd").text
    @project_form = xml.xpath("//projectForm").text
    @project_type = xml.xpath("//projectType").text
    @abstract_de = xml.xpath("//abstractDe").text
    @abstract_en = xml.xpath("//abstractEn").text

    # Extract institutes and their members
    @institutes = xml.xpath("//institute").map do |institute|
      {
        oid: institute.attr("oid"),
        project_coordinator: institute.xpath("projectCoordinator").text,
        project_members: institute.xpath("projectMembers/projectMember").map do |member|
          {
            oid: member.attr("oid"),
            role_de: member.xpath("roleDe").text,
            role_en: member.xpath("roleEn").text
          }
        end
      }
    end

    # Extract keywords
    @keywords = xml.xpath("//keywords/keyword").map do |keyword|
      {
        de: keyword.xpath("de").text,
        en: keyword.xpath("en").text
      }
    end

    # Extract research areas
    @research_areas = xml.xpath("//researchAreas/researchArea").map do |research_area|
      {
        id: research_area.attr("id"),
        name_de: research_area.xpath("name/de").text,
        name_en: research_area.xpath("name/en").text
      }
    end

    # Extract financiers
    @financiers = xml.xpath("//financiers/financier").map do |financier|
      {
        de: financier.xpath("de").text,
        en: financier.xpath("en").text
      }
    end
  end

  def add_favorite
    @id = params[:id]
    @time = Time.now

  end
end
