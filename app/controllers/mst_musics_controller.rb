class MstMusicsController < ApplicationController
	def edit
		@mst_music = MstMusic.find(params[:id])
	end

	def update
		@mst_music = MstMusic.find(params[:id])
		if @mst_music.update(mst_music_params)
			redirect_to '/'
		else
			render 'edit'
		end
	end

	private

		def mst_music_params
			params[:mst_music].permit(:youtube_url)
		end
end
