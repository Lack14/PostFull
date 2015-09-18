class BookmarksController < ApplicationController
	before_action :authenticate_user!
	def create
		@bookmark = current_user.bookmarks.new(book_params)
		respond_to do |format|
			if @bookmark.save
				format.html{redirect_to bookmark_path, notice:"El post se ha agregado al BookMark"}
				format.json{head :no_content}
			else
				redirect_to Post.find(post_params[:post_id]), error: "no pudimos procesar el pago"
				format.json{head :no_content}
			end
		end
	end
	def bookmark
		@bookmarks = current_user.bookmarks.all.order("created_at DESC").paginate(page: params[:page],per_page: 10)
	end
	private
	def book_params
		params.require(:bookmark).permit(:post_id)
	end
end