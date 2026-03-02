# Job Portal Web Application

A full-stack Job Portal built with **Java Servlets**, **JSP**, **JDBC**, and **MySQL**, following the MVC pattern and packaged as a WAR for deployment on Apache Tomcat.

---

## Milestone Status

| Milestone | Scope | Status |
|-----------|-------|--------|
| **M1** | Auth (register / login / logout), session management, AuthFilter | ✅ Complete |
| **M2** | Job posting, job search, apply with resume upload, application tracking | 🔜 Planned |

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | Java 11 |
| Web layer | Java Servlets + JSP (JSTL) |
| Database | MySQL 8 |
| DB access | JDBC with `PreparedStatement` (no ORM) |
| Build | Apache Maven 3.x (WAR packaging) |
| Server | Apache Tomcat 9 |
| Auth | HTTP Session + servlet `Filter` |

---

## Project Structure

```
job-portal/
├── pom.xml                         # Maven build descriptor
├── schema.sql                      # MySQL DDL (run once to create tables)
└── src/main/
    ├── java/com/jobportal/
    │   ├── controller/             # Servlets (one per feature)
    │   │   ├── RegisterServlet.java
    │   │   ├── LoginServlet.java
    │   │   ├── LogoutServlet.java
    │   │   └── DashboardServlet.java
    │   ├── dao/                    # Data-access objects (JDBC + PreparedStatement)
    │   │   └── UserDAO.java
    │   ├── filter/
    │   │   └── AuthFilter.java     # Session-based auth gate for all routes
    │   ├── model/                  # Plain Java beans
    │   │   └── User.java
    │   └── util/
    │       ├── DBConnection.java   # Connection factory (env vars → properties → defaults)
    │       └── PasswordUtil.java   # Salted SHA-256 password hashing
    ├── resources/
    │   └── db.properties          # Fallback DB credentials (overridden by env vars)
    └── webapp/
        ├── index.jsp              # Public landing page
        └── WEB-INF/
            ├── web.xml
            └── views/             # All JSPs (not directly accessible)
                ├── login.jsp
                ├── register.jsp
                ├── candidate-dashboard.jsp
                ├── employer-dashboard.jsp
                └── error.jsp
```

---

## Prerequisites

- Java 11+
- Maven 3.6+
- MySQL 8.0+
- Apache Tomcat 9.x

---

## Setup

### 1. Create the database

```sql
-- Connect to MySQL as a user with CREATE privileges, then run:
source /path/to/schema.sql
```

Or paste the contents of `schema.sql` directly into your MySQL client. This creates the `jobportal` database and the `users`, `jobs`, and `applications` tables.

### 2. Configure database credentials

The application resolves credentials in this priority order:

| Priority | Source | Keys |
|----------|--------|------|
| 1 (highest) | Environment variables | `DB_URL`, `DB_USERNAME`, `DB_PASSWORD` |
| 2 | `src/main/resources/db.properties` | `db.url`, `db.username`, `db.password` |
| 3 (fallback) | Hard-coded defaults | `localhost:3306/jobportal`, `root` / `root` |

**Option A – environment variables (recommended for production):**

```bash
export DB_URL="jdbc:mysql://localhost:3306/jobportal?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true"
export DB_USERNAME="your_db_user"
export DB_PASSWORD="your_db_password"
```

**Option B – edit `src/main/resources/db.properties`:**

```properties
db.url=jdbc:mysql://localhost:3306/jobportal?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.username=your_db_user
db.password=your_db_password
```

### 3. Build the WAR

```bash
mvn clean package
# Produces: target/job-portal-1.0-SNAPSHOT.war
```

### 4. Deploy to Tomcat

Copy the WAR into Tomcat's webapps directory:

```bash
cp target/job-portal-1.0-SNAPSHOT.war $CATALINA_HOME/webapps/jobportal.war
$CATALINA_HOME/bin/startup.sh       # or startup.bat on Windows
```

Tomcat auto-deploys the WAR. The context path will be `/jobportal`.

### 5. Open the application

```
http://localhost:8080/jobportal/
```

---

## Usage (M1 Features)

| URL | Description |
|-----|-------------|
| `/jobportal/` | Landing page |
| `/jobportal/register` | Create an account (Candidate or Employer) |
| `/jobportal/login` | Sign in |
| `/jobportal/logout` | Invalidate session and redirect to login |
| `/jobportal/dashboard` | Role-appropriate dashboard (redirects to login if unauthenticated) |

All routes except `/login`, `/register`, and the root are protected by `AuthFilter`; unauthenticated requests are redirected to `/login`.

---

## Security Notes

- Passwords are stored as **salted SHA-256** hashes (`base64(salt):hex(sha256(salt+password))`). Each user has a unique random salt generated with `SecureRandom`.
- All database queries use **`PreparedStatement`** – no string concatenation in SQL.
- Sessions are invalidated on logout.
- JSP output uses `<c:out>` (JSTL) to prevent XSS.

> **Production note:** For higher security, replace the SHA-256 scheme with a dedicated password-hashing library such as jBCrypt or Argon2.

---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

