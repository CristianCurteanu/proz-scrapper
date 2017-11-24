# frozen_string_literal: true

module ExtractionsHelper
  def input_options(name, label)
    if @errors
      {
        placeholder: [name, @errors[label.to_s]].join(' '),
        class:       ('invalid' if @errors[label.to_s].present?).to_s
      }
    else
      {}
    end
  end
end
