require "rails_helper"

RSpec.describe "Favorite model", type: :model do
  describe "validates test" do
    before do
      @user = build(:user)
      @post = build(:post)
      @post.user_id = @user.id
      @favorite = Favorite.new(user_id: @user.id, post_id: @post.id)
    end

    context "user_id column" do
      it "is empty" do
        @favorite.user_id = nil
        expect(@favorite.valid?).to eq false;
      end
    end
    context "post_id column" do
      it "is empty" do
        @favorite.post_id = nil
        expect(@favorite.valid?).to eq false;
      end
    end
  end

  describe "association test" do
    context "association with User" do
      it "is N:1" do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "association with Post" do
      it "is 1:N" do
        expect(Favorite.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end