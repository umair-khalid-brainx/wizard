class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.datetime :date_of_birth
      t.string :phone_number
      t.string :email
      t.integer :postal_code
      t.string :city
      t.string :country
      t.string :facebook_profile
      t.string :twitter_profile
      t.string :linkedin_profile
      t.string :university
      t.string :level_of_education
      t.float :cgpa
      t.string :job_title
      t.string :company
      t.string :location
      t.datetime :start_date
      t.datetime :end_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
