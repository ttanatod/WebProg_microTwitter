require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
    
  setup do
    @user = users(:one)
  end

  test "like post" do
    u = users(:two)

    visit main_path

    fill_in "Email", with: @user.email
    fill_in "Password", with: "MyString"

    click_on "Log in"
    # puts "----#{u.posts.first.likes.count}------"

    assert_no_text "Like by 1 user"
    assert_difference('u.posts.first.likes.count') do
      click_on "Like"
      visit profile_path(u.name)
    end
    # puts "----#{u.posts.first.likes.count}------"
    assert_text "Like by 1 user"

    click_on "Like by 1 user"

    assert_text @user.name
  end

end
