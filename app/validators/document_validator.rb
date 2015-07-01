class DocumentValidator < ActiveModel::Validator

  def validate(record)
    validate_foo(record)
    validate_bar(record)
  end

  private

  def validate_foo(record)
    if record.body['foo'].blank?
      record.errors['foo'] << 'is required'
    else
      record.errors['foo'] << 'must be at least 5 characters long' if record.body['foo'].size < 5
    end
  end

  def validate_bar(record)
    if record.body['bar'].blank?
      record.errors['bar'] << 'is required'
    else
      record.errors['bar'] << 'cannot contain numbers' if record.body['bar'] =~ /\d/
    end
  end

end
