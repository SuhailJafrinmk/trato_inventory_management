# Trato Inventory Management

## Description
This is a basic version of an Inventory Management System built using Flutter. The app allows users to manage products, track sales and purchases, and generate reports. It features the ability to add, edit, and delete products, view the current inventory status, track stock-out products, and generate PDF reports for sales and purchases.

## Features
- **Add New Product**: Users can add products to the inventory with details like name, quantity, and price.
- **Edit Existing Product**: Update product details, such as price and stock quantity.
- **Delete Product**: Remove a product from the inventory.
- **Inventory Dashboard**: Provides a snapshot of current inventory status, including:
  - Products in stock
  - Total sales
  - Total purchases
- **Stock-Out Alerts**: List products that are out of stock or running low.
- **Sales and Purchase Reports**: View the latest sales and purchase transactions.
- **PDF Report Generation**: Generate a PDF report for individual sales or purchase transactions.
- **View Purchase and Sales Reports**: View a detailed report of past sales and purchases.

## Screenshots
![Login Screen](screenshots/login_screen.jpg)
![Home Screen](screenshots/home_screen.jpg)
![Out Of Stock](screenshots/out_of_stock_products.jpg)
![Recent Sales](screenshots/recent_sales.jpg)
![Recent Purchases](screenshots/recent_sales.jpg)
![Add Product](screenshots/add_product.jpg)
![Category Products](screenshots/category_products.jpg)
![Product Details](screenshots/product_details.jpg)
![Products and Categories](screenshots/products_and_categories.jpg)
![Sales and Purchases](screenshots/sales_and_purchases.jpg)
![Purchase Records](screenshots/purchase_records.jpg)
![Sales Records](screenshots/sales_records.jpg)
![Select Quantity](screenshots/selecting_quantity.jpg)
![Sellers List](screenshots/sellers_list.jpg)
![Customers List](screenshots/customers_list.jpg)
![Generated Pdf](screenshots/generated_pdf.jpg)


## Getting Started

### Prerequisites
- [Flutter](https://flutter.dev/docs/get-started/install) SDK installed on your machine.
- A code editor such as [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/username/inventory-management-app.git
    ```

2. Navigate to the project directory:
    ```bash
    cd inventory-management-app
    ```

3. Install the dependencies:
    ```bash
    flutter pub get
    ```

4. Run the app:
    ```bash
    flutter run
    ```

### Folder Structure

```bash
lib/
├── bloc/                   # Business Logic Components (state management)
├── models/                 # Data models (Product, Sale, Purchase)
├── screens/                # UI Screens (Dashboard, AddProductScreen, SalesReportScreen)
├── widgets/                # Reusable UI components (ProductCard, ReportList)
├── services/               # Services (PDF generation, API calls)
└── main.dart               # Entry point of the application
