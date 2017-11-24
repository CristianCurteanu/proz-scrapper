# frozen_string_literal: true

module ExtractionsHelper
  def input_options(name, label)
    {
      placeholder: [name, @errors[label.to_s]].join(' '),
      class:       ('invalid' if @errors[label.to_s].present?).to_s
    }
  rescue NoMethodError
    {}
  end
end
