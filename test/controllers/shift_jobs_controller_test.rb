require "test_helper"

describe ShiftJobsController do
  it "should get new" do
    get shift_jobs_new_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get shift_jobs_edit_url
    value(response).must_be :success?
  end

  it "should get index" do
    get shift_jobs_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get shift_jobs_show_url
    value(response).must_be :success?
  end

end
