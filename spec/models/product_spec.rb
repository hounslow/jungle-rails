require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    it 'should validate all' do
      @category = Category.new(name: "Category")
      @product = Product.new(
      name: 'name',
      description: 'description',
      price_cents: 120,
      quantity: 2,
      category_id: 1
      )
      @product.valid?
      expect(@product.errors).not_to include('can\'t be blank')
    end

    it 'should validate name presence' do
      @category = Category.new(name: "Category")
      @product = Product.new(
      name: '',
      description: 'description',
      price_cents: 120,
      quantity: 2,
      category_id: 1
      )
      @product.valid?
      expect(@product.errors[:name]).to include('can\'t be blank')

      @product.name = 'Product Name'
      @product.save
      @product.valid?
      expect(@product.errors[:name]).not_to include('can\'t be blank')
    end

    it 'should validate price presence' do
      @category = Category.new(name: "Category")
      @product = Product.new(
      name: 'name',
      description: 'description',
      quantity: 2,
      category_id: @category.id
      )
      @product.valid?
      expect(@product.errors.full_messages).to include('Price can\'t be blank')

      @product.price = 12
      @product.save
      @product.valid?
      expect(@product.errors.full_messages).not_to include('Price cant\' be blank')
    end

    it 'should validate quantity presence' do
      @category = Category.new(name: "Category")
      @product = Product.new(
      name: 'name',
      description: 'description',
      price_cents: 120,
      category_id: @category.id
      )
      @product.valid?
      expect(@product.errors[:quantity]).to include('can\'t be blank')

      @product.quantity = 12
      @product.save
      @product.valid?
      expect(@product.errors[:quantity]).not_to include('cant\' be blank')
    end

    it 'should validate category presence' do
      @product = Product.new(
      name: 'name',
      description: 'description',
      price_cents: 120,
      quantity: 2,
      )
      @product.valid?
      expect(@product.errors.full_messages).to include('Category can\'t be blank')

      @category = Category.new(name: "Category")
      @product.category_id = @category.id
      @product.save
      @product.valid?
      expect(@product.errors.full_messages).not_to include('cant\' be blank')
    end
  end
end
