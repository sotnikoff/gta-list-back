class IpParseJob < ApplicationJob
  queue_as :default

  def perform(idiot_id)
    idiot = Idiot.find(idiot_id)

    handler = IPinfo::create(Rails.application.credentials[:ipinfo_key])
    details = handler.details(idiot.ip)
    idiot.city = details.city
    idiot.country = details.country_name
    idiot.region = details.region
    idiot.longitude = details.longitude
    idiot.latitude = details.latitude
    idiot.save
  end
end
