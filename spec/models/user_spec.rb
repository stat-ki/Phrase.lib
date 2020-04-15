require "rails_helper"

RSpec.describe "User model", type: :model do
  describe "validates test" do
    before do
      @user = build(:user)
    end

    context "name column" do
      it "is empty" do
        @user.name = ""
        expect(@user.valid?).to eq false;
      end
      it "is over 10 characters" do
        @user.name = "test"*10
        expect(@user.valid?).to eq false;
      end
    end
    context "email column" do
      it "is empty" do
        @user.email = ""
        expect(@user.valid?).to eq false;
      end
      it "doesn't include @" do
        @user.email = "testpharselib.work"
        expect(@user.valid?).to eq false;
      end
    end
  end

  describe "association test" do
    context "association with Post" do
      it "is 1:N" do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
    context "association with Favorite" do
      it "is 1:N" do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context "association with Source" do
      it "is 1:N" do
        expect(User.reflect_on_association(:sources).macro).to eq :has_many
      end
    end
  end
end