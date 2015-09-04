require_relative '../helper/spec_helper'

describe 'google page' do
  it 'successfully loads google.com once', sauce: sauce? do
    selenium.get 'http://www.google.com'
    actual = Selenium::WebDriver::Wait.new(:timeout => 10).until { selenium.find_element(:name, 'btnK').displayed? }
    expect(actual).to eq true
  end

  it 'successfully loads google.com twice', sauce: sauce? do
    selenium.get 'http://www.google.com'
    actual = Selenium::WebDriver::Wait.new(:timeout => 10).until { selenium.find_element(:id, 'hplogo').displayed? }
    expect(actual).to eq true
  end

  it 'finds by regular locator', sauce: sauce? do
    selenium.get 'http://www.google.com'
    actual = Selenium::WebDriver::Wait.new(:timeout => 10).until { selenium.find_element(:id, 'lst-ib').displayed? }
    expect(actual).to eq true
  end
end
