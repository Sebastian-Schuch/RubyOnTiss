require 'net/http'
require 'json'
require 'nokogiri'

class TissHttpFetcher
  BASE_URL = "https://tiss.tuwien.ac.at/api/"
  def search_people(param)
    uri = "person/v21/psuche?q=" + param
    fetch_request(uri)
  end

  def get_person(id)
    uri = "person/v21/id/#{id}"
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
      JSON.parse(response.body)
    when 'text/html', 'application/xml'
      doc = Nokogiri::XML(response.body)
      doc.remove_namespaces!
    else
      raise "Unsupported content type #{response.content_type}"
    end
  end

end

