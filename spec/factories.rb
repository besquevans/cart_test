FactoryBot.define do
  factory :product do
    name { "product_1" }
    value { 10 }
    after(:create) do |product|
      product.stock ||= create(:stock, product: product)
    end
  end

  factory :stock do
    amount { 10 }
  end
end
