# SQL Homework for Vikk

## Project Overview

This project focuses on designing a database for a taxi system application. The database schema is structured to manage various entities involved in the taxi service, including drivers, vehicles, orders, client feedback, ratings, and routes.

## Database Schema

The following entities are included in the database schema:

- **DRIVERS**: Contains information about taxi drivers, including their unique identifier, name, license number, phone number, email, and hire date.
  
- **VEHICLES**: Stores details about the vehicles used in the taxi service, including a unique identifier, driver association, make, model, manufacturing year, and license plate number.
  
- **VEHICLE_MAKES**: Contains unique identifiers and names for vehicle makes, allowing for better normalization of vehicle data.
  
- **VEHICLE_MODELS**: Contains unique identifiers, names for vehicle models, and foreign keys linking to the corresponding vehicle make.
  
- **ORDERS**: Represents customer orders, linking to clients and vehicles, and includes order date, pickup and dropoff locations, and order status.
  
- **CLIENT_FEEDBACK**: Captures feedback from clients regarding their orders, including the feedback text and creation timestamp.
  
- **RATINGS**: Records ratings given by clients for their orders, including the rating value and creation timestamp.
  
- **ROUTE**: Describes the routes taken for each order, including a description, distance, and estimated time.

## Relationships

The relationships between the entities are defined as follows:

- A driver can own multiple vehicles.
- A vehicle can be used for multiple orders.
- An order can receive multiple pieces of client feedback and ratings.
- An order can have a defined route.
- A vehicle make can have multiple models associated with it.
- Each vehicle now references a make and a model through foreign keys, improving data integrity and organization.

## Usage

To use this database schema, you can implement it in your SQL database management system of choice. The schema can be modified or extended based on additional requirements or features you wish to implement in the taxi system application.

## Conclusion

This database design provides a solid foundation for managing a taxi service's operations, ensuring efficient data handling and retrieval for various functionalities within the application.
