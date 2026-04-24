# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Rails 8.1 task management web application with a single-page experience using Hotwire (Turbo + Stimulus) for dynamic interactions and TailwindCSS for styling. Users can create, view, edit, delete, and mark tasks as completed without page reloads. Tasks are stored in SQLite with a 200-character description limit.

## Development Commands

### Setup
```bash
bundle install                    # Install Ruby dependencies
bin/rails db:create             # Create development database
bin/rails db:migrate            # Run database migrations
```

### Running the Application
```bash
bin/dev                          # Start web server and Tailwind CSS watcher (uses Procfile.dev)
bin/rails server                # Start just the Rails server (localhost:3000)
bin/rails tailwindcss:watch     # Start just the Tailwind CSS watcher
```

### Database
```bash
bin/rails db:reset              # Drop, recreate, and migrate database
bin/rails db:seed               # Load seed data (if any)
bin/rails db:migrate:status     # Check migration status
```

### Testing
```bash
bin/rails test                  # Run all tests
bin/rails test test/models      # Run model tests only
bin/rails test test/controllers # Run controller tests only
bin/rails test test/integration # Run integration tests only
bin/rails test test/system      # Run system tests (browser automation)
bin/rails test:system           # Alternative system test command
```

### Code Quality
```bash
bundle exec rubocop             # Run Rubocop linter (Omakase Rails style)
bundle exec rubocop -A          # Auto-correct Rubocop offenses
bundle exec brakeman            # Security vulnerability scanner
bundle exec bundler-audit       # Check gems for known vulnerabilities
```

## Architecture

### Key Components

**Models** (`app/models/`):
- `Task`: Single model representing a task with `description` (string, max 200 chars), `completed` (boolean), timestamps

**Controllers** (`app/controllers/`):
- Standard Rails RESTful actions for task management
- Responds to both HTML (Turbo) and JSON formats

**Views** (`app/views/`):
- Server-rendered templates with Turbo Frames for inline editing
- Uses Turbo Streams for dynamic updates without page reload
- TailwindCSS for styling

**Frontend** (`app/javascript/`):
- Stimulus controllers for small UI interactions (if needed)
- Turbo handles form submissions and page updates

### Data Model

Single `tasks` table with:
- `id` (primary key)
- `description` (string, required, max 200 chars)
- `completed` (boolean, default: false)
- `created_at`, `updated_at` (timestamps)

## Key Technologies

- **Rails 8.1**: Web framework with built-in Hotwire support
- **Hotwire**: Server-rendered HTML with SPA-like behavior
  - **Turbo**: Form submissions and page updates (no full reloads)
  - **Turbo Frames**: Inline editing with request/response isolation
  - **Turbo Streams**: Real-time DOM updates
  - **Stimulus**: Optional for complex client-side logic
- **TailwindCSS**: Utility-first CSS framework
- **SQLite 3**: Lightweight embedded database
- **Puma**: Rails web server
- **Solid Queue**: Background job processor
- **Solid Cache**: Database-backed cache
- **Solid Cable**: Database-backed ActionCable adapter

## Testing Conventions

- Unit tests in `test/models/`
- Controller tests in `test/controllers/`
- Integration tests in `test/integration/`
- System tests (Capybara + Selenium) in `test/system/`
- Use fixtures in `test/fixtures/` for test data

## Styling

- TailwindCSS classes only (no custom CSS unless necessary)
- Completed tasks use strikethrough and muted text (TailwindCSS utilities like `line-through` and `text-gray-500`)
- Build CSS with `bin/rails tailwindcss:watch` during development

## Specification Reference

Full feature requirements and UI/UX details are in `SPEC.MD`. Key requirements:
- Single-page task management (no full reloads)
- Inline validation errors
- Task actions: create, read, update, delete, toggle completion
- Visual distinction for completed tasks (strikethrough + muted styling)
- Responsive design

## Code Style

Uses Rubocop with Rails Omakase configuration (`.rubocop.yml`). Run `bundle exec rubocop -A` to auto-correct style issues before committing.
