CONTRACTS = [
  { :name => "Contrat Professionnel", :code => "contrat_pro" },
  { :name => "Contrat d'Apprentissage", :code => "apprentissage" },
  { :name => "Stage", :code => "stage"}
]

class Contract < ActiveRecord::Base
  
  belongs_to :student
  belongs_to :company
  belongs_to :recruiter  
  
  validates_presence_of :student_id, :company_id, :recruiter_id, :kind
  validates_inclusion_of :kind, :in => CONTRACTS.map { |c| c[:code] }
  
  attr_accessible :student_id, :company_id, :recruiter_id, :kind, :start_date, :end_date
  
end
