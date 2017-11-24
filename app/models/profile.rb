# frozen_string_literal: true

class Profile < ApplicationRecord
  attr_accessor :target_languages

  validates :first_name,
            :last_name,
            :source,
            :country,
            :native_language,
            presence: true

  before_save do
    self.target_language = target_languages.join(', ')
  end
end
