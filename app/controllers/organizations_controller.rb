class OrganizationsController < ApplicationController
  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])

    if @organization.update(organization_params)
      redirect_to helpers.home_path, notice: 'The organization was updated successfully'
    else
      render :edit
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :plan_id, :card_number, :cvv, :expiration_date)
  end
end
