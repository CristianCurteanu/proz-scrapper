# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

module Proz
  class Parser
    extend ModelAttribute

    attribute :source
    attribute :first_name
    attribute :last_name
    attribute :country
    attribute :native_language
    attribute :target_language

    def initialize(url)
      self.source = url
      @document = Nokogiri::HTML open(url)
    end

    def extract
      attributes.except(:source).each_key do |attribute|
        write_attribute(attribute, send(attribute))
      end
      self
    end

    private

    def full_name
      @full_name ||= @document.css('td[valign="top"] strong').text
    end

    def first_name
      @first_name ||= full_name.split(' ').first
    end

    def last_name
      @last_name ||= unless full_name.split(' ').last.eql? first_name
                       full_name.split(' ').last
                     end
    end

    def native_language
      @native_language ||= @document.css('tr > td > div.pd_bot').text.split.last[0..-2]
    rescue NoMethodError
      nil
    end

    def target_language
      @target_language ||= @document.css('#lang_full > .mouseoverText').
                           each_with_object([]) { |v, a| a << v.text.split(' to ') }.
                           flatten.uniq - [native_language]
    end

    def country
      @country ||= if @document.css('td[valign="top"] > div').length.eql?(17)
                     @document.css('td[valign="top"] > div')[5].children.first.text.split.last
                   end
    end
  end
end
