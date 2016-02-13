class HomeController < ApplicationController
  def index
  end

  def search
  	# FlickRaw.configure do |config|
	  	FlickRaw.api_key=ENV['FLICKR_KEY']
		FlickRaw.shared_secret=ENV["FLICKR_SECRET"]
	# end
	@user = flickr.people.findByUsername(:username =>params[:name_query])
	@user_id = @user.id
	@user_photos = flickr.people.getPhotos(:user_id => @user_id)
	@user_photo_array = []
		@user_photos.each do |p| 
			p = p.id
			photo = flickr.photos.getInfo(:photo_id => p)
			@user_photo_array.push(photo)
			end
	render 'index'
  end

  def search_text
  	@photos = flickr.photos.search(:text => params[:query])
  	render 'index'
  end
end
