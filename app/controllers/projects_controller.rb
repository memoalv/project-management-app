class ProjectsController < ApplicationController
  def index
    @projects = current_user.organization.projects if current_user.admin?
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.organization.projects.build(project_params)

    if @project.save
      # TODO: redirect to organizations home
      redirect_to projects_path, notice: 'The project was created successfully'
    else
      render :new, alert: 'The project could not be saved'
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :details, :expected_completion)
  end
end
