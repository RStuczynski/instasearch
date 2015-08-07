class PagesController < ApplicationController
  def home
    #access_token = ENV["CONFIG.ACCESS_TOKEN"]
    access_token = "4330862.3844d3a.d398a47a5f54476897bf7c5431dfc70b"
    client = Instagram.client(access_token: access_token)
    default_search = client.tag_search('skimmlife')

    if params[:q]
      search_query = client.tag_search(params[:q])
      @tag = search_query.present? ? search_query : default_search
    else
      @tag = default_search
    end
    
    @tag = @tag.first.name
    @search = client.tag_recent_media(@tag)
    
  end
  
  def about
  end
end
