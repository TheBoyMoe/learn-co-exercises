class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource only: [:show, :edit, :update, :destroy]

  def index
    @notes = (current_user)? current_user.readable : []
  end

  def show

  end

  def new
    @note = Note.new
  end

  def create
    if current_user
      note = Note.new(note_params)
      note.user = current_user
      note.save
    end
    redirect_to root_url
  end

  def edit
  end

  def update
    @note.update(note_params)
    redirect_to root_url
  end

  def destroy
  end

  private
    def set_note
      @note = Note.find_by(id: params[:id])
    end

    def note_params
      params.require(:note).permit(:content, :visible_to)
    end
end
