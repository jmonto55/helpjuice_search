class QueriesController < ApplicationController
  before_action :set_query, only: %i[ show edit update destroy ]

  def index
    @queries = Query.all.order(created_at: :desc)
    @most_recent_search = Query.last
    @most_popular_search = Query.most_popular_search
    @most_frequent_user = Query.most_frequent_user
    @quantity_of_queries = Article.count
  end

  def new
    @query = Query.new
  end

  def create
    existing_query = Query.where("created_at >= ?", 1.minute.ago).first
  
    if existing_query
      existing_query.update(search: query_params[:search])
  
      respond_to do |format|
        format.html { redirect_to query_url(existing_query), notice: "Query was successfully updated." }
        format.json { render :show, status: :ok, location: existing_query }
      end
    else
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

  def destroy
    @query.destroy

    respond_to do |format|
      format.html { redirect_to queries_url, notice: "Query was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_query
      @query = Query.find(params[:id])
    end

    def query_params
      params.require(:query).permit(:user_ip, :search)
    end
end
