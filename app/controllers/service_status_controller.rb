class ServiceStatusController < ApplicationController
  def index
    if File.exists?(Rails.root.join(".service-unavailable"))
      render nothing: true, status: 503
    else
      render nothing: true, status: 200
    end
  end
end
