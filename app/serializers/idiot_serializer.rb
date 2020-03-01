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
             :explode,
             :cheats,
             :created_at,
             :updated_at
end
