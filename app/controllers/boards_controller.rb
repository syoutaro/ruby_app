class BoardsController < ApplicationController
  def index
    @boards = Board.order('created_at desc')
  end

  def new
    @user = current_user
    #binding.pry
    @board = @user.boards.build
  end

  def create
    @user = current_user
    @board = @user.boards.create(board_params)
    if @board.save
      flash[:notice] = "投稿しました。"
      redirect_to :root
    else
      flash[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  protected

  def board_params
    params.require(:board).permit(:title, :body)
  end
end
