class MstMusicsController < ApplicationController

	def edit
		@mst_music = MstMusic.find(params[:id])
		flash[:target_date] = params[:target_date]
		flash[:genre] = params[:genre]
		flash[:now_ranking] = params[:now_ranking]
	end

	def update
		@mst_music = MstMusic.find(params[:id])
		flash[:this_date] = flash[:target_date]
		flash[:name] = flash[:genre]
		flash[:now_ranking] = flash[:now_ranking]
		if @mst_music.update(mst_music_params)
			redirect_to root_path
		else
			render 'edit'
		end
	end

	private

		def mst_music_params
			params[:mst_music].permit(:youtube_url)
		end
end
