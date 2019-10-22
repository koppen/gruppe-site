# frozen_string_literal: true

class GroupsController < ApplicationController
  # POST /groups
  def create
    operation = CreateGroup.new(current_user)
    operation.process(group_params)

    if operation.success?
      flash[:success] = "Group was successfully created."
      redirect_to operation.result
    else
      @group = operation.result
      render :new
    end
  end

  # DELETE /groups/1
  def destroy
    @group = find_group
    @group.destroy
    flash[:success] = "Group was successfully destroyed."
    redirect_to groups_url
  end

  # GET /groups/1/edit
  def edit
    @group = find_group
  end

  # GET /groups
  def index
    @groups = Group.all
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1
  def show
    @group = find_group
  end

  # PATCH/PUT /groups/1
  def update
    @group = find_group

    if @group.update(group_params)
      flash[:success] = "Group was successfully updated."
      redirect_to @group
    else
      render :edit
    end
  end

  private

  def find_group
    Group.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def group_params
    params.
      require(:group).
      permit(:name, :description)
  end
end
