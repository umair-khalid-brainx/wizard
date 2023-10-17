class ProfilesController < ApplicationController
  include Wicked::Wizard

  before_action :set_progress

  steps :general, :social, :educational, :professional

  def show
    @user = current_user
    @profile = @user.profile || @user.build_profile
    render_wizard
  end

  def create
    @user = current_user
    @profile = @user.profile || @user.build_profile
    redirect_to wizard_path(steps.first, profile_id: @profile.id)
  end

  def update
    @user = current_user
    @profile = @user.profile || @user.build_profile
    @profile.status = step.to_s
    @profile.status = 'active' if step == steps.last
    current_step_index = steps.index(step)
    next_step = steps[current_step_index + 1]
    @profile.next_step = next_step.present? ? next_step.to_s : steps.first.to_s
    @profile.update(profile_params)
    render_wizard @profile
  end

  def upload_file
    @user = current_user
    @profile = @user.profile || @user.build_profile
    file_type = params[:file_type]
    case file_type
      when "cv"
        @profile.cv.attach(params[:file]) # Assuming your file input has name="file"
      when "transcript"
        @profile.transcript.attach(params[:file])
      when "resume"
        @profile.resume.attach(params[:file])
    else
      puts "Error"
    end
    head :ok
  end

  private

  def set_progress
    if steps.any? && steps.index(step).present?
      @progress = ((steps.index(step) + 1).to_f / steps.count.to_f) * 100
    else
      @progress = 0
    end
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :age, :date_of_birth, :phone_number, :email, :postal_code, :city, :country, :facebook_profile, :twitter_profile, :linkedin_profile, :university, :level_of_education, :cgpa, :transcript, :job_title, :company, :location, :start_date, :end_date, :cv, :resume, :file_type)
  end
end
