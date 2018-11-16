class TagsController < ApplicationController

  def new
    @tag = Tag.new
  end

  def create
    tag = Tag.create(tag_params)
    if tag.save
      flash[:notice] = 'タグを作成しました'
      redirect_to :root
    else
      flash[:alert] = 'タグを作成できませんでした。'
      render :new
    end
  end

  def destroy
  end

  protected

  def tag_params
    params.require(:tag).permit(:name)
  end
end
