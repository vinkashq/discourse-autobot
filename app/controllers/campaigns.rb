require_dependency 'application_controller'

module Autobot
  class CampaignsController < ::ApplicationController

    def list
      render json: Autobot::Campaign.list
    end

    def create
      Autobot::Campaign.create(campaign_params.except(:id))
      render json: success_json
    end

    def update
      Autobot::Campaign.update(campaign_params)
      render json: success_json
    end

    def delete
      params.permit(:id)

      Autobot::Campaign.delete(params[:id])
      render json: success_json
    end

    private

      def campaign_params
        params.permit(:id, :provider_id, :source_id, :topic_id, :category_id, :key, :polling_frequency)
      end

  end
end
