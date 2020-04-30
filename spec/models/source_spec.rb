require "rails_helper"

RSpec.describe "Source model", type: :model do
  describe "validates test" do
    before do
      @user = build(:user)
      @source = build(:source)
      @source.user_id = @user.id
    end

    context "user_id" do
      it "is empty" do
        @source.user_id = nil
        expect(@source.valid?).to eq false;
      end
    end
    context "category column" do
      it "is empty" do
        @source.category = nil
        expect(@source.valid?).to eq false;
      end
    end
    context "author column" do
      it "is empty" do
        @source.author = nil
        expect(@source.valid?).to eq false;
      end
    end
    context "title column" do
      it "is empty" do
        @source.title = nil
        expect(@source.valid?).to eq false;
      end
    end
  end

  describe "association test" do
    context "association with User" do
      it "is N:1" do
        expect(Source.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end