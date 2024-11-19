module Api
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_api_key

      private


    end
  end
end
