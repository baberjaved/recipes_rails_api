json.converter do
  json.unit_from @converter&.dig(:unit_from)
  json.unit_to @converter&.dig(:unit_to)
  json.old_amount @converter&.dig(:old_amount)
  json.new_amount @converter&.dig(:new_amount)
end
