class UrlsController < ApplicationController
  def index
  end

  def new
    @url = Url.new
  end

  def create
    #instead of having a private url_params method, you could
    #just add
    #safe_url_params = params.require(:url).permit(:link)
    #here
    @url = Url.new(url_params) # or Url.new safe_url_params
    @url.hash_code = rand(1..10000)
    # For the bonus
    # @url.hash_code = SecureRandom.urlsafe_base64(8)

    if @url.save
      redirect_to @url
    else
      render 'new'
    end
  end

  def update
    @url = Url.find(params[:id])
    @url.update url_params
    redirect_to @url
  end

  def show
    @url = Url.find(params[:id])
    @full_path = "#{request.protocol}#{request.host_with_port}/#{@url.hash_code}"  #localhost:3000/hash_code
  end

  def redirector
    @url = Url.find_by hash_code: params[:code] #or Url.find_by_hash_code(params[:code])
    if @url
      redirect_to @url.link
    else
      redirect_to root_path
    end
  end


  def preview
    @url = Url.find_by hash_code: params[:code]
    unless @url
      redirect_to root_path
    end
  end



private
    def url_params
      params.require('url').permit(:link)
    end

  end