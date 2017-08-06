class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy, :redirect]
  protect_from_forgery unless: -> { request.format.json? }

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.find_by_url(entry_params["url"]) || Entry.new(entry_params)
    respond_to do |format|
      if @entry.save
        @encoded_id = IdEncoder.encoded_id(@entry.id)
        format.html {redirect_to entry_url(@encoded_id), notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: entry_url(@encoded_id) }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def redirect
    redirect_to @entry.url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @encoded_id = params["id"]
      @entry = Entry.find(IdEncoder.decoded_id(@encoded_id))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:url)
    end
end
