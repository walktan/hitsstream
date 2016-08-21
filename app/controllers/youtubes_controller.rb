# controller
class YoutubesController < ApplicationController
  def edit
    @youtube = Youtube.find(params[:id])
    @new_url = ""
    flash[:target_date_id] = params[:target_date_id]
    flash[:itune_id] = params[:itune_id]
    flash[:running_ranking] = params[:running_ranking]
  end

  def confirm
    @youtube = Youtube.find(params[:id])
    @new_url = params[:new_url]
    flash[:target_date_id] = flash[:target_date_id]
    flash[:itune_id] = flash[:itune_id]
    flash[:running_ranking] = flash[:running_ranking]
  end

  def update
    @youtube = Youtube.find(params[:id])
    flash[:target_date_id] = flash[:target_date_id]
    flash[:itune_id] = flash[:itune_id]
    flash[:running_ranking] = flash[:running_ranking]
    if @youtube.update(youtube_params)
      redirect_to root_path
    else
      render "edit"
    end
  end

  private

  def youtube_params
    params[:youtube].permit(:youtube_url)
  end
end
