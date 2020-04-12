require "rails_helper"

RSpec.describe "header", type: :system do
  describe "displayed contents test" do
    context "when user is not signed in" do
      before do
        visit root_path
      end

      it "includes link to about" do
        expect(page).to have_link "Phrase.libについて"
      end
      it "includes link to signed in" do
        expect(page).to have_link "ログイン"
      end
      it "includes link to signed up" do
        expect(page).to have_link "会員登録はこちら"
      end
    end
    context "when user is singed in" do
      before do
        @user = create(:user)
        visit root_path
        fill_in "user_email", with: @user.email
        fill_in "user_password", with: @user.password
        click_button "ログイン"
      end

      it "includes link to sign out" do
        expect(page).to have_link "ログアウト"
      end
    end
  end
end