# Simple Tasks App

A Rails 8.1 task management web application with a single-page experience powered by Hotwire (Turbo + Stimulus) and styled with TailwindCSS. Users can create, view, edit, delete, and toggle task completion without page reloads. Built on SQLite with a clean, minimal, responsive interface.

## Features

- **Create tasks** with inline validation (max 200 characters)
- **Edit tasks** inline using Turbo Frames
- **Delete tasks** dynamically without page reload
- **Mark tasks complete/incomplete** with strikethrough and muted styling
- **Single-page experience** — all interactions happen without full page reloads

## Tech Stack

- **Ruby on Rails 8.1** — Web framework with built-in Hotwire support
- **Hotwire** — Server-rendered HTML with SPA-like behavior
  - Turbo (form submissions, page updates)
  - Turbo Frames (inline editing)
  - Turbo Streams (real-time DOM updates)
  - Stimulus (optional for complex client-side logic)
- **TailwindCSS** — Utility-first CSS framework
- **SQLite 3** — Lightweight embedded database
- **Puma** — Rails web server
- **Solid Queue, Solid Cache, Solid Cable** — Rails 8 defaults for jobs, caching, and real-time features

## Requirements

- **Ruby 3.4.7** (see `.ruby-version`)
- **Bundler**

## Setup

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Create and migrate the database:
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   ```

## Running the Application

Start the web server and Tailwind CSS watcher:

```bash
bin/dev
```

The app will be available at `http://localhost:3000`

Alternatively, run components separately:

```bash
bin/rails server                # Start Rails server only (port 3000)
bin/rails tailwindcss:watch     # Start Tailwind CSS watcher in another terminal
```

## Testing

Run the full test suite:

```bash
bin/rails test
```

Run tests by type:

```bash
bin/rails test test/models      # Unit tests
bin/rails test test/controllers # Controller tests
bin/rails test test/integration # Integration tests
bin/rails test test/system      # System tests (Capybara + Selenium)
```

## Code Quality

Check and auto-correct code style with Rubocop:

```bash
bundle exec rubocop -A
```

Security scans:

```bash
bundle exec brakeman           # Rails security vulnerabilities
bundle exec bundler-audit      # Gem vulnerabilities
```

## Database

Useful database commands:

```bash
bin/rails db:reset             # Drop, recreate, and migrate
bin/rails db:seed              # Load seed data (if any)
bin/rails db:migrate:status    # Check migration status
```

## Data Model

The application uses a single `tasks` table:

| Field       | Type     | Notes                    |
|-------------|----------|--------------------------|
| id          | integer  | Primary key              |
| description | string   | Required, max 200 chars  |
| completed   | boolean  | Default: false           |
| created_at  | datetime | Timestamp                |
| updated_at  | datetime | Timestamp                |

## Documentation

- **SPEC.MD** — Full feature requirements and UI/UX details
- **CLAUDE.md** — Development guidance for Claude Code

## License

MIT
