class LoremIpsumDocumentValidator < ActiveModel::Validator

  def validate(record)
    if record.body['lorem'].blank?
      record.errors['lorem'] << 'is required'
    else
      record.errors['lorem'] << 'must start with "Lorem Ipsum"' unless record.body['lorem'] =~ /^Lorem Ipsum/
    end
  end

end
