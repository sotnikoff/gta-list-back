class IdiotSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :death_date,
             :r_star_id,
             :pazient_diagnos,
             :comment,
             :agressive,
             :mom_joke,
             :imported,
             :auto_kick,
             :warn_me,
             :freeze_player,
             :blame,
             :mom_joke_ratio,
             :streamer,
             :explode,
             :cheats,
             :ip,
             :city,
             :country,
             :region,
             :latitude,
             :longitude,
             :discarded_at,
             :created_at,
             :updated_at

  attribute :profile_id

  def profile_id
    object.profile&.id.presence
  end
end
