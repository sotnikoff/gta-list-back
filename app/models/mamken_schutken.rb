class MamkenSchutken < ApplicationRecord
  belongs_to :user
  belongs_to :idiot

  scope :by_user, lambda { |user_id|
    return all if user_id.nil?

    where(user_id: user_id)
  }

  scope :by_idiot, lambda { |idiot_id|
    return all if idiot_id.nil?

    where(idiot_id: idiot_id)
  }

  def self.by_query(params)
    by_user(params[:user_id])
      .by_idiot(params[:idiot_id])
  end
end
