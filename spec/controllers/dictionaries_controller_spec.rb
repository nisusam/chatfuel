require 'rails_helper'

RSpec.describe DictionariesController, type: :controller do

  describe 'routes' do
    it { should route(:get, '/dictionaries').to(action: :index) }
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
