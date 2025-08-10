# Municipal Online Complaint Management System (Microservices)

This repository contains a production-ready microservices-based system for municipalities. It includes:

- Eureka Server (Service Discovery) — port 8761
- Spring Cloud Config Server — port 8888
- Spring Cloud Gateway — port 8080
- User Service (JSP UI + Auth/JWT) — port 8081
- Complaint Service — port 8082 (coming in next iteration)
- Department Service — port 8083 (coming in next iteration)
- Notification Service — port 8084 (coming in next iteration)

No Lombok is used anywhere. All boilerplate is written manually.

## Quick Start (initial stack)

- Prerequisites: Docker, Docker Compose, JDK 17+, Maven 3.9+
- Build services:
  ```bash
  mvn -q -DskipTests package
  ```
- Start infra and services:
  ```bash
  docker compose up --build
  ```
- Open:
  - Eureka Dashboard: http://localhost:8761
  - Gateway: http://localhost:8080
  - User Service UI via Gateway: http://localhost:8080/ui/login

## Services

- Config Server reads from `config-repo/` (native backend). Database, JWT secrets, and service ports are configured there.
- All services register with Eureka and import properties from Config Server.
- Gateway validates JWT and routes `/api/users/**` and UI paths to the User Service.

## Database

- MySQL service `mysql` is provided via docker compose. A single database `municipal_complaints` is used; each microservice has its own tables within this database.

## Roadmap

- Implement Complaint, Department, and Notification services with full CRUD, validation, and inter-service notifications.
- Add integration tests, Swagger UI aggregation via Gateway, and Postman collection.