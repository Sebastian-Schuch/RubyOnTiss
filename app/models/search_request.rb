# app/models/search_request.rb
class SearchRequest
  include ActiveModel::Model
  attr_accessor :query

  validates :query, presence: true
end
