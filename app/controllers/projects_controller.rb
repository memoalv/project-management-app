class ProjectsController < ApplicationController
  def index
    @projects = current_user.organization.projects.kept if current_user.admin?
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.organization.projects.build(project_params)

    if @project.save
      redirect_to projects_path, notice: 'The project was created successfully'
    else
      render :new, alert: 'The project could not be saved'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to projects_path, notice: 'The project was updated successfully'
    else
      render :edit
    end
  end

  def destroy
    Project.destroy(params[:id])

    redirect_to projects_path, notice: 'The project was destroyed successfully'
  end

  private

  def project_params
    params.require(:project).permit(:title, :details, :expected_completion)
  end
end
