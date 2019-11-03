# frozen_string_literal: true

class InvitationsController < ApplicationController
  # POST /invitations
  def create
    group = find_group
    operation = InviteMemberToGroup.new(current_user)
    operation.process(invitation_params[:email], group)

    if operation.success?
      flash[:success] = "Invitation was successfully created."
      redirect_to group_memberships_path(group)
    else
      render_new(operation.result)
    end
  end

  # DELETE /invitations/1
  def destroy
    if params[:group_id]
      group = find_group
      invitation = find_invitation(group)
      destination = group_memberships_path(group)
    else
      invitation = find_invitation_by_token
      destination = root_path
    end

    invitation.destroy
    flash[:success] = "Invitation was successfully destroyed."
    redirect_to destination
  end

  # GET /invitations/new
  def new
    group = find_group
    invitation = Invitation.new(:group => group, :user => current_user)
    render_new(invitation)
  end

  def show
    invitation = find_invitation_by_token
    render_show(invitation)
  end

  def update
    # Accept invitation
    invitation = find_invitation_by_token
    add_current_user_to_group(invitation)
    delete_invitation(invitation)
    redirect_to(group_path(invitation.group))
  end

  private

  def add_current_user_to_group(invitation)
    group = invitation.group
    inviter = invitation.user
    AddUserToGroup.new(inviter).process(current_user, group)
  end

  def delete_invitation(invitation)
    invitation.destroy
  end

  def find_group
    Group.find(params[:group_id])
  end

  def find_invitation(group)
    group.invitations.find(params[:id])
  end

  def find_invitation_by_token
    Invitation.find_by_token!(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def invitation_params
    params.
      require(:invitation).
      permit(:email)
  end

  def render_new(invitation)
    render \
      :new,
      :locals => {
        :group => invitation.group,
        :invitation => invitation,
      }
  end

  def render_show(invitation)
    render \
      :show,
      :locals => {:invitation => invitation}
  end
end
