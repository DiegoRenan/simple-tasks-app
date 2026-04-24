require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "valid task with description" do
    task = Task.new(description: "Buy groceries")
    assert task.valid?
  end

  test "invalid without description" do
    task = Task.new(description: nil)
    assert_not task.valid?
    assert_includes task.errors[:description], "can't be blank"
  end

  test "invalid with blank description" do
    task = Task.new(description: "")
    assert_not task.valid?
    assert_includes task.errors[:description], "can't be blank"
  end

  test "invalid if description exceeds 200 characters" do
    task = Task.new(description: "a" * 201)
    assert_not task.valid?
    assert_includes task.errors[:description], "is too long (maximum is 200 characters)"
  end

  test "valid at exactly 200 characters" do
    task = Task.new(description: "a" * 200)
    assert task.valid?
  end

  test "completed defaults to false" do
    task = Task.create(description: "Test task")
    assert_equal false, task.completed
  end

  test "can be marked completed" do
    task = Task.new(description: "Test task", completed: true)
    assert task.valid?
    assert task.completed
  end
end
