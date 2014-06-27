class StoriesController < ApplicationController
  before_action :load_story, only: [:edit, :show, :update]


  def index
  	@story = Story.search_for(params[:q])
  end

  def show
  	@story =  Story.find(params[:id])
  end

  def new 
  	@story = Story.new
  end

  def create
    @story = Story.new story_params
    @story.upvotes = 1
    if @story.save
      redirect_to @story
    else
      render 'new'
    end
  end

  def update
	  @story = Story.find(params[:id])
	  @story.update story_params
	  redirect_to @story
  end

private
    def story_params
      params.require(:story).permit(:title, :category, :link)
    end

	def load_story
		@story = Story.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		flash[:notice] = "Invalid story ID #{params[:id]}"
		redirect_to root_path
	end

end
