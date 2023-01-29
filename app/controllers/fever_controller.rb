# frozen_string_literal: true

class FeverController < ApplicationController
  skip_before_action :complete_setup, only: [:index, :update]
  skip_before_action :authenticate_user, only: [:index, :update]
  before_action :authenticate_fever

  def index
    render(json: FeverAPI::Response.new(params))
  end

  def update
    render(json: FeverAPI::Response.new(params))
  end

  private

  def authenticate_fever
    return if keys_match?(User.first.api_key, params[:api_key].to_s)

    render(json: { api_version: FeverAPI::API_VERSION, auth: 0 })
  end

  def keys_match?(key_a, key_b)
    ActiveSupport::SecurityUtils.secure_compare(key_a, key_b)
  end
end