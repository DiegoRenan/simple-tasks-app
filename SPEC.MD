# Technical Specification — Tasks Web App

## 1. Overview

A simple web application that allows users to manage daily tasks efficiently through a single-page experience.

Users can create, view, update, delete, and mark tasks as completed without leaving or reloading the page. Each task consists of a short text description with a maximum length of 200 characters, stored in a SQLite database.

Completed tasks should be visually distinguished using a strikethrough style and muted text color.

The application should provide a fast, responsive, and modern user experience using Ruby on Rails with Hotwire for dynamic interactions and TailwindCSS for clean and minimal styling.

The goal is to simulate SPA-like behavior while maintaining Rails simplicity through server-rendered HTML and Turbo-powered interactions.

---

## 2. Core Features

## Task Management

### List Tasks
- Display all created tasks on the main page
- Show both completed and pending tasks
- Keep all task interactions available on the same screen

### Create Task
- Allow users to add a new task from the main page
- Validate task description presence
- Limit task description to 200 characters
- Display validation errors inline without page refresh

### Edit Task
- Allow users to update an existing task directly from the task list
- Use inline editing without page navigation
- Maintain the same validation rules

### Delete Task
- Allow users to permanently remove a task
- Remove task dynamically from the list without page reload

### Mark Task as Completed
- Allow users to mark a task as completed
- Completed tasks should:
  - display with strikethrough text
  - show muted styling
  - optionally display a visual indicator (checkbox or icon)

### Mark Task as Pending (Optional Improvement)
- Allow users to unmark a completed task and return it to pending status

---

## 3. Technical Stack

## Backend
- Ruby on Rails

## Frontend
- Hotwire
  - Turbo
  - Turbo Frames
  - Turbo Streams
  - Stimulus (if needed for small UI interactions)

## Styling
- TailwindCSS

## Database
- SQLite

---

## 4. Data Model

## Task

| Field        | Type      | Description |
|---|---|---|
| id           | integer   | Primary key |
| description  | string    | Task text (max 200 chars) |
| completed    | boolean   | Completion status |
| created_at   | datetime  | Record creation timestamp |
| updated_at   | datetime  | Record update timestamp |

---

## 5. Validations

### Required Rules

- `description` must be present
- `description` maximum length: 200 characters
- `completed` default value: `false`

---

## 6. UI / UX Requirements

## Single Page Experience

The application should provide a single-page task management flow where users can create, edit, delete, view, and mark tasks as completed without leaving the page.

All interactions should happen dynamically using Hotwire, avoiding full-page reloads.

The goal is to provide SPA-like behavior while preserving Rails conventions and simplicity.

---

## 7. Main Layout

The interface should be clean, minimal, and responsive.

### Task Creation Section

Located at the top of the page.

Includes:
- text input for task description
- create task button

Validation errors should appear inline.

---

### Task List Section

Located below the creation form.

Displays all tasks in a vertical list.

Each task item should contain:

- task description
- completion status
- edit action
- delete action
- complete / uncomplete action

---

## 8. Inline Actions

All actions should happen directly on the same page.

### Create
Submitting the form should instantly append the new task to the list.

### Edit
Editing should happen inline using Turbo Frames by replacing the task row with an edit form.

### Delete
Deleting should instantly remove the task from the list.

### Complete / Uncomplete
Toggling completion status should update the UI immediately by applying or removing strikethrough styling.

No full-page reloads should occur during any interaction.

---

## 9. Visual Behavior

## Completed Tasks

Completed tasks should display:

- strikethrough text
- muted text color
- optional checkbox or icon indicator

Example:

```text
☑ Submit technical challenge
☐ Finish Rails interview prep