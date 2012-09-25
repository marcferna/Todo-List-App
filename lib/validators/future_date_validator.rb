class FutureDateValidator < ActiveModel::EachValidator
  # Method that validates if the due_date is in the past
  # Allows blank
  def validate_each(record, attribute, value)
    if !value.nil? && value < Date.today
      record.errors.add(:due_date, "can't be in the past")
    end
  end
end