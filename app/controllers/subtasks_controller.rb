class SubtasksController < ApplicationController
  load_and_authorize_resource
  before_filter :find_task!
  # GET /subtasks
  # GET /subtasks.json
  def index
    @subtasks = Subtask.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subtasks }
    end
  end

  # GET /subtasks/1
  # GET /subtasks/1.json
  def show
    @subtask = Subtask.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subtask }
    end
  end

  # GET /subtasks/1
  # GET /subtasks/1.json
  def showc
    @subtask = Subtask.find(params[:subtask_id])
    @result = @subtask.results.where(:user_id => current_user).first
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subtask }
    end
  end

  # GET /subtasks/1
  # GET /subtasks/1.json
  def begin
    @subtask = Subtask.find(params[:subtask_id])
    @subtask.results << (Result.new(current_user))
    @result = @subtask.results.where(:user_id => current_user).first
    render "showc"
  end


  def end
    @subtask = Subtask.find(params[:subtask_id])
    @result = @subtask.results.where(:user_id => current_user).first
    @result.event_complete!
    respond_to do |format|
      if @result.save
        format.html { redirect_to project_task_subtask_begin_path(@project,@task,@subtask), notice: t('controllers.results.complete') }
        format.json { render json: @subtask }
      end
    end  
  end

  def pause
    @subtask = Subtask.find(params[:subtask_id])
    @result = @subtask.results.where(:user_id => current_user).first
    @result.event_pause!

     respond_to do |format|
      if @result.save
        format.html { redirect_to project_task_subtask_begin_path(@project,@task,@subtask), notice: 'Pausado.' }
        format.json { render json: @subtask }
      end
    end  
  end

  def start
    @subtask = Subtask.find(params[:subtask_id])
    @result = @subtask.results.where(:user_id => current_user).first
    @result.event_start!

    respond_to do |format|
      if @result.save
        format.html { redirect_to project_task_subtask_begin_path(@project,@task,@subtask), notice: 'Trabajando.' }
        format.json { render json: @subtask }
      end
    end  
  end

  def complete
    @result = @subtask.results.where(:user_id => current_user).first
    @result.event_complete
    respond_to @result.inspect
    @result.save
  end

  def new
    @subtask = Subtask.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subtask }
    end
  end

  # GET /subtasks/1/edit
  def edit
    @subtask = Subtask.find(params[:id])
  end

  # POST /subtasks
  # POST /subtasks.json
  def create
    @subtask = @task.subtasks.create(params[:subtask])

    respond_to do |format|
      if @subtask.save
        format.html { redirect_to project_task_path(@project,@task), notice: 'Subtask was successfully created.' }
        format.json { render json: @task, status: :created, location: @subtask }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subtasks/1
  # PUT /subtasks/1.json
  def update
    @subtask = Subtask.find(params[:id])

    respond_to do |format|
      if @subtask.update_attributes(params[:subtask])
        format.html { redirect_to project_task_subtask_path, notice: 'Subtask was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subtask.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subtasks/1
  # DELETE /subtasks/1.json
  def destroy
    @subtask = Subtask.find(params[:id])
    @subtask.destroy

    respond_to do |format|
      format.html { redirect_to project_task_path(@project,@task) , notice: "subtask deleted" }
      format.json { head :no_content }
    end
  end

  private

  def find_task!
    @task = Task.find(params[:task_id])
    @project = @task.project
  end
end
