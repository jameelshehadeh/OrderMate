
# OrderMate - Restaurant Order Manager

This iOS application is designed to help restaurants manage their orders efficiently. The app allows the restaurant to create orders, mark them as "Preparing," "Ready," and "Delivered," and keep track of previously delivered orders. The app also enforces queue patterns, limiting the number of orders that can be in the "Preparing" state and the maximum number of orders that can be created.


## Features

1. User clicks on the "Place Order" button to create a new order with a unique number and add it to the queue list.

2. Orders have four states: "New," "Preparing," "Ready," and "Delivered."

3. Orders can be moved to the next state by clicking on a button, but they must follow the First In, First Out (FIFO) pattern.

4. Orders in the "Delivered" state disappear from the main list after 15 seconds.

5. Users can see the archives of delivered orders.

6. Users can search for orders by ID or name.

7. The restaurant cannot have more than three orders in the "Preparing" state at any given time.

8. The restaurant cannot have more than ten orders total.

9. Users can navigate to a detail page for each order.


## Getting Started

To get started with the Restaurant Order Manager app, follow these steps:

1. Clone this repository to your local machine.
2. Open the project in Xcode.
3. Build and run the app on a simulator or physical device.


## Requirements

- Xcode 11 or later
- iOS 13 or later
