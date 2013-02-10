class ProjectsController < ApplicationController
	load_and_authorize_resource
	respond_to :html, :json

	def index
		@projects = Project.all
		respond_with @projects
	end

	def show
		@project = Project.find(params[:id])
		@task    = Task.new
		respond_with @project
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(params[:project])
		flash[:notice] = t('controllers.results.created') if @project.save
    	respond_with @project
	end

	def update
		@project = Project.find(params[:id])
		respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", notice:"error" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end

	end

	def destroy
		@project = Project.find(params[:id])
		@project.destroy
		redirect_to action: :index
	end

	def edit
		@project = Project.find(params[:id])
	end

end
