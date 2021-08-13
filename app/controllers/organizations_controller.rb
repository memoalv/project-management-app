class OrganizationsController < ApplicationController
  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])

    trx_success = true
    begin
      ApplicationRecord.transaction do
        @organization.update!(organization_params)

        if @organization.plan.premium?
          @organization.restore_projects
        else
          @organization.discard_old_projects
        end
      end
    rescue
      trx_success = false
    end

    if trx_success
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
