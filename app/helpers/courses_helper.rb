module CoursesHelper
  require 'uri'
  require 'cgi'
  def extract_parameters(url)
    uri = URI.parse(url)
    params = CGI.parse(uri.query)
    "#{params['courseNr'].first}-#{params['semester'].first}"
  end
end
