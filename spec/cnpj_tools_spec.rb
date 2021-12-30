# frozen_string_literal: true

RSpec.describe CnpjTools do
  let (:valid_cnpj)   { '16533758000125' }
  let (:invalid_cnpj) { '12333758000125' }
  let (:masked_cnpj)  { '16.533.758/0001-25' }
  let (:integer_cnpj) { 16533758000125 }

  it 'has a version number' do
    expect(CnpjTools::VERSION).not_to be nil
  end

  it 'cnpj is valid' do
    cnpj = CnpjTools.valid?(valid_cnpj)
    expect(cnpj).to eq(true)
  end

  it 'cnpj is invalid' do
    cnpj = CnpjTools.valid?(invalid_cnpj)
    expect(cnpj).to eq(false)
  end

  it 'formated with mask' do
    cnpj = CnpjTools.format(valid_cnpj)
    expect(cnpj).to eq(masked_cnpj)
  end

  it 'formated digits_only' do
    cnpj = CnpjTools.format(masked_cnpj, format: :digits_only)
    expect(cnpj).to eq(valid_cnpj)
  end

  it 'format an integer' do
    cnpj = CnpjTools.format(integer_cnpj)
    expect(cnpj).to eq(masked_cnpj)
  end

  it 'format only with 14 digits' do
    cnpj = CnpjTools.format('16.533.758/0001', format: :digits_only)
    expect(cnpj).to be_empty
  end

  it 'return a masked cnpj when valid' do
    cnpj = CnpjTools.return_valid(valid_cnpj)
    expect(cnpj).to eq(masked_cnpj)
  end

  it 'return an empty string when cnpj is invalid' do
    cnpj = CnpjTools.return_valid(invalid_cnpj)
    expect(cnpj).to be_empty
  end
end
