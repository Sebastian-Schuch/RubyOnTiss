class PersonController < MotherclassController


  def test
    render html: @search
  end

  def search(param)
    #@search = param
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
