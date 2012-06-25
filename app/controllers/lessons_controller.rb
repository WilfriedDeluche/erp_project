# encoding: utf-8
class LessonsController < ApplicationController
  before_filter :students_or_school_users_or_teacher_only
  before_filter :find_lesson, :only => [:show, :edit, :update, :destroy]
  before_filter :find_all_sujects_klasses_and_teachers, :only => [:new, :edit, :create]
  
  def index
    if student_signed_in?
      @lessons = Lesson.find_all_by_klass_id(current_user.rolable.klasses.order("year DESC").first.id)
    elsif teacher_signed_in?
      @lessons = Lesson.find_all_by_teacher_id(current_user.rolable.id)
    elsif school_user_signed_in?
      @lessons = Lesson.order("start_date ASC").all
    end
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end
  
  def show
  end
  
  def new
    if school_user_signed_in?
      @lesson = Lesson.new
    else
      access_denied
    end
  end

  def edit
    unless school_user_signed_in?
      access_denied
    end
  end
  
  def create
    if school_user_signed_in?
      @lesson = Lesson.new(params[:lesson])
      respond_to do |format|
        if @lesson.save
          format.html { redirect_to lessons_path(@lesson), notice: 'Le cour a bien été créé' }
          format.json { render json: @lesson, status: :created, location: @lesson }
        else
          format.html { render action: "new" }
          format.json { render json: @lesson.errors, status: :unprocessable_entity }
        end
      end
    else
      access_denied
    end
  end
  
  def update
    if school_user_signed_in?
      respond_to do |format|
        if @lesson.update_attributes(params[:lesson])
          format.html { redirect_to @lesson, notice: 'Le cour a bien été mise à jour.' }
          format.json { head :ok }
        else
          format.html do
            render action: "edit"
          end
          format.json { render json: @lesson.errors, status: :unprocessable_entity }
        end
      end
    else
      access_denied
    end
  end

  
  def destroy
    if school_user_signed_in?
      @lesson.destroy
      respond_to do |format|
        format.html { redirect_to lessons_url, alert: 'le cour a bien été supprimé' }
        format.json { head :ok }
      end
    else
      access_denied
    end
  end
  
  private
  
  def find_lesson
    @lesson = Lesson.find(params[:id])
  end
  
  def find_all_sujects_klasses_and_teachers
    @subjects = Subject.all
    @teachers = Teacher.all
    @classes = Klass.all
  end
end
