class BoardsController < ApplicationController
  before_action :ensure_correct_user, only: %i[update destroy]
  before_action :set_target_board, only: %i[show edit update destroy]

  def index
    @boards = Board.order('created_at desc')
  end

  def new
    #binding.pry
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
    params.require(:board).permit(:title, :body)
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
