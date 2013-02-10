class StatisticsController < ApplicationController
  # GET /results
  # GET /results.json
  def index
    @results = Result.all
    @projects = Project.all
    @subtasks = Subtask.all
    @tasks = Task.all
  end
end
