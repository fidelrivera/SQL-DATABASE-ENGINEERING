
-- Last modification date: 2022-11-19 07:11:37.095

-- tables
-- Table: client_contacts
--DROP TABLES--

ALTER TABLE client_contacts DROP CONSTRAINT client_contacts_clients;
ALTER TABLE employees DROP CONSTRAINT employees_client_contacts;
ALTER TABLE project_tasks DROP CONSTRAINT project_tasks_employees;
ALTER TABLE project_tasks DROP CONSTRAINT project_tasks_projects;
ALTER TABLE project_tasks DROP CONSTRAINT project_tasks_skills;

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'clients')
DROP TABLE clients
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'client_contacts')
DROP TABLE client_contacts
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'employees')
DROP TABLE employees
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'project_tasks')
DROP TABLE project_tasks
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'projects')
DROP TABLE projects
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'skills')
DROP TABLE skills

CREATE TABLE client_contacts (
    client_id int  NOT NULL,
    client_name varchar(50)  NOT NULL,
    client_phone int  NOT NULL,
    client_company_name varchar(50)  NOT NULL,
    CONSTRAINT client_contacts_pk PRIMARY KEY  (client_id)
);

-- Table: clients
CREATE TABLE clients (
    company_name varchar(50)  NOT NULL,
    company_email varchar(50)  NOT NULL,
    company_phone int  NOT NULL,
    CONSTRAINT clients_pk PRIMARY KEY  (company_name)
);

-- Table: employees
CREATE TABLE employees (
    emp_id int  NOT NULL,
    emp_name varchar(50)  NOT NULL,
    emp_title varchar(50)  NOT NULL,
    emp_cell bigint  NOT NULL,
    emp_hourlywage money  NOT NULL,
    emp_client_contacts int  NOT NULL,
    CONSTRAINT employees_pk PRIMARY KEY  (emp_id)
);

-- Table: project_tasks
CREATE TABLE project_tasks (
    task_name varchar(50)  NOT NULL,
    task_desc varchar(240)  NOT NULL,
    emp_id varchar(50)  NOT NULL,
    task_est_hours int  NOT NULL,
    task_hours int  NOT NULL,
    task_est date  NOT NULL,
    task_end date  NOT NULL,
    task_status varchar(10)  NOT NULL,
    task_priority varchar(50)  NOT NULL,
    task_skills varchar(50)  NOT NULL,
    task_employee int  NOT NULL,
    task_project int  NOT NULL,
    CONSTRAINT project_tasks_pk PRIMARY KEY  (task_name)
);

-- Table: projects
CREATE TABLE projects (
    proj_id int  NOT NULL,
    proj_name varchar(50)  NOT NULL,
    proj_desc varchar(50)  NOT NULL,
    proj_est date  NOT NULL,
    proj_hours int  NOT NULL,
    CONSTRAINT projects_pk PRIMARY KEY  (proj_id)
);

-- Table: skills
CREATE TABLE skills (
    skills varchar(50)  NOT NULL,
    CONSTRAINT skills_pk PRIMARY KEY  (skills)
);

-- foreign keys
-- Reference: client_contacts_clients (table: client_contacts)
ALTER TABLE client_contacts ADD CONSTRAINT client_contacts_clients
    FOREIGN KEY (client_company_name)
    REFERENCES clients (company_name);

-- Reference: employees_client_contacts (table: employees)
ALTER TABLE employees ADD CONSTRAINT employees_client_contacts
    FOREIGN KEY (emp_client_contacts)
    REFERENCES client_contacts (client_id);

-- Reference: project_tasks_employees (table: project_tasks)
ALTER TABLE project_tasks ADD CONSTRAINT project_tasks_employees
    FOREIGN KEY (task_employee)
    REFERENCES employees (emp_id);

-- Reference: project_tasks_projects (table: project_tasks)
ALTER TABLE project_tasks ADD CONSTRAINT project_tasks_projects
    FOREIGN KEY (task_project)
    REFERENCES projects (proj_id);

-- Reference: project_tasks_skills (table: project_tasks)
ALTER TABLE project_tasks ADD CONSTRAINT project_tasks_skills
    FOREIGN KEY (task_skills)
    REFERENCES skills (skills);

INSERT INTO skills
VALUES ('SQL'),('R'),('Database Administration'),('Project Management'),('UX/UI Design'),
('Client-Facing Personality'),('AI/Machine Learning'),('Security'),('Data/Statistical Analysis'),('Certifications');
select *, SYSTEM_USER from skills

INSERT INTO projects
VALUES ('384345837','Reopen Kimmel','Reopening food court','2022-11-19','800')
select *, SYSTEM_USER from projects

INSERT INTO clients
VALUES ('Apple','timapple@AirPower.com','2128112000')
select *, SYSTEM_USER from clients

INSERT INTO client_contacts
VALUES ('39489','Jony Ive','2120081222','Apple')
select *, SYSTEM_USER from client_contacts

INSERT INTO employees
VALUES ('12345','Tim Cook','Janitor','2104113209','21.50','39489')
select *, SYSTEM_USER from employees

INSERT INTO project_tasks
VALUES ('COVID Center Teardown','Moving COVID supplies out of Kimmel','21340','55','48','2022-11-19','2022-11-28','Complete',
'Standard','Project Management','12345','384345837')
select *, SYSTEM_USER from project_tasks

-- End of file.

