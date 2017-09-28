class Charity < ActiveRecord::Base
  validates :name, presence: true

  def credit_amount(amount)
    model = Charity.find(self.id)
    new_total = model.total + amount
    update_attributes({:total => new_total})
  end
end
