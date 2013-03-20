class Medicament < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.custom_find_by_name commercial_name
    Medicament.where('commercial_name ILIKE ?', "%#{commercial_name}%")
  end

end
