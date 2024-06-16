# app/models/search_request.rb
class SearchRequest
  include ActiveModel::Model
  attr_accessor :search

  validates :search, presence: true, length: { minimum: 1, message: "Search term cannot be empty" }
end
