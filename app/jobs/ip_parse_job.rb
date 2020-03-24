class IpParseJob < ApplicationJob
  queue_as :default

  def perform(idiot)
    p idiot
  end
end
