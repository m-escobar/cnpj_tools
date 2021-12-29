# frozen_string_literal: true
require_relative "cnpj_tools/version"

module CnpjTools
  class Error < StandardError; end

  class << self
    def valid?(cnpj)
      tax_id = cnpj_to_s(cnpj)

      if invalid_repetition?(tax_id)
        false
      elsif tax_id.length == 11
        id_array = tax_id.split('').map(&:to_i)

        first_digit  = id_multiplier(id_array[0..8])
        second_digit = id_multiplier(id_array[0..9])

        first_digit == id_array[9] && second_digit == id_array[10]
      else
        false
      end
    end

    def format(cnpj, format: :masked)
      tax_id = cnpj_to_s(cnpj)
      return '' unless tax_id.length == 11

      if format == :digits_only
        tax_id
      else
        "#{tax_id[0..2]}.#{tax_id[3..5]}.#{tax_id[6..8]}-#{tax_id[9..10]}"
      end
    end

    def return_valid(cnpj, format: :masked)
      valid?(cnpj) ? format(cnpj, format: format) : ''
    end

    private
    def cnpj_to_s(cnpj)
      cnpj = cnpj.to_s if cnpj.is_a? Integer
      cnpj.scan(/\d*/m).join
    end

    def invalid_repetition?(tax_id)
      tax_id.count('0') == 11 || tax_id.count('9') == 11
    end

    def id_multiplier(id)
      multiplier = id.length + 1
      tax_id_base = id.enum_for(:each_with_index).map { |x, idx| x * (multiplier - idx) }.inject(:+)
      result = (tax_id_base * 10) % 11
      result == 10 ? 0 : result
    end
  end
end
