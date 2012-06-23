# encoding: utf-8
module SubjectsHelper
  
  def submit_text(subject)
    (subject.persisted?) ? "Mettre à jour" : "Créer"
  end
end
