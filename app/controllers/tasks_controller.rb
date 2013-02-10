class TasksController < ApplicationController
  load_and_authorize_resource
  before_filter :find_project!

  def index
    @tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  def show
    @task = Task.find(params[:id])
    @subtask = Subtask.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end


  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = @project.tasks.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to @project, notice: 'Task was successfully created.' }
        format.json { render json: @project, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to project_task_path(@project,@task), notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to @project, notice: 'Task was successfully destroy.' }
      format.json { head :no_content }
    end
  end

  def find_project!
    @project = Project.find(params[:project_id])
  end
end
