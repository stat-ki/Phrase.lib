require "rails_helper"

RSpec.describe "post", type: :system do
  describe "access rights test" do
    context "when user is signed in" do
      before do
        @user = create(:user)
        @user_2 = create(:user, name: "foreinger", email: "test_2@phraselib.work")
        @post = create(:post, user_id: @user.id)
        login(@user)
      end

      it "can access shares page" do
        visit shares_path
        expect(current_path).to eq(shares_path)
      end
      it "can access share_show page" do
        visit post_path(@post.id)
        expect(current_path).to eq(post_path(@post.id))
      end
      it "can access notes page" do
        visit notes_path
        expect(current_path).to eq(notes_path)
      end
      it "can access note_show page" do
        @post.is_sharing = false
        visit post_path(@post.id)
        expect(current_path).to eq(post_path(@post.id))
      end
      it "can't access note_show page if posted user is different" do
        @post.is_sharing = false
        @post.user_id = @user_2.id
        visit post_path(@post.id)
        expect(current_path).to_not eq(post_path(@post.id))
      end
    end
    context "when user is not signed in" do
      before do
        @user = create(:user)
        @post = create(:post, user_id: @user.id)
      end

      it "can access shares page" do
        visit shares_path
        expect(current_path).to eq(shares_path)
      end
      it "can access share_show page" do
        visit post_path(@post.id)
        expect(current_path).to eq(post_path(@post.id))
      end
      it "can't access notes page" do
        visit notes_path
        expect(current_path).to_not eq(notes_path)
      end
      it "can't access note_show page" do
        @post.is_sharing = false
        visit post_path(@post.id)
        expect(current_path).to_not eq(post_path(@post.id))
      end
    end
  end
  describe "CRUD functions test" do
    context "when user is not signed in" do
      before do
        @user = create(:user)
        @post = create(:post, user_id: @user.id)
      end

      it "can't access page for Create" do
        visit new_post_path
        expect(current_path).to_not eq(new_post_path)
      end
      it "can't access page for Update" do
        visit edit_post_path(@post.id)
        expect(current_path).to_not eq(edit_post_path(@post.id))
      end
      it "can't Update post" do
        post post_path(@post.id), params: { session_form: { phrase: "Edited phrase." } }
        expect(response).to_not have_http_status "200"
      end
      it "can't Delete post" do
        delete post_path(@post.id)
        expect(response).to_not have_http_status "200"
      end
    end
    context "when user is signed in" do
      before do
        @user = create(:user)
        @user_2 = create(:user, name: "test_user2", email: "test_2@phraselib.work")
        @post = create(:post, user_id: @user.id)
        @post_2 = create(:post, user_id: @user_2.id)
        login(@user)
      end

      it "can access page for Create" do
        visit new_post_path
        expect(current_path).to eq(new_post_path)
      end
      it "can Create post" do
        visit new_post_path
        fill_in "post_phrase", with: @post.phrase
        select "英語", from: "post_language"
        choose "post_is_sharing_true"
        choose "post_is_original_true"
        click_button "投稿する"
        expect(page).to have_content("投稿しました")
        expect(page).to have_content("#{@post.phrase}")
      end
      it "fails to Create invalid post" do
        visit new_post_path
        fill_in "post_phrase", with: ""
        select "英語", from: "post_language"
        choose "post_is_sharing_true"
        choose "post_is_original_true"
        click_button "投稿する"
        expect(page).to have_content("不備があります")
      end
      it "can access page for Update" do
        visit edit_post_path(@post.id)
        expect(current_path).to eq(edit_post_path(@post.id))
      end
      it "can Update post" do
        post post_path(@post.id), params: { session_form: { phrase: "Edited phrase." } }
        expect(response).to have_http_status "200"
      end
      it "can Delete post" do
        delete post_path(@post.id)
        expect(response).to have_http_status "200"
      end
      it "can't access other user's post page for Update" do
        visit edit_post_path(@post_2.id)
        expect(page).to have_content("権限がありません")
        expect(current_path).to_not eq(edit_post_path(@post_2.id))
      end
      it "can't Update other user's post" do
        post post_path(@post_2.id), params: { session_form: { phrase: "Edited phrase." } }
        expect(response).to have_http_status "302"
      end
      it "can't Delete other user's post" do
        delete post_path(@post_2.id)
        expect(response).to have_http_status "302"
      end
    end
  end
  describe "API test" do
    before do
      @user = create(:user)
      @source = create(:source, user_id: @user.id)
      @post = create(:post, user_id: @user.id, source_id: @source.id, is_original: false)
      visit post_path(@post.id)
    end

    context "translate API" do
      it "can translate" do
        get "/posts/#{@post.id}/translate", xhr: true
        sleep 2
        expect(page).to have_content("これはテストです")
      end
      it "can search items" do
        get "/posts/#{@post.id}/search_items", xhr: true
        sleep 2
        expect(page).to have_content("商品名")
      end
    end
  end
end