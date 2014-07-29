require_relative 'models/page'
require_relative 'models/store'
require_relative 'models/tee'

class PageManager
  def initialize(page)
    @page = page
  end

  public
  def loadPage
    if @page.doc == nil
      @page.doc = Nokogiri::HTML(@page.uri.open)
    end
    @page
  end

  def buildStoreData
    storeData = Store.new
    storeData.name = @page.configObj["site"]
    storeData.url = @page.configObj["url"]
    storeData.domain = storeData.url.split("www.")[1]

    elements = @page.configObj["elements"]
    elements.each do |obj|

      @page.doc.css(obj["main_selector"]).each do |el|
        tee = Tee.new()
        obj["selectors"].each do |sel|
          if sel["selector"] == nil || sel["selector"]  == ""
            val  = el[sel["attribute"]]
          else
            target = el.css(sel["selector"])
            attribute = sel["attribute"]
            if attribute == "content"
              val = target.text
            else
              val = target[0][attribute] unless target.length == 0
            end
          end

          tee.setData(sel["name"], val) unless (val == nil or val == "")
        end

        storeData.tees.push(tee) unless tee.data.length == 0
      end
    end

    return storeData
  end

end
