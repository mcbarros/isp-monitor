require "application_system_test_case"

class RouterConfigsTest < ApplicationSystemTestCase
  setup do
    @router_config = router_configs(:one)
  end

  test "visiting the index" do
    visit router_configs_url
    assert_selector "h1", text: "Router configs"
  end

  test "should create router config" do
    visit router_configs_url
    click_on "New router config"

    fill_in "Host", with: @router_config.host
    fill_in "Name", with: @router_config.name
    fill_in "Password", with: @router_config.password
    fill_in "Port", with: @router_config.port
    fill_in "User", with: @router_config.user
    click_on "Create Router config"

    assert_text "Router config was successfully created"
    click_on "Back"
  end

  test "should update Router config" do
    visit router_config_url(@router_config)
    click_on "Edit this router config", match: :first

    fill_in "Host", with: @router_config.host
    fill_in "Name", with: @router_config.name
    fill_in "Password", with: @router_config.password
    fill_in "Port", with: @router_config.port
    fill_in "User", with: @router_config.user
    click_on "Update Router config"

    assert_text "Router config was successfully updated"
    click_on "Back"
  end

  test "should destroy Router config" do
    visit router_config_url(@router_config)
    click_on "Destroy this router config", match: :first

    assert_text "Router config was successfully destroyed"
  end
end
