class Petition < ApplicationRecord
  belongs_to :user

  def to_label
    "submitted by #{user.email} on #{created_at.to_date}"
  end
end
