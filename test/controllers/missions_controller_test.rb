require 'test_helper'

class MissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mission = missions(:one)
  end

  test "should get index" do
    get missions_url
    assert_response :success
  end

  test "should get new" do
    get new_mission_url
    assert_response :success
  end

  test "should create mission" do
    assert_difference('Mission.count') do
      post missions_url, params: { mission: { category_id: @mission.category_id, co2: @mission.co2, continuous: @mission.continuous, difficulty: @mission.difficulty, difficulty: @mission.difficulty, duration: @mission.duration, name: @mission.name, text: @mission.text } }
    end

    assert_redirected_to mission_url(Mission.last)
  end

  test "should show mission" do
    get mission_url(@mission)
    assert_response :success
  end

  test "should get edit" do
    get edit_mission_url(@mission)
    assert_response :success
  end

  test "should update mission" do
    patch mission_url(@mission), params: { mission: { category_id: @mission.category_id, co2: @mission.co2, continuous: @mission.continuous, difficulty: @mission.difficulty, difficulty: @mission.difficulty, duration: @mission.duration, name: @mission.name, text: @mission.text } }
    assert_redirected_to mission_url(@mission)
  end

  test "should destroy mission" do
    assert_difference('Mission.count', -1) do
      delete mission_url(@mission)
    end

    assert_redirected_to missions_url
  end
end
