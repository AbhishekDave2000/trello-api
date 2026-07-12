class BoardsController < ApplicationController
  


  private 
  def boards_params
    params.permit(:title, :slug, :visibility, :owner_id, :workspace_id)
  end
end