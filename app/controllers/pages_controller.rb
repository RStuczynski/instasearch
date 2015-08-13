class PagesController < ApplicationController
  def home
    
    # %w() creates an array of strings, split by white space
    @tags = %w( OfficeLife
                caffeinated
                workit
                happyhour
                animalstyle
               )

    access_token = ENV["CONFIG_ACCESS_TOKEN"]
    client = Instagram.client(access_token: access_token)
    default_search = client.tag_search('theskimm')

    if params[:q].present?
      search_query = client.tag_search(params[:q])
      @tag = search_query.present? ? search_query : default_search
    else
      @tag  = default_search
    end

    #pulls in the relevant tag # (first, second, last) along with the name
    @tag = @tag.first.name
    @search = client.tag_recent_media(@tag)
    next_max_id = @search.pagination.next_max_id
    
    4.times do
      @next_result = client.tag_recent_media(@tag, :max_id => next_max_id )
      @search += @next_result
      next_max_id = @next_result.pagination.next_max_id
    end

  end
  
  def about
  end
end
