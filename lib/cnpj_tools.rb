# frozen_string_literal: true
require_relative 'cnpj_tools/version'

module CnpjTools
  class Error < StandardError; end

  class << self
    def valid?(cnpj)
      tax_id = cnpj_to_s(cnpj)

      if tax_id.length == 14
        return false if invalid_repetition?(tax_id)

        id_array = tax_id.split('').map(&:to_i)

        first_digit  = id_multiplier(id_array[0..11])
        second_digit = id_multiplier(id_array[0..12])

        first_digit == id_array[12] && second_digit == id_array[13]
      else
        return false
      end
    end

    def format(cnpj, format: :masked)
      tax_id = cnpj_to_s(cnpj)
      return '' unless valid?(tax_id)

      if format == :digits_only
        tax_id
      else
        "#{tax_id[0..1]}.#{tax_id[2..4]}.#{tax_id[5..7]}/#{tax_id[8..11]}-#{tax_id[12..13]}"
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
      return true if tax_id[0..7].split('').uniq.count == 1
    end

    def id_multiplier(id)
      multiplier = id.length == 12 ? [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3 ,2] : [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]

      tax_id_base = id.enum_for(:each_with_index).map { |x, idx| x * multiplier[idx] }.inject(:+)

      (tax_id_base * 10) % 11
    end
  end
end
