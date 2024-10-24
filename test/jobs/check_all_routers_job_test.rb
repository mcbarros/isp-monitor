require "test_helper"

class CheckAllRoutersJobTest < ActiveJob::TestCase
  test "should start a job for each active router" do
    ids = []

    CheckRouterJob.stub(:perform_later, ->(id) { ids << id }) do
      CheckAllRoutersJob.new.perform
    end

    assert_equal RouterConfig.count, ids.size

    RouterConfig.all.each do |item|
      assert_includes ids, item.id
    end
  end
end
