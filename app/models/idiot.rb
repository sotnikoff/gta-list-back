class Idiot < ApplicationRecord
  include Discard::Model

  enum mom_joke: { mj_none: 0, mj_seldom: 1, mj_normal: 2, mj_often: 3, mj_very_often: 4 }
  enum cheats: { cheats_none: 0, cheats_some: 1, cheats_impulse: 2 }
  validates :r_star_id, :name, presence: true
end
