# encoding: utf-8
module LessonsHelper
  def if_exam(lesson)
    if lesson.is_test
      return '<p><span class="label label-important">EXAMEN</span></p>'
    end
  end
end
