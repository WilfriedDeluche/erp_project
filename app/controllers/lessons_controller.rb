# encoding: utf-8
class LessonsController < ApplicationController
  before_filter :school_users_only
  before_filter :find_lesson, :only => [:show, :edit, :update, :destroy]
  before_filter :find_all_sujects_klasses_and_teachers, :only => [:new, :edit]
  
  def index
    @lessons = Lesson.order("start_date ASC").all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end
  
  def show
  end
  
  def new
    @lesson = Lesson.new
  end

  def edit
  end
  
  def create
     @lesson = Lesson.new(params[:lesson])
      respond_to do |format|
        if @lesson.save
          format.html { redirect_to lessons_path(@lesson), notice: 'Le cour a bien été créé' }
          format.json { render json: @lesson, status: :created, location: @lesson }
        else
          format.html do
            render action: "new"
          end
          format.json { render json: @lesson.errors, status: :unprocessable_entity }
        end
      end
  end
  
  def update
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
  end

  
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url }
      format.json { head :ok }
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
