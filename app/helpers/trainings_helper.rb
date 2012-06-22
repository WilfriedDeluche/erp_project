# encoding: utf-8
module TrainingsHelper
  
  def submit_text(training)
    (training.persisted?) ? "Mettre à jour" : "Créer"
  end
end
