require 'spec_helper'

describe "DocumentLines" do
  describe "GET /document_lines" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get document_lines_path
      response.status.should be(200)
    end
  end
end
