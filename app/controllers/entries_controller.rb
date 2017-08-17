class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy, :redirect]
  protect_from_forgery unless: -> { request.format.json? }

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    if params["url"].present?
      # If there is an url parameter, it came from the Javascript
      # bookmarklet and we can immediately create it.
      create_from_url params["url"]
    else
      @entry = Entry.new
    end
  end

  # POST /entries
  # POST /entries.json
  def create
    create_from_url entry_params["url"]
  end

  def redirect
    redirect_to @entry.url
  end

  private

    def create_from_url(url)
      # If there is an existing entry for that URL, use that.
      # Otherwise, make a new one.
      @entry = Entry.find_by_url(url) || Entry.new(url: url)
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
