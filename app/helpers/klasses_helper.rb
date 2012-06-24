# encoding: utf-8
module KlassesHelper
  
  def form_url(klass)
    (klass.persisted?) ? class_path(klass) : classes_path
  end
end
