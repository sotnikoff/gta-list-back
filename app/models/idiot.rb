class Idiot < ApplicationRecord
  include Discard::Model

  enum mom_joke: { mj_none: 0, mj_seldom: 1, mj_normal: 2, mj_often: 3, mj_very_often: 4 }
  enum cheats: { cheats_none: 0, cheats_some: 1, cheats_impulse: 2 }

  validates :name, presence: true
  validates :name, uniqueness: true

  belongs_to :author, class_name: 'User', foreign_key: :created_by
  has_many :mamken_schutkens, dependent: :destroy
  has_one :profile

  after_save :check_ip

  def self.sync(overseer, current_user)
    count = 0
    not_found_idiots = overseer.map { |o|
      idiot = Idiot.find_by(r_star_id: o[0])
      if idiot.present?
        idiot.update(draft: false) if idiot.draft
        nil
      else
        o
      end
    }.compact
    not_found_idiots.each { |o|
      count += 1 if create_not_found_idiot(o, current_user)
    }
    show_idiots_in_overseer_format(count)
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
    return true if !saved_changes.key?('ip')

    return true if ip.nil?

    IpParseJob.set(wait: 3.seconds).perform_later(id)
  end

  def self.create_not_found_idiot(overseer_data, current_user)
    idiot = Idiot.find_by(name: overseer_data[7])
    idiot_created = idiot.nil?
    idiot = Idiot.new if idiot.nil?

    return if overseer_data[7] == 'Empty note'


    idiot.assign_attributes(
      r_star_id: overseer_data[0],
      auto_kick: overseer_data[1],
      warn_me: overseer_data[2],
      freeze_player: overseer_data[4],
      blame: overseer_data[5],
      explode: overseer_data[6],
      name: overseer_data[7],
      author: current_user,
      imported: true,
      draft: false
    )
    idiot.save
    idiot_created
  end

  def self.show_idiots_in_overseer_format(count)
    idiots = Idiot.visible.kept.order('name ASC')
    formatted_idiots = idiots.map do |idiot|
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
        "#{idiot.name}#{idiot.mom_joke_ratio}#{cheat}"
      ]
    end
    { idiots: formatted_idiots, zero_count: count.zero? }
  end
end
