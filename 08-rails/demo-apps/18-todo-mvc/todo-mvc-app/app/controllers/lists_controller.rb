class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update]

  def index
    @lists = List.all
  end

  def show

  end

  private
    def set_list
      @list = List.find_by(id: params[:id])
    end
end
