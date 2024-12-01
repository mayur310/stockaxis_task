# Stockaxis Assignment

This Flutter project implements a user interface for a Stockaxis assignment. The app dynamically fetches data from APIs, allows users to select/unselect products, calculates the total amount, and applies discounts for multiple product selections. It is built with a modular architecture, responsive design, and *Riverpod* for state management.

---

## Key Features

1. *Dynamic Product Pricing*:
   - Integrates three investment plans (Little Masters, Emerging Market Leaders, Large Cap Focus).
   - Fetches real-time pricing from REST APIs.
   - Displays pricing in interactive dropdown spinners.

2. *Dynamic Price Calculation*:
   - Calculates the total price based on product selection.
   - Applies a *20% combo discount* when two products are selected.

3. *Responsive Design*:
   - Optimized for both *mobile* and *desktop* platforms with separate view implementations.

4. *Scalable Structure*:
   - Modular folder structure for improved code scalability and readability.

5. *Theming*:
   - Built-in light and dark themes for enhanced user experience.

---

## Folder Structure

The project is organized with a *scalable modular architecture*:

### *assets*
Contains static files used across the app:
- *icons/*: Images grouped into light and dark mode.

### *lib*
The core of the application, containing all logic and UI components.

- **main.dart**: App entry point.

- *pages/*:
  - Contains the UI and logic for each page (e.g., home_page/).
  - Each page is broken into:
    - *Page File* (page_name_page.dart): Manages page logic.
    - *Mobile View* (mobile_view.dart): UI for mobile screens.
    - *Desktop View* (desktop_view.dart): UI for desktop screens.
    - *View Model* (view_model.dart): State management for the page.

- *components/*:
  - *page-specific components*: UI elements for a specific page.
  - *shared/*: Reusable components shared across multiple pages.
  - *widgets/*: General-purpose, reusable widgets like buttons, spinners, etc.

- *api/*:
  - Contains logic for API interactions.
  - Each API has:
    - *API Logic* ((api_name)_api.dart): Contains HTTP methods.

- *utils/*:
  - Helper utilities for various app functions.
  - Includes:
    - *services/*: Services like shared preferences and local storage.
    - *state/*: State management files organized into:
      - *Providers*: Define application states.
      - *Actions*: Handle state mutations.

---

## Discount Logic

The app dynamically calculates the total price:
- *Single Product*: Adds its price to the total.
- *Two Products: A **20% discount* is applied.

---

## Riverpod State Management
    Riverpod is used for efficient and reactive state management.

    Structure:
        Providers: Define and expose the state (e.g., selected products, pricing data).
        Actions: Define logic to update or modify the state.

---

## Theming
    The app supports light and dark themes:
    Light Theme: Defined in light_theme.dart.
    
---

## Google Drive Link
    Link: https://drive.google.com/drive/folders/1Fh-ofMHo13zNcskej20mQrCHI7j1yHML?usp=sharing
