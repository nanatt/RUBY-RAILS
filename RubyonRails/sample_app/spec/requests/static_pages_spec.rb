require 'spec_helper'
require 'capybara'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit home_path }

    it { should have_content('Sample App') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end

describe "User pages" do
  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user)}

    it { should have_content(user.name)}
    it { should have_title(user.name)}
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up')}
    it { should have_title(full_title('Sign uo'))}
  end
end

describe "profile page" do
  #Replace with code to make a user variable
  before { visit user_path(user) }

  it { should have_content(user.name)}
  it { should have_title(user.name)}
end

=begin
require 'rails_helper'

RSpec.describe "StaticPages", :type => :request do
  describe "GET /static_pages" do
    it "works! (now write some real specs)" do
      get static_pages_index_path
      expect(response).to have_http_status(200)
    end
  end
end
=end