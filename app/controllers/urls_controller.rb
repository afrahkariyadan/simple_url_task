class UrlsController < ApplicationController

  def index
    @urls = Url.all
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    @url.short_url =@url.generate_short_url
    @url.long_url = @url.sanitize
    if @url.save
      redirect_to urls_path
    else
      flash[:error] = @url.errors.full_messages
      redirect_to new_url_path
    end
  end

  def show
    print params
    @url = Url.find_by(id: params[:id])
    redirect_to @url.long_url,allow_other_host: true
  end

  private
  
  def url_params
    params.require(:url).permit(:long_url,:short_url)
  end
end