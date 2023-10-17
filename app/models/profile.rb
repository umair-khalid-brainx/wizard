class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :transcript
  has_one_attached :cv
  has_one_attached :resume

  with_options if: :active_or_general? do |profile|
    profile.validates :first_name, :last_name, :age, :date_of_birth, :phone_number, :email, :postal_code, :city, :country, presence: true
    profile.validates :phone_number, :email, uniqueness: true
    profile.validates :age, :phone_number, :postal_code, numericality: true
    profile.validates :first_name, :last_name, :city, :country, format: { with: /[a-zA-Z]/ }
    profile.validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    profile.validates :phone_number, length: { is: 11 }
  end

  with_options if: :active_or_social? do |profile|
    profile.validates :facebook_profile, format: { with: /\Ahttps:\/\/www\.facebook\.com\// }
    profile.validates :twitter_profile, format: { with: /\Ahttps:\/\/twitter\.com\// }
    profile.validates :linkedin_profile, format: { with: /\Ahttps:\/\/www\.linkedin\.com\/in\// }
  end

  with_options if: :active_or_educational? do |profile|
    profile.validates :university, :level_of_education, :transcript, presence: true
    profile.validates :university, :level_of_education, format: {with: /[a-zA-Z]/}
    profile.validates :cgpa, allow_blank: true, numericality: { only_float: true, allow_blank: true }
    profile.validate :validate_transcript
  end

  with_options if: :active_or_professional? do |profile|
    profile.validates :job_title, :company, :location, :start_date, :end_date, :cv, presence: true
    profile.validates :job_title, :company, :location, format: { with: /[a-zA-Z]/ }
    profile.validate :end_date_is_after_start_date
    profile.validate :validate_cv_and_resume
  end

  def active?
    status == 'active'
  end

  def active_or_general?
    status&.include?('general') || active?
  end

  def active_or_social?
    status&.include?('social') || active?
  end

  def active_or_educational?
    status&.include?('educational') || active?
  end

  def active_or_professional?
    status&.include?('professional') || active?
  end

  private

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?
    if end_date < start_date
      errors.add(:end_date, "cannot be before the start date")
    end
  end

  def validate_transcript
    if transcript.attached? && !transcript.content_type.in?(%w(application/pdf))
      errors.add(:transcript, 'must be a PDF')
      transcript.purge
    end
  end

  def validate_cv_and_resume
    if cv.attached? && !cv.content_type.in?(%w(application/pdf))
      errors.add(:cv, 'must be a PDF')
      cv.purge
    end

    if resume.attached? && !resume.content_type.in?(%w(application/pdf))
      errors.add(:resume, 'must be a PDF')
      resume.purge
    end
  end
end
