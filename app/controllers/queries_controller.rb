class QueriesController < ApplicationController
  before_action :set_query, only: %i[ show edit update destroy ]

  # GET /queries or /queries.json
  def index
    @queries = Query.all
    @most_recent_search = Query.last
    @most_popular_search = Query.most_popular_search
    @most_frequent_user = Query.most_frequent_user
    @quantity_of_queries = Article.count
  end

  # GET /queries/1 or /queries/1.json
  def show
  end

  # GET /queries/new
  def new
    @query = Query.new
  end

  # GET /queries/1/edit
  def edit
  end

  # POST /queries or /queries.json
  def create
    # Find queries with the same search and user_ip created in the last minute
    existing_query = Query.where(
      user_ip: request.remote_ip
    ).where("created_at >= ?", 15.second.ago).first
  
    if existing_query
      # If a similar query exists, update the existing one with the new search
      existing_query.update(search: query_params[:search])
  
      respond_to do |format|
        format.html { redirect_to query_url(existing_query), notice: "Query was successfully updated." }
        format.json { render :show, status: :ok, location: existing_query }
      end
    else
      # Create a new query if a similar one doesn't exist
      @query = Query.new(query_params)
      @query.user_ip = request.remote_ip
  
      respond_to do |format|
        if @query.save
          format.html { redirect_to query_url(@query), notice: "Query was successfully created." }
          format.json { render :show, status: :created, location: @query }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @query.errors, status: :unprocessable_entity }
        end
      end
    end
  end  

  # PATCH/PUT /queries/1 or /queries/1.json
  def update
    respond_to do |format|
      if @query.update(query_params)
        format.html { redirect_to query_url(@query), notice: "Query was successfully updated." }
        format.json { render :show, status: :ok, location: @query }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @query.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /queries/1 or /queries/1.json
  def destroy
    @query.destroy

    respond_to do |format|
      format.html { redirect_to queries_url, notice: "Query was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query
      @query = Query.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def query_params
      params.require(:query).permit(:user_ip, :search)
    end
end
