# 👨‍💼 Employee Data System

A full-stack web application developed to simplify employee record management within an organization. The system provides secure authentication, role-based access, employee management, department management, search functionality, pagination, and data export, offering an efficient and user-friendly solution for administrative tasks.

---

## ✨ Features

- 🔐 **Admin Login** — Session-based authentication with AuthFilter protecting all routes
- 📊 **Live Dashboard** — Real-time bar chart (avg salary by dept) + donut chart (Active vs Inactive)
- 👥 **Employee CRUD** — Add, view, edit, delete employees with full server-side validation
- 🔍 **Search, Filter & Pagination** — Search by name/email, filter by department and status, 5 per page
- 🔃 **Toggle Status** — Click badge to flip Active ↔ Inactive with activity log entry
- 🏢 **Department Management** — Add, edit, delete departments with employee count guard
- 📋 **Employee Profile** — Dedicated profile page with activity log per employee and print support
- 📁 **Export CSV** — Download filtered employee list as CSV file
- 📝 **Activity Log** — Every add, edit, delete, status change is logged with timestamp
- ✅ **Server-side Validation** — Name, email (duplicate check), phone (10-digit, starts 6-9), salary, date
- 🌗 **Light / Dark Mode** — Toggle persisted via localStorage across all pages
- 👨‍💻 **About Developer** — Developer profile page linked from footer

---

## 🛠️ Tech Stack

- **Frontend**: HTML5, CSS3, JavaScript, JSP                                                                                                                                       
- **Backend**: Java, Servlets                                                                                                                        
- **Database**: JDBC, MySQL                                                    
- **Development Tools**: Eclipse IDE, Git & GitHub                                                                            
- **Server**:  Apache Tomcat                                                                                                                    

---

## 📁 Project Structure

```
Employee-Data-System/
│
├── src/
│   ├── com/eds/servlet/
│   │   ├── LoginServlet.java
│   │   ├── LogoutServlet.java
│   │   ├── AuthFilter.java
│   │   ├── DashboardServlet.java
│   │   ├── ViewEmployeeServlet.java
│   │   ├── AddEmployeeServlet.java
│   │   ├── UpdateEmployeeServlet.java
│   │   ├── DeleteEmployeeServlet.java
│   │   ├── ProfileServlet.java
│   │   ├── DepartmentServlet.java
│   │   ├── ToggleStatusServlet.java
│   │   ├── ExportCSVServlet.java
│   │   ├── ChartDataServlet.java
│   │   └── AboutServlet.java
│   ├── com/eds/dao/
│   │   ├── EmployeeDAO.java
│   │   ├── DepartmentDAO.java
│   │   ├── ActivityLogDAO.java
│   │   └── AdminDAO.java
│   ├── com/eds/model/
│   │   ├── Employee.java
│   │   ├── Department.java
│   │   ├── ActivityLog.java
│   │   └── Admin.java
│   ├── com/eds/util/
│   │   ├── DBConnection.java
│   │   └── ValidationUtil.java
│   └── com/eds/filter/
│       └── AuthFilter.java
│
├── WebContent/
│   ├── css/
│   │   └── style.css
│   ├── js/
│   │   └── main.js
│   ├── WEB-INF/
│   │   ├── lib/
│   │   │   └── mysql-connector-j-9.7.0.jar
│   │   └── web.xml
│   ├── login.jsp
│   ├── navbar.jsp
│   ├── footer.jsp
│   ├── index.jsp
│   ├── employees.jsp
│   ├── add.jsp
│   ├── edit.jsp
│   ├── profile.jsp
│   ├── departments.jsp
│   ├── about.jsp
│   └── error.jsp
│
├── database/
│   └── employee_data_system.sql
│
└── README.md
```

---

## 👤 User Roles

### Admin
- Login securely
- Add employees
- Update employee information
- Delete employee records
- Manage departments
- Search employees
- Export employee data
- View dashboard statistics

### User
- Login securely
- View employee records
- Search employees
- View personal information

---

## 📊 Modules

### Authentication Module
- Secure login system
- Session management
- Role-based authorization

### Employee Module
- Add Employee
- Update Employee
- Delete Employee
- View Employee Details

### Department Module
- Add Department
- Update Department
- Delete Department
- View Department List

### Dashboard
- Employee statistics
- Department statistics
- Quick navigation

### Search Module
- Search employees by name
- Search by department
- Instant filtering

### Export Module
- Export employee records to CSV

---

## 💻 Installation

**1. Clone the repository**

​```
git clone https://github.com/Sujal-0803/Employee-Data-System.git
​```

**2. Import the project**

- Open Eclipse IDE
- File → Import → Existing Projects into Workspace
- Browse to the cloned folder → Finish

**3. Configure Database**

- Install MySQL 8 and open MySQL Workbench
- Create a new database:
​```sql
CREATE DATABASE employee_db;
​```
- Import the SQL file from `database/employee_data_system.sql`
- Update JDBC credentials in all DAO files if your password differs:
​```java
Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/employee_db", "root", "your_password");
​```

**4. Add MySQL Connector JAR**

- Place `mysql-connector-j-9.7.0.jar` inside `WebContent/WEB-INF/lib/`
- Right click project → Build Path → Configure Build Path → Add JARs → select it

**5. Configure Apache Tomcat**

- Window → Preferences → Server → Runtime Environments → Add → Apache Tomcat 10.1
- Right click project → Run As → Run on Server → Select Tomcat 10.1 → Finish

**6. Run the application**

Open your browser and visit:

​```
http://localhost:8080/Employee_Data_System/
​```

> Demo Credentials: **admin** / **admin123**
---

## 📸 Screenshots
- Login Page

  <img width="750" height="836" alt="Screenshot 2026-07-03 125331" src="https://github.com/user-attachments/assets/83be4c88-0587-4bf9-87a1-cedba1f8075e" />

- Dashboard

  <img width="1916" height="912" alt="Screenshot 2026-07-03 123929" src="https://github.com/user-attachments/assets/62c02aeb-5b63-4fb3-8376-12917cf4b937" />
  <img width="1609" height="682" alt="Screenshot 2026-07-03 124021" src="https://github.com/user-attachments/assets/73aaa4bb-b862-41c0-a71d-03131409a4ea" />

- Employee List

  <img width="1915" height="912" alt="Screenshot 2026-07-03 015115" src="https://github.com/user-attachments/assets/24edfcca-30f8-4394-b791-e8978c7fa76e" />

- Add Employee

  <img width="1613" height="827" alt="Screenshot 2026-07-03 015141" src="https://github.com/user-attachments/assets/a0f50512-b1b3-48ef-b936-2f90701ab7d6" />

- Edit Employee

  <img width="1646" height="834" alt="Screenshot 2026-07-03 123305" src="https://github.com/user-attachments/assets/6e865a99-9ac2-40ff-b2e4-cfdcdc8fc350" />

- Department Management

  <img width="1596" height="609" alt="Screenshot 2026-07-03 123428" src="https://github.com/user-attachments/assets/2b29311b-5228-4736-a5a4-ebcc56d2c845" />


---

## 🔮 Future Enhancements

- Email Notifications
- Profile Picture Upload
- PDF Report Generation
- Password Reset
- Audit Logs
- REST API Integration
- Advanced Dashboard Analytics

---

## 📄 License

This project is developed for educational and portfolio purposes.

---

## 👨‍💻 Developer

 **Sujal Maru**

Passionate Java Full Stack Developer focused on building practical web applications and continuously learning new technologies.

- 📧 sujalmaru2004@gmail.com
- 📞 +91 79728 91795
- 📍 Pune, Maharashtra, India

---
This project is developed for educational and portfolio purposes.                                                     

> Built by **Sujal Maru** | Employee Data System 2025
