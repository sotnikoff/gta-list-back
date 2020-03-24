class Idiot < ApplicationRecord
  include Discard::Model

  enum mom_joke: { mj_none: 0, mj_seldom: 1, mj_normal: 2, mj_often: 3, mj_very_often: 4 }
  enum cheats: { cheats_none: 0, cheats_some: 1, cheats_impulse: 2 }
  validates :name, presence: true
  belongs_to :author, class_name: 'User', foreign_key: :created_by

  before_save :check_ip

  def self.sync(overseer)
    not_found_idiots = overseer.map { |o| o if Idiot.find_by(r_star_id: o[0]).blank? }
      .compact
    not_found_idiots.each { |o| create_not_found_idiot(o) }
    show_idiots_in_overseer_format
  end

  scope :visible, lambda {
    where(draft: [false, nil]).kept
  }

  scope :drafts, lambda {
    where(draft: true).kept
  }

  def self.query(params)
    if params[:drafts].present? && params[:drafts] != 'false' 
      drafts
    else
      visible
    end
  end

  def check_ip
    return true unless ip_changed?

    return true if ip.nil?

    handler = IPinfo::create(Rails.application.credentials[:ipinfo_key])
    details = handler.details(ip)
    self.city = details.city
    self.country = details.country_name
    self.region = details.region
    self.longitude = details.longitude
    self.latitude = details.latitude
  end

  def self.create_not_found_idiot(overseer_data)
    Idiot.create(
      r_star_id: overseer_data[0],
      auto_kick: overseer_data[1],
      warn_me: overseer_data[2],
      freeze_player: overseer_data[4],
      blame: overseer_data[5],
      explode: overseer_data[6],
      name: overseer_data[7],
      imported: true
    )
  end

  def self.show_idiots_in_overseer_format
    idiots = Idiot.visible.order('name ASC')
    idiots.map do |idiot|
      mom_joke = ''
      mom_joke = '[MJ1]' if idiot.mj_seldom?
      mom_joke = '[MJ2]' if idiot.mj_normal?
      mom_joke = '[MJ3]' if idiot.mj_often?
      mom_joke = '[MJ4]' if idiot.mj_very_often?
      cheat = ''
      cheat = '[CHEAT]' if idiot.cheats_some?
      cheat = '[IMP]' if idiot.cheats_impulse?
      [
        idiot.r_star_id,
        (idiot.auto_kick ? 1 : 0),
        (idiot.warn_me ? 1 : 0),
        1,
        (idiot.freeze_player ? 1 : 0),
        (idiot.blame ? 1 : 0),
        (idiot.explode ? 1 : 0),
        "#{idiot.name}#{mom_joke}#{cheat}"
      ]
    end
  end
end
