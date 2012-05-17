CONTRACTS = [
  { :name => "Contrat Professionnel", :code => "contrat_pro" },
  { :name => "Contrat d'Apprentissage", :code => "apprentissage" },
  { :name => "Stage", :code => "stage" }
]

class Contract < ActiveRecord::Base
  
  belongs_to :student
  belongs_to :company
  belongs_to :recruiter  
  
  validates_presence_of :student_id, :company_id, :recruiter_id, :kind
  validates_inclusion_of :kind, :in => CONTRACTS.map { |c| c[:code] }
  
  validate :student_must_not_be_under_contract
  attr_accessible :student_id, :company_id, :recruiter_id, :kind, :start_date, :end_date
  
  
  def student_must_not_be_under_contract
    self.student.contracts.each do |contract|
      case_1 = contract.start_date < self.start_date && contract.end_date > self.end_date
      case_2 = self.start_date < contract.start_date && self.end_date > contract.start_date
      case_3 = self.start_date < contract.end_date && self.end_date > contract.end_date
      errors.add :contract, 'est deja en cours a cette periode' if case_1 || case_2 || case_3
    end
  end
end
