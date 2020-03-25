class IpParseJob < ApplicationJob
  queue_as :default

  def perform(idiot_id)
    idiot = Idiot.find(idiot_id)

    response = HTTParty.get("https://ipinfo.io/#{idiot.ip}?token=#{Rails.application.credentials[:ipinfo_key]}")
    return if response.code != 200

    result = response.to_h
    idiot.latitude = result['loc'].split(',').first.to_f
    idiot.longitude = result['loc'].split(',').last.to_f
    idiot.country = result['country']
    idiot.city = result['city']
    idiot.region = result['region']
    idiot.save
  end
end
