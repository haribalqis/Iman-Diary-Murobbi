require "time_difference"

# A player record from the database
class Player < Sequel::Model
  include Validation
  extend Validation

  def name
    "#{first_name} #{surname}"
  end

  def age(at_date = Date.today)
    dob = Date.strptime(date_of_birth, "%Y-%m-%d")
    TimeDifference.between(dob, at_date).in_years.floor
  end

  # "self.method" is how we define a class-level method in Ruby (in the same way
  # we'd use "static" in Java, e.g., public static void classMethod(...))
  def self.id_exists?(id)
    return false if id.nil? # check the id is not nil
    return false unless str_digits?(id) # check the id is an integer
    return false if Player[id].nil? # check the database has a record with this id

    true # all checks are ok - the id exists
  end

  def load(params)
    self.first_name = params.fetch("first_name", "").strip
    self.surname = params.fetch("surname", "").strip
    self.gender = params.fetch("gender", "").strip
    self.country = params.fetch("country", "").strip
    self.date_of_birth = params.fetch("date_of_birth", "").strip
  end

  def validate #method of validation
    super #parent classMethod
    errors.add("first_name", "cannot be empty") if !first_name || first_name.empty?
    errors.add("surname", "cannot be empty") if !surname || surname.empty?
    errors.add("gender", "cannot be empty") if !gender || gender.empty?
    errors.add("country", "cannot be empty") if !country || country.empty?
    errors.add("date_of_birth", "cannot be empty") if !date_of_birth || date_of_birth.empty?
    return unless date_of_birth && !str_yyyy_mm_dd_date?(date_of_birth)

    errors.add("date_of_birth", "is invalid")
  end
end
