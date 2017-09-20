require_dependency 'application_controller'

module Autobot
  class CampaignsController < ::ApplicationController

    def list
      render json: Autobot::Campaign.list
    end

    def create
      params.permit(:source_id, :topic_id, :category_id, :key, :interval)

      Autobot::Campaign.create(params[:source_id], params[:topic_id], params[:category_id], params[:key], params[:interval])
      render json: success_json
    end

    def delete
      params.permit(:id)

      Autobot::Campaign.delete(params[:id])
      render json: success_json
    end
  end
end
