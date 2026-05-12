# NGO_Website
A full-stack web application for managing NGO operations — including donors, volunteers, and admins — with role-based access control.

Tech: 
PHP 
· MySQL (PDO) 
· Bootstrap 
· Sessions

Key Features:

🔐 Multi-role authentication system (Admin, Donor, Volunteer)
💰 Donor portal: donate money or physical items, view transaction history, and manage profile
🙋 Volunteer portal: log and manage assigned tasks
🛡️ Admin dashboard: manage users, oversee donations, and handle volunteer tasks
🗃️ Relational MySQL database with foreign key constraints and city-based records seeded for British Columbia, Canada
📋 Session-based security with access control on all protected pages

Highlights:

Clean role-based routing — users are automatically directed to their dashboard on login
Full CRUD operations across all user roles
Responsive Bootstrap UI
