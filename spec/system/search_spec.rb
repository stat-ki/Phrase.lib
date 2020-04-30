require "rails_helper"

RSpec.describe "search", type: :system do
  describe "search test" do
    context "search user" do
      before do
        @user = create(:user)
        visit shares_path
      end

      it "can search user name" do
        select "ユーザー名", from: "search_model"
        fill_in "search_word", with: @user.name
        click_button "検索する"
        expect(page).to have_link("#{@user.name}")
      end
      it "displays introduction when no user matched" do
        select "ユーザー名", from: "search_model"
        fill_in "search_word", with: "Unmatched"
        click_button "検索する"
        expect(page).to have_content("検索結果がありません")
      end
    end
    context "search post" do
      before do
        @user = create(:user)
        @post = create(:post, user_id: @user.id)
        visit shares_path
      end

      it "can search post phrase" do
        select "フレーズ", from: "search_model"
        fill_in "search_word", with: @post.phrase
        click_button "検索する"
        expect(page).to have_link("#{@post.phrase}")
      end
      it "displays introduction when no post matched" do
        select "フレーズ", from: "search_model"
        fill_in "search_word", with: "Unmatched"
        click_button "検索する"
        expect(page).to have_content("検索結果がありません")
      end
    end
  end
end