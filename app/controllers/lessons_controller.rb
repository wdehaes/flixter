class LessonsController < ApplicationController
  before_action :authenticate_user!
  def show
    require_authorized_for_current_lesson
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_authorized_for_current_lesson
    if not current_user.enrolled_in?(current_lesson.section.course.user)
      redirect_to course_path(current_lesson.section.course), alert: 'You have to be enrolled in a course to see lesson details'
    end  
  end

end
