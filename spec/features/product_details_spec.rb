require 'rails_helper'

RSpec.feature "Clicking on product details button", type: :feature, js:true do

  before :each do
    @category = Category.create! name: 'Apparel'

    @product = Product.create!(
    name:  Faker::Hipster.sentence(3),
    description: Faker::Hipster.paragraph(4),
    image: open_asset('apparel1.jpg'),
    quantity: 1,
    price: 64.99,
    category_id: @category.id
    )
  end

  scenario "they see product details" do
    # ACT
    visit root_path
      click_link('Details', match: :first)
      expect(page).to have_css 'article.product-detail', count: 1
      save_screenshot

    # DEBUG / VERIFY

    # expect(page).to have_css 'article.product', count: 10
  end

end
