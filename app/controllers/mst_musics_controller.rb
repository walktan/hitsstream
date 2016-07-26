class MstMusicsController < ApplicationController
  def edit
    @mst_music = MstMusic.find(params[:id])
    @new_url = ""
    flash[:target_date] = params[:target_date]
    flash[:genre_name] = params[:genre_name]
    flash[:running_ranking] = params[:running_ranking]
  end

  def confirm
    @mst_music = MstMusic.find(params[:id])
    @new_url = params[:new_url]
    flash[:target_date] = flash[:target_date]
    flash[:genre_name] = flash[:genre_name]
    flash[:running_ranking] = flash[:running_ranking]
  end

  def update
    @mst_music = MstMusic.find(params[:id])
    flash[:target_date] = flash[:target_date]
    flash[:genre_name] = flash[:genre_name]
    flash[:running_ranking] = flash[:running_ranking]
    if @mst_music.update(mst_music_params)
      redirect_to root_path
    else
      render "edit"
    end
  end

  private

  def mst_music_params
    params[:mst_music].permit(:youtube_url)
  end
end
