# encoding: utf-8
module KlassesHelper
  
  def form_url(klass)
    (klass.persisted?) ? class_path(klass) : classes_path
  end
  
  def submit_text(klass)
    (klass.persisted?) ? "Mettre à jour" : "Créer"
  end
end
