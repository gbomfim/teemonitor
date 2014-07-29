class Page
      attr_accessor :uri,
                    :url,
                    :configObj,
                    :doc,
                    :tees

      def initialize(configObj)
            @uri = URI.parse(configObj["url"])
            @configObj = configObj

            @store = Store.new
            @store.name = @configObj["name"]
            @store.url = @configObj["url"]
            @store.domain = @uri.host
      end 

end

