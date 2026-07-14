class BoardsController < ApplicationController
  
  def index


  private 
  def boards_params
    params.permit(:title, :slug, :visibility, :owner_id, :workspace_id)
  end
end