require 'rails_helper'

RSpec.describe "ServicePayments", :type => :request do
  describe "GET /service_payments" do
    it "works! (now write some real specs)" do
      get service_payments_path
      expect(response).to have_http_status(200)
    end
  end
end
