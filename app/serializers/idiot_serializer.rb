class IdiotSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :death_date,
             :r_star_id,
             :pazient_diagnos,
             :comment,
             :agressive,
             :mom_joke,
             :is_cheater,
             :created_at,
             :updated_at
end
