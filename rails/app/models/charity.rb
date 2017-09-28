class Charity < ActiveRecord::Base
  validates :name, presence: true

  def credit_amount(amount)
    new_total = total + amount
    update_attributes({:total => new_total})
  end
end
