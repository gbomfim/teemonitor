require_relative 'tee'

class Store
  attr_accessor :name, :url, :domain, :tees
  def initialize()
        @tees = []
  end 
end

