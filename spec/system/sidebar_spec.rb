require "rails_helper"

RSpec.describe "sidebar", type: :system do
  describe "displayed contents test" do
    context "when user is not signed in" do
      before do
        visit shares_path
      end

      it "displays name" do
        expect(page).to have_content "Guest"
      end
      it "includes search form" do
        expect(page).to have_field "search_model"
      end
    end
    context "share mode" do
      before do
        @user = create(:user)
        login(@user)
        visit shares_path
      end

      it "displays name" do
        expect(page).to have_link "#{@user.name}"
      end
      it "includes button to notes" do
        expect(page).to have_link "notes モードに切り替える"
      end
      it "includes link to mypage" do
        expect(page).to have_link "マイページ"
      end
      it "includes link to post page" do
        expect(page).to have_link "投稿する"
      end
      it "includes link to favorite page" do
        expect(page).to have_link "いいね！を見る"
      end
      it "includes link to registration edit page" do
        expect(page).to have_link "ユーザー情報を編集する"
      end
      it "includes search form" do
        expect(page).to have_field "search_model"
      end
    end
    context "share mode" do
      before do
        @user = create(:user)
        login(@user)
        visit notes_path
      end

      it "displays name" do
        expect(page).to have_link "#{@user.name}"
      end
      it "includes button to shares" do
        expect(page).to have_link "share モードに切り替える"
      end
      it "includes link to mypage" do
        expect(page).to have_link "マイページ"
      end
      it "includes link to post page" do
        expect(page).to have_link "投稿する"
      end
      it "includes link to favorite page" do
        expect(page).to have_link "いいね！を見る"
      end
      it "includes link to registration edit page" do
        expect(page).to have_link "ユーザー情報を編集する"
      end
      it "includes search form" do
        expect(page).to have_field "search_model"
      end
    end
  end
end