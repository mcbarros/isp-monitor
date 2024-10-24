require "test_helper"

class CheckAllRoutersJobTest < ActiveJob::TestCase
  test "should start a job for each active router" do
    ids = []

    CheckRouterJob.stub(:perform_later, ->(id) { ids << id }) do
      CheckAllRoutersJob.new.perform
    end

    assert_equal RouterConfig.checkable.count, ids.size

    RouterConfig.checkable.each do |item|
      assert_includes ids, item.id
    end
  end
end
