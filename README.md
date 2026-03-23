# Restaurant Management API

A simple REST API for managing restaurants and their menu items, built with Ruby on Rails.

## Features
- Full CRUD for Restaurants
- Manage Menu Items per Restaurant
- Filter Menu Items by category
- Pagination on list endpoints (using `kaminari`)
- Global error handling for missing resources and validation errors
- High test coverage with SimpleCov

## Requirements
- Ruby 3.x
- Rails 8.x
- SQLite3

## Getting Started

1.  **Install dependencies:**
    ```bash
    bundle install
    ```

2.  **Setup database:**
    ```bash
    rails db:migrate
    rails db:seed
    ```

3.  **Run the application:**
    ```bash
    rails server
    ```

4.  **Run tests:**
    ```bash
    rails test
    ```

## API Documentation

List endpoints (`GET /restaurants` and `GET /restaurants/:restaurant_id/menu_items`) support pagination via:
- `page`: Page number (default: 1)
- `per_page`: Items per page (default: 10)

Response format for list endpoints:
```json
{
  "data": [...],
  "meta": {
    "current_page": 1,
    "next_page": 2,
    "prev_page": null,
    "total_pages": 5,
    "total_count": 50
  }
}
```

- `GET /restaurants`: List all restaurants (paginated)
- `POST /restaurants`: Create a new restaurant
- `GET /restaurants/:id`: Show restaurant details (includes menu items)
- `PATCH /restaurants/:id`: Update a restaurant
- `DELETE /restaurants/:id`: Delete a restaurant
- `GET /restaurants/:restaurant_id/menu_items`: List menu items for a specific restaurant (optional `category` filter, paginated)
- `POST /restaurants/:restaurant_id/menu_items`: Create a menu item for a restaurant
- `PATCH /menu_items/:id`: Update a menu item
- `DELETE /menu_items/:id`: Delete a menu item

## Design Decisions

- **Global Error Handling**: Diimplementasikan di `ApplicationController` menggunakan `rescue_from`. Hal ini memastikan respons kesalahan yang konsisten (seperti 404 Not Found, 422 Unprocessable Entity, 400 Bad Request) di seluruh aplikasi tanpa perlu mengulang logika penanganan error di setiap controller.
- **Nested Controllers**: Menu items yang spesifik untuk sebuah restoran dikelola melalui `Restaurants::MenuItemsController`. Struktur ini mencerminkan relasi data (hierarki) di tingkat API dan memudahkan manajemen resource yang bergantung pada resource induk.
- **Pagination**: Menggunakan gem `kaminari` untuk menangani pagination secara efisien di tingkat database. Metadata pagination disertakan dalam respons JSON untuk memudahkan navigasi oleh client API.
