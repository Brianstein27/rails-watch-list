class ListsController < ApplicationController
  before_action :set_list, only: %i[destroy show]
  def index
    @lists = List.all
    @list = List.new
  end

  def show
    @bookmarks = Bookmark.where(list: @list)
    @bookmark = Bookmark.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list.delete

    redirect_to list_path(@list), status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
