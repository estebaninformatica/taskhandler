class ResultsController < ApplicationController
  load_and_authorize_resource
  before_filter :find_result!,:except => :index
  respond_to :html, :json

  # GET /results
  # GET /results.json

  def index
    @search = Result.search(params[:q])
    @results = @search.result(:distinct => true)
    respond_to do |format|
      format.html
      format.csv { send_data @results.to_csv }
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end
  end

  # GET /results/1
  # GET /results/1.json
  def show
    respond_with @result
  end

  # GET /results/new
  # GET /results/new.json
  def new
    @result = Result.new
    respond_with @result
  end

  # GET /results/1/edit
  def edit
    respond_with @result
  end

  # POST /results
  # POST /results.json
  def create 
    @result = Result.new(params[:result])
    flash[:notice] = t('controllers.results.created') if @result.save
    respond_with @result
  end

  # PUT /results/1
  # PUT /results/1.json
  def update
    @result.event_finish!
    if @result.update_attributes(params[:result])
      flash[:notice] = t('controllers.results.updated')
      redirect_to (project_task_path(@project,@task))
    else
      flash[:notice] = t('controllers.results.uncomplete') 
      redirect_to project_task_subtask_showc_path(@project,@task,@subtask)
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    if current_user.admin? then
      respond_with @result
    else
       redirect_to (project_task_path(@project,@task))
    end
  end

  # GET /subtasks/new
  # GET /subtasks/new.json

  private

  def find_result!
    @result = Result.find(params[:id]) if params[:id]
    @subtask = @result.subtask
    @task = @subtask.task
    @project = @task.project
  end
end
