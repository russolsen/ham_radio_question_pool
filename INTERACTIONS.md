# Interactions Log

## 2026-04-21: Create HTML viewer for Extra Class Question Pool

**Request:** Create `extra-2024-2028/extra-2024-2028.html` from `extra-2024-2028/extra-2024-2028.json`

**Requirements:**
- Display questions and answers (correct answer only, shown after question with blank line)
- Responsive design for desktop and mobile
- Each question bookmarkable via anchor IDs
- LocalStorage saves last clicked question, scrolls to it on next visit

**Files Created:**
- `extra-2024-2028/extra-2024-2028.html` - HTML viewer with:
  - Clean, responsive CSS design
  - Questions rendered from JSON via JavaScript fetch
  - Each question has an anchor ID matching its question ID (e.g., `#E1A01`)
  - Clicking a question saves its ID to localStorage
  - Page scrolls to last visited question on load
  - Back-to-top button for navigation
  - Last visited question highlighted with yellow border

## 2026-04-21: Add localStorage caching for offline use

**Request:** Cache the question data in localStorage so the page works offline and loads faster after the first visit.

**Changes to `extra-2024-2028/extra-2024-2028.html`:**
- Added `CACHE_KEY` constant for storing questions
- Modified `loadQuestions()` to:
  1. First check localStorage for cached questions
  2. If cached, use immediately (instant load)
  3. If not cached, fetch from JSON file and store in localStorage
  4. Works fully offline after first visit

## 2026-04-21: Add General and Technician HTML viewers

**Request:** Create similar HTML viewers for General and Technician question pools, and update index.html with links to all three.

**Files Created:**
- `general-2023-2027/general-2023-2027.html` - General Class question viewer
- `technician-2026-2030/technician-2026-2030.html` - Technician Class question viewer

**Files Modified:**
- `index.html` - Redesigned with styled links to all three question pools (Technician, General, Extra)

## 2026-04-21: Add outdated Technician 2022-2026 HTML viewer

**Request:** Create HTML viewer for the outdated technician-2022-2026 question pool.

**Files Created:**
- `outdated/technician-2022-2026/technician-2022-2026.html` - Technician 2022-2026 viewer with:
  - Orange color scheme to distinguish as outdated
  - Notice banner linking to current pool
  - Handles older JSON format (no `correct_letter` field)

**Files Modified:**
- `index.html` - Added "Outdated" section with link to the 2022-2026 Technician pool
