# frozen_string_literal: true

class InvitationsController < ApplicationController
  # POST /invitations
  def create
    group = find_group
    invitation = Invitation.new(invitation_params)
    invitation.group = group
    invitation.user = current_user

    if invitation.save
      flash[:success] = "Invitation was successfully created."
      redirect_to group_members_path(group)
    else
      render :new,
             :locals => {
               :group => group,
               :invitation => invitation,
             }
    end
  end

  # DELETE /invitations/1
  def destroy
    group = find_group
    @invitation = find_invitation(group)
    @invitation.destroy
    flash[:success] = "Invitation was successfully destroyed."
    redirect_to group_members_path(group)
  end

  # GET /invitations/new
  def new
    group = find_group
    invitation = Invitation.new(:group => group, :user => current_user)
    render :new,
           :locals => {
             :group => group,
             :invitation => invitation,
           }
  end

  private

  def find_group
    Group.find(params[:group_id])
  end

  def find_invitation(group)
    group.invitations.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def invitation_params
    params.
      require(:invitation).
      permit(:email)
  end
end
