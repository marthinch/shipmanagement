## Architecture

The application follows a layered architecture:

```text
API
 |
 v
Service
 |
 v
Repository
 |
 v
SQL Server Stored Procedures
```

## API

Responsible for:
- HTTP endpoints
- Request/response models
- API validation
- HTTP status codes

## Service

Responsible for:
- Business logic
- Application-level validation
- Coordination between API and repository

## Repository

Responsible for:
- Database connections
- Executing stored procedures
- Mapping database results to C# models

## Stored Procedures

The API uses stored procedures for database operations.

## Database

SQL Server is used as the persistence layer and database access is performed through stored procedures rather than inline SQL from the application.

## Stored Procedures

This keeps SQL/database logic inside SQL Server and keeps the repository responsible for executing database commands.

## API Validation

Input validation is performed at the API boundary so invalid requests are rejected before reaching the service and database layers.

## Error Handling

The API should return standard HTTP status codes below. The exception handling also implemented as middleware to catch all exception globally and log it.

```text
200 OK
201 Created
400 Bad Request
404 Not Found
500 Internal Server Error
```

## Run the Application

1. Open this folder directory "ShipManagemet/Database"

2. Execute all sql files in your Sql Server Management Studio (See the prefix number for each file)
	- 00_Database.sql
	- 01_Tables.sql
	- 02_SampleData.sql

3. Execute all stored procedure files under this folder "ShipManagemet/Database/StoredProcedures" in your Sql Server Management Studio

4. Open ShipManagement.slnx solution

5. Open appsettings.json and configure the connection string based on your local machine sql server (OPTIONAL)

6. Set ShipManagement as start up project and click IIS Express button to run API

7. Open this url on your browser: https://localhost:44344/swagger/index.html