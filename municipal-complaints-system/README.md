# Municipal Online Complaint Management System

A production-ready microservices-based online complaint management system for municipalities, built with Spring Boot and Spring Cloud technologies.

## 🏗️ Architecture Overview

The system follows a microservices architecture with the following components:

- **Eureka Server** (Port 8761) - Service discovery and registration
- **Config Server** (Port 8888) - Centralized configuration management
- **API Gateway** (Port 8080) - Single entry point with JWT authentication and routing
- **User Service** (Port 8081) - User management, authentication, and role-based dashboards
- **Complaint Service** (Port 8082) - Complaint CRUD operations and management
- **Department Service** (Port 8083) - Department and staff assignment management
- **Notification Service** (Port 8084) - Email and SMS notifications
- **MySQL Database** - Centralized data storage

## 🚀 Quick Start

### Prerequisites

- Java 17 or higher
- Maven 3.6+
- Docker and Docker Compose
- MySQL 8.0 (or use the provided Docker setup)

### 1. Clone and Setup

```bash
git clone <repository-url>
cd municipal-complaints-system
```

### 2. Start the System

```bash
# Start all services using Docker Compose
docker-compose up -d

# Or start services individually
docker-compose up mysql eureka-server config-server -d
# Wait for services to be healthy, then:
docker-compose up api-gateway user-service complaint-service department-service notification-service -d
```

### 3. Access the System

- **Eureka Dashboard**: http://localhost:8761
- **API Gateway**: http://localhost:8080
- **User Service**: http://localhost:8081
- **Complaint Service**: http://localhost:8082
- **Department Service**: http://localhost:8083
- **Notification Service**: http://localhost:8084

## 🔐 Default Credentials

The system comes with pre-configured users:

| Username | Password | Role | Description |
|----------|----------|------|-------------|
| `admin` | `admin123` | ADMIN | System Administrator |
| `water_staff` | `staff123` | STAFF | Water Works Department |
| `sanitation_staff` | `staff123` | STAFF | Sanitation Department |
| `roads_staff` | `staff123` | STAFF | Roads Department |
| `citizen1` | `citizen123` | CITIZEN | Sample Citizen User |
| `citizen2` | `citizen123` | CITIZEN | Sample Citizen User |
| `citizen3` | `citizen123` | CITIZEN | Sample Citizen User |

## 🏠 User Dashboards

### Citizen Dashboard (`/citizen/home`)
- File new complaints
- View personal complaint history
- Track complaint status
- Add comments to complaints
- Modern Bootstrap 5 UI

### Staff Dashboard (`/staff/home`)
- View assigned complaints
- Update complaint status
- Assign complaints to departments
- Add comments and notes
- Department-specific views

### Admin Dashboard (`/admin/home`)
- User management (create, edit, delete)
- System statistics and health monitoring
- Department management
- System configuration
- Comprehensive oversight

## 🔌 API Endpoints

### Authentication
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User login (returns JWT)

### User Management
- `GET /api/users/me` - Get current user profile
- `GET /api/admin/users` - Get all users (ADMIN only)
- `POST /api/admin/users` - Create new user (ADMIN only)
- `PUT /api/admin/users/{id}` - Update user (ADMIN only)
- `DELETE /api/admin/users/{id}` - Delete user (ADMIN only)

### Complaints
- `POST /api/complaints` - Create complaint (CITIZEN)
- `GET /api/complaints` - Get all complaints (STAFF/ADMIN)
- `GET /api/complaints/mine` - Get user's complaints (CITIZEN)
- `GET /api/complaints/{id}` - Get complaint details
- `PUT /api/complaints/{id}/assign` - Assign complaint (STAFF/ADMIN)
- `PUT /api/complaints/{id}/status` - Update status (STAFF/ADMIN)
- `POST /api/complaints/{id}/comments` - Add comment

### Departments
- `GET /api/departments` - Get all departments
- `POST /api/departments` - Create department (ADMIN only)
- `PUT /api/departments/{id}` - Update department (ADMIN only)
- `POST /api/departments/{id}/assign-staff` - Assign staff (ADMIN only)

### Notifications
- `POST /api/notifications/send` - Send notification (internal service calls)

## 🗄️ Database Schema

The system uses a single MySQL database (`municipal_complaints`) with the following main tables:

- **users** - User accounts and roles
- **departments** - Department information
- **department_staff** - Staff assignments to departments
- **complaints** - Complaint records
- **comments** - Comment threads on complaints
- **notifications** - Notification logs

## 🔧 Configuration

### Environment Variables

Key configuration can be modified through environment variables:

```bash
# Database
SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/municipal_complaints
SPRING_DATASOURCE_USERNAME=municipal_user
SPRING_DATASOURCE_PASSWORD=municipal_pass

# JWT
JWT_SECRET=your-secret-key
JWT_EXPIRATION=86400000

# Eureka
EUREKA_CLIENT_SERVICEURL_DEFAULTZONE=http://eureka-server:8761/eureka/

# Config Server
CONFIG_URI=http://config-server:8888
```

### Service Configuration

Each service reads its configuration from the Config Server. Configuration files are located in:
- `config-server/src/main/resources/config/`

## 🐳 Docker Deployment

### Building Services

```bash
# Build all services
mvn clean package -DskipTests

# Build individual services
cd user-service && mvn clean package -DskipTests
cd ../complaint-service && mvn clean package -DskipTests
# ... repeat for other services
```

### Docker Compose

The `docker-compose.yml` file orchestrates all services with:
- Health checks for service dependencies
- Proper startup order
- Network isolation
- Volume persistence for MySQL data

## 🧪 Testing

### API Testing

Use the provided Postman collection (`Municipal_Complaints_API.postman_collection.json`) to test all endpoints.

### Manual Testing

1. **Start the system** using Docker Compose
2. **Access Eureka** to verify service registration
3. **Login as admin** to verify authentication
4. **Create test users** and complaints
5. **Test role-based access** for different user types

## 📊 Monitoring and Health

Each service exposes health endpoints:
- `/actuator/health` - Service health status
- `/actuator/info` - Service information
- `/actuator/metrics` - Performance metrics

## 🔒 Security Features

- **JWT-based authentication** with secure HTTP-only cookies
- **Role-based access control** (CITIZEN, STAFF, ADMIN)
- **Password encryption** using BCrypt
- **Stateless sessions** for scalability
- **Input validation** with custom validators
- **CORS configuration** for web security

## 🚨 Troubleshooting

### Common Issues

1. **Services not starting**: Check MySQL connection and Eureka registration
2. **JWT authentication failures**: Verify JWT secret configuration
3. **Database connection errors**: Ensure MySQL is running and accessible
4. **Service discovery issues**: Check Eureka server health

### Logs

View service logs:
```bash
docker-compose logs <service-name>
docker-compose logs -f <service-name>  # Follow logs
```

### Health Checks

Verify service health:
```bash
curl http://localhost:8080/actuator/health  # Gateway
curl http://localhost:8081/actuator/health  # User Service
curl http://localhost:8082/actuator/health  # Complaint Service
# ... etc
```

## 📈 Scaling Considerations

- **Horizontal scaling**: Deploy multiple instances of each service
- **Load balancing**: Use Eureka for service discovery
- **Database scaling**: Consider read replicas for heavy read operations
- **Caching**: Implement Redis for frequently accessed data
- **Message queues**: Use RabbitMQ/Kafka for asynchronous processing

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the troubleshooting section above

---

**Note**: This is a production-ready system designed for municipal use. Ensure proper security measures and compliance with local regulations before deployment.