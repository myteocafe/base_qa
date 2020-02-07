RSpec::Matchers.define :have_the_same_items_as do |expected|
  match do |actual|
    (actual - expected).empty? and (expected - actual).empty?
  end

  failure_message_for_should do |actual|
    "\nActual - Expected:\n#{actual - expected}\n\nExpected - Actual:\n#{expected - actual}"
  end
end

RSpec::Matchers.define :have_the_same_order do |expected|
  match do |actual|
    (actual - expected).empty? and (expected - actual).empty?
  end

  failure_message_for_should do |actual|
    "\nActual - Expected:\n#{actual - expected}\n\nExpected - Actual:\n#{expected - actual}"
  end
end