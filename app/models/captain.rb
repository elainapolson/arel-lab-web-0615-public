class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(:boats => :classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
    includes(:boats => :classifications).where(classifications: {name: 'Sailboat'}).distinct
  end

  def self.motorboaters
    includes(:boats => :classifications).where(classifications: {name: 'Motorboat'}).distinct
  end

  def self.talented_seamen
    where("id IN (?)", self.motorboaters.pluck(:id)&self.sailors.pluck(:id))
  end

  def self.non_sailors
    where("id NOT IN (?)", self.sailors.pluck(:id))
  end

end
