# encoding: utf-8

require_relative '../spec_helper'

describe 'Pos Application', :type => :feature do

  before :each do
    Product.create(name: "Apple", price: 2.5, unit: "斤", quantity: 2, description:"红富士")
  end

  describe "Index page" do
    it "should display correct content" do
      visit '/'
      expect(page).to have_content("Welcome to Let's Go")
    end
  end

  describe "Add items page", :js => true do
    it "should get new item in DB when add item in '/admin'" do
      page.set_rack_session username: "admin"
      visit '/admin'

      fill_in 'item-name', :with => 'peach'
      fill_in 'item-price', :with => 3
      fill_in 'item-unit', :with => '斤'
      fill_in 'item-description', :with => '水蜜桃'
      accept_alert do
        click_button 'submit'
      end

      added_item = Product.last
      expect(added_item.name).to eq 'peach'
      expect(added_item.price).to eq 3 
      expect(added_item.unit).to eq '斤'
      expect(added_item.description).to eq '水蜜桃'
    end
  end

  describe "Item list page", :js => true do
    it "should show item list when enter items.html" do
      visit '/views/items.html'

      expect(page).to have_content("名称")
      expect(page).to have_content("Apple")
      expect(page).to have_content("2.5")
      expect(page).to have_content("斤")
      expect(page).to have_content("红富士")
    end
  end

end