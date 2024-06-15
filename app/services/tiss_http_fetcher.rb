require 'net/http'
require 'json'
require 'nokogiri'

class TissHttpFetcher
  BASE_URL = "https://tiss.tuwien.ac.at/api/"
  def search_person(param)
    uri = "person/v21/psuche?q=" + param
    fetch_request(uri)
  end

  def search_thesis(param)
    uri = "search/thesis/v1.0/quickSearch?searchterm=" + param
    fetch_request(uri)
  end

  def search_project(param)
    uri = "search/projectFullSearch/v1.0/projects?searchterm=" + param
    fetch_request(uri)
  end

  def search_course(param)
    uri = "search/course/v1.0/quickSearch?searchterm=#{param}"
    fetch_request(uri)
  end

  def get_project(id)
    uri = "/pdb/rest/project/v2/#{id}"
    fetch_request(uri)
  end

  def get_person(id)
    uri = "person/v21/id/#{id}"
    fetch_request(uri)
  end

  def get_thesis(id)
    uri = "thesis/#{id}"
    fetch_request(uri)
  end

  def get_course(id)
    uri = "course/#{id}"
    fetch_request(uri)
  end

  def fetch_request(endpoint)

    uri = URI("#{BASE_URL}#{endpoint}")
    response = Net::HTTP.get_response(uri)

    unless response.is_a?(Net::HTTPSuccess)
      raise "Request failed with code #{response.code}"
    end

    case response.content_type
    when 'application/json'
      json_response = JSON.parse(response.body)
      Rails.logger.debug { "JSON Response: #{json_response}" }
      json_response
    when 'text/html', 'application/xml'
      doc = Nokogiri::XML(response.body)
      doc.remove_namespaces!
      Rails.logger.debug { "XML Response: #{doc}" }
      doc
    else
      raise "Unsupported content type #{response.content_type}"
    end
  end

end

