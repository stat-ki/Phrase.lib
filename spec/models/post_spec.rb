require "rails_helper"

RSpec.describe "Post model", type: :model do
  describe "validates test" do
    before do
      @user = create(:user)
      @post = build(:post)
      @post.user_id = @user.id
    end

    context "user_id column" do
      it "is empty" do
        @post.user_id = nil
        expect(@post.valid?).to eq false;
      end
    end
    context "source_id column" do
      it "is empty when is_original: false" do
        @post.is_original = false
        expect(@post.valid?).to eq false;
      end
      it "is empty when is_original: true" do
        expect(@post.valid?).to eq true;
      end
    end
    context "phrase column" do
      it "is empty" do
        @post.phrase = ""
        expect(@post.valid?).to eq false;
      end
      it "is over 50 characters" do
        @post.phrase = "test"*50
        expect(@post.valid?).to eq false;
      end
    end
    context "language column" do
      it "is empty" do
        @post.language = nil
        expect(@post.valid?).to eq false;
      end
    end
    context "is_original column" do
      it "is empty" do
        @post.is_original = nil
        expect(@post.valid?).to eq false;
      end
    end
    context "is_sharing column" do
      it "is empty" do
        @post.is_sharing = nil
        expect(@post.valid?).to eq false;
      end
    end
  end

  describe "association test" do
    context "association with User" do
      it "is N:1" do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "association with Favorite" do
      it "is 1:N" do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
  end
end