class BoardsController < ApplicationController
  before_action :ensure_correct_user, only: %i[update destroy]
  before_action :set_target_board, only: %i[show edit update destroy]

  def index
    @boards = params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all
    @boards = @boards.page(params[:page]).per(6).order('updated_at DESC')
  end

  def new
    @board = current_user.boards.new
  end

  def create
    @board = current_user.boards.create(board_params)
    if @board.save
      flash[:notice] = "投稿しました。"
      redirect_to :root
    else
      flash[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def show
    @comment = Comment.new(board_id: @board.id)
  end

  def edit
  end

  def update
    if @board.update(board_params)
      flash[:notice] = "編集しました。"
      redirect_to edit_board_path
    else
      flash[:alert] = "編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @board.destroy
    flash[:notice] = "削除しました。"
    redirect_to :root
  end

  protected

  def board_params
    params.require(:board).permit(:title, :body, tag_ids:[])
  end

  def ensure_correct_user
    @board = Board.find(params[:id])
    if @board.user_id != current_user.id
      flash[:alert] = "投稿者しか編集できません"
      render :edit
    end
  end

  def set_target_board
    @board = Board.find(params[:id])
  end

end
