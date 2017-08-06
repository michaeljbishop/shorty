require 'test_helper'

class EntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @entry = entries(:one)
    @encoded_id = IdEncoder.encoded_id(@entry.id)
  end

  test "should get new" do
    get new_entry_url
    assert_response :success
  end

  test "should create entry" do
    url = "http://www.apple.com"
    assert_difference('Entry.count') do
      post entries_url, params: { entry: { url: url} }
    end

    assert_redirected_to entry_url(IdEncoder.encoded_id(Entry.last.id))
  end

  test "should return existing entry" do
    assert_no_changes('Entry.count') do
      post entries_url, params: { entry: { url: @entry.url} }
    end

    assert_redirected_to entry_url(@encoded_id)
  end

  test "should redirect" do
    assert_no_changes('Entry.count') do
      get redirect_entry_url(@encoded_id)
    end

    assert_redirected_to @entry.url
  end

  test "should show entry" do
    get entry_url(@encoded_id)
    assert_response :success
  end
end
