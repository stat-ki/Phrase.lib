require "rails_helper"

RSpec.describe "user", type: :system do
  describe "registration test" do
    context "sign up" do
      before do
        @user = build(:user)
        visit new_user_registration_path
      end

      it "can register user" do
        fill_in "user_email", with: @user.email, match: :first
        fill_in "user_name", with: @user.name, match: :first
        fill_in "user_password", with: @user.password, match: :first
        fill_in "user_password_confirmation", with: @user.password, match: :first
        click_button "新規登録"
        expect(page).to have_content("ご登録ありがとうございます！")
      end
      it "can't register user if infomation is invalid" do
        fill_in "user_email", with: "", match: :first
        fill_in "user_name", with: @user.name, match: :first
        fill_in "user_password", with: @user.password, match: :first
        fill_in "user_password_confirmation", with: @user.password, match: :first
        click_button "新規登録"
        expect(page).to have_content("Eメールを入力してください")
      end
    end
    context "edit registration" do
      before do
        @user = create(:user)
        @user_2 = create(:user, name: "test_user2", email: "test_2@phraselib.work")
        login(@user)
      end

      it "can access page" do
        visit edit_user_registration_path(@user.id)
        expect(page).to have_content("ユーザー情報編集")
      end
      it "can update registration" do
        post user_registration_path(@user.id), params: { session_form: { name: "edited" } }
        expect(response).to have_http_status "200"
      end
      it "can't access other user's page" do
        visit edit_user_registration_path(@user_2.id)
        expect(current_path).to_not eq(edit_user_registration_path(@user_2.id))
      end
      it "can't update other user's registration" do
        post user_registration_path(@user_2.id), params: { session_form: { name: "edited" } }
        expect(response).to have_http_status "302"
      end
    end
  end
  describe "session test" do
    context "sign in" do
      before do
        @user = create(:user)
      end

      it "can sign in" do
        visit root_path
        fill_in "user_email", with: @user.email
        fill_in "user_password", with: @user.password
        click_button "ログイン"
        expect(page).to have_content("ログインしました")
      end
      it "can't sign in if registration info is unmatched" do
        visit root_path
        fill_in "user_email", with: @user.email
        fill_in "user_password", with: "wrongpassword"
        click_button "ログイン"
        expect(current_path).to eq(new_user_session_path)
      end
    end
    context "sign out" do
      before do
        @user = create(:user)
        login(@user)
      end

      it "can sign out" do
        visit root_path
        click_link "ログアウト"
        expect(page).to have_content("ログアウトしました")
      end
    end
  end
end