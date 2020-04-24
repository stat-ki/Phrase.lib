require "rails_helper"

RSpec.describe "Contact model", type: :model do
  describe "validates test" do
    before do
      @contact = build(:contact)
    end

    context "email column" do
      it "is empty" do
        @contact.email = nil
        expect(@contact.valid?).to eq false;
      end
    end
    context "message column" do
      it "is empty" do
        @contact.message = nil
        expect(@contact.valid?).to eq false;
      end
    end
  end
end