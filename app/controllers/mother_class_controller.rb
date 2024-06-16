# app/controllers/mother_class_controller.rb
require_relative '../services/tiss_http_fetcher'

class MotherClassController < ApplicationController
  def index
    authenticate_user
    tiss_http_fetcher = TissHttpFetcher.new
    @site_name = controller_name.capitalize

    @search_data_response = []
    @detail = nil
    perform_search(tiss_http_fetcher) if params[:search].present?
    Rails.logger.debug { "search_#{controller_name.singularize}" }
    fetch_details(tiss_http_fetcher) if params[:id].present?
    @id = params[:id] if params[:id].present?
  end

  def perform_search(tiss_http_fetcher)
    Rails.logger.debug { "search_#{controller_name.singularize}" }
    search_request = SearchRequest.new(query: params[:search])
    if search_request.valid?
      search_method = "search_#{controller_name.singularize}"
      if tiss_http_fetcher.respond_to?(search_method)
        @search_data_response = tiss_http_fetcher.send(search_method, params[:search])
      else
        flash[:error] = "Search method for #{controller_name} not implemented"
      end
    else
      flash[:error] = "Search query cannot be empty"
    end
  end

  def fetch_details(tiss_http_fetcher)
    fetch_method = "get_#{controller_name.singularize}"
    if tiss_http_fetcher.respond_to?(fetch_method)
      @detail = tiss_http_fetcher.send(fetch_method, params[:id])
      parse_xml(@detail) if @detail.present?
    else
      flash[:error] = "Fetch method for #{controller_name} not implemented"
    end
  end

  def search
    render :index
  end

  def get_details
    parse_xml @detail if @detail.present?
    render :detail
  end

  def parse_xml(xml)
    raise NotImplementedError, "Subclasses must implement the parse_xml method"
  end

  def add_favorite
    @id = params[:id]
    @time = Time.now
    # Add logic to save to the favorites list
  end
end
