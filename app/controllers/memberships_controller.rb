# frozen_string_literal: true

class MembershipsController < ApplicationController
  def show
    membership = find_membership
    render_edit(membership)
  end

  def update
    membership = find_membership
    if membership.update(membership_params)
      redirect_to group_path(membership.group)
    else
      render_edit(membership)
    end
  end

  private

  def find_group
    current_user.groups.find(params[:group_id])
  end

  def find_membership
    group = find_group
    group.memberships.where(:user => current_user).first!
  end

  def membership_params
    params.require(:membership).permit(:name)
  end

  def render_edit(membership)
    render :edit,
           :locals => {
             :group => membership.group,
             :membership => membership,
           }
  end
end
