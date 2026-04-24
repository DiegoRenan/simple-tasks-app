require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  test "GET index renders successfully with task list and form" do
    get root_path
    assert_response :success
    assert_select "h1", "My Tasks"
    assert_select "form"
    assert_select "#tasks"
  end

  test "GET index lists all tasks from fixtures" do
    get root_path
    assert_response :success
    assert_select "##{dom_id(tasks(:pending_task))}"
    assert_select "##{dom_id(tasks(:completed_task))}"
  end

  test "POST create with valid params creates a task and returns turbo stream" do
    assert_difference "Task.count", 1 do
      post tasks_path, params: { task: { description: "Write tests" } }, as: :turbo_stream
    end
    assert_response :ok
    assert_turbo_stream action: "prepend", target: "tasks"
    assert_turbo_stream action: "remove", target: "empty_tasks_message"
    assert_turbo_stream action: "replace", target: "task_form"
  end

  test "POST create with blank description returns 422 and turbo stream with error" do
    assert_no_difference "Task.count" do
      post tasks_path, params: { task: { description: "" } }, as: :turbo_stream
    end
    assert_response :unprocessable_entity
  end

  test "POST create with description over 200 chars returns 422" do
    assert_no_difference "Task.count" do
      post tasks_path, params: { task: { description: "x" * 201 } }, as: :turbo_stream
    end
    assert_response :unprocessable_entity
  end

  test "POST create with HTML format redirects to root on success" do
    post tasks_path, params: { task: { description: "HTML task" } }
    assert_redirected_to root_path
  end

  test "POST create with HTML format re-renders index on failure" do
    post tasks_path, params: { task: { description: "" } }
    assert_response :unprocessable_entity
    assert_select "form"
  end
end
