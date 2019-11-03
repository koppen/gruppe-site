# frozen_string_literal: true

class MembersController < ApplicationController
  def destroy
    @group = find_group
    @member = find_member
    @member.destroy
    flash[:success] = "Member was successfully destroyed."
    redirect_to group_members_path(@group)
  end

  # GET /members
  def index
    @group = find_group
    @members = Member.all
  end

  private

  def find_group
    Group.find(params[:group_id])
  end

  def find_member
    Member.find(params[:id])
  end

  def find_user
    # TODO: This seems like a security issue, being able to try out user ids and
    # get a 404 when it doesn't exist.
    User.find(params[:user_id])
  end
end