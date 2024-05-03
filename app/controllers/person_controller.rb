require_relative '../services/tiss_http_fetcher.rb'

class PersonController < MotherclassController



  def test
    render html: @search
  end

  def search
    @searchDataResponse = []
    if params[:search].present?
      tiss_http_fetcher = TissHttpFetcher.new
      param = params[:search]
      @searchDataResponse = tiss_http_fetcher.search_people param
    end
    render :index
  end

  def getDetails(id)
    @id = id
  end

  def parseXML(xml)
    @xml = xml
  end

  def addFavorite(id)
    @id = id
    @time = Time.now
  end


end
