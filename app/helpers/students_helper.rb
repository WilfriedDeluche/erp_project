# encoding: utf-8
module StudentsHelper
  
  def student_is_captain(student)
    return unless student.is_captain
    content_tag(:span, :class => "label label-info") do
      "Délégué"
    end
  end
  
  def student_is_student_union_member(student)
    return unless student.is_student_union_member
    content_tag(:span, :class => "label") do
      "Membre du BDE"
    end
  end
end
