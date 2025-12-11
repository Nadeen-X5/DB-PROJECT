-- Creating DEPARTMENT Table.
CREATE TABLE DEPARTMENT(
D_number INTEGER   NOT NULL,
D_name VARCHAR(15) NOT NULL,
D_description VARCHAR(200) ,
PRIMARY KEY(D_number),
UNIQUE(D_name)
);
-- Creating EMPLOYEE Table.
CREATE TABLE EMPLOYEE (
E_id INTEGER     NOT NULL,
F_name VARCHAR(15) NOT NULL,
L_name VARCHAR(15) NOT NULL,
email VARCHAR(50)     NOT NULL,
phone VARCHAR(15)     NOT NULL,
D_number INTEGER   NOT NULL,
PRIMARY KEY(E_id),
UNIQUE(email),
UNIQUE(phone),
FOREIGN KEY(D_number) REFERENCES DEPARTMENT(D_number)
);
-- Creating CUSTOMER Table.
CREATE TABLE CUSTOMER(
E_id INTEGER NOT NULL,
organization VARCHAR(50),
PRIMARY KEY(E_id),
FOREIGN KEY(E_id) REFERENCES EMPLOYEE(E_id)   ON DELETE CASCADE
);
-- Creating SUPPORT_AGENT Table.
CREATE TABLE SUPPORT_AGENT(
E_id INTEGER NOT NULL,
role VARCHAR(20) NOT NULL,
PRIMARY KEY(E_id),
FOREIGN KEY(E_id) REFERENCES EMPLOYEE(E_id)   ON DELETE CASCADE
);
-- Creating SA_SKILLS Table. multi valued attrbute for support agent
CREATE TABLE SA_SKILLS(
SA_id INTEGER NOT NULL,
skill VARCHAR(30) NOT NULL,
PRIMARY KEY(SA_id,skill),
FOREIGN KEY(SA_id) REFERENCES SUPPORT_AGENT(E_id)   ON DELETE CASCADE
);



-- Creating TICKET Table
-- Note: R_E_id is the Requester (Employee), assigned_SA_id is the Agent.
CREATE TABLE TICKET(
    T_id NUMBER(4) PRIMARY KEY,
    T_title VARCHAR2(100) NOT NULL,
    T_description VARCHAR2(200),
    T_status VARCHAR2(20) CHECK (T_status IN ('Open', 'In Progress', 'Closed')),
    T_priority VARCHAR2(20) CHECK (T_priority IN ('Low', 'Medium', 'High', 'Critical')),
    T_create_date DATE,
    T_resolution_date DATE,
    R_E_id NUMBER NOT NULL,
    assigned_SA_id NUMBER NOT NULL,
    D_number NUMBER NOT NULL,
    CONSTRAINT fk_ticket_requester FOREIGN KEY (R_E_id) REFERENCES EMPLOYEE(E_id),
    CONSTRAINT fk_ticket_agent FOREIGN KEY (assigned_SA_id) REFERENCES SUPPORT_AGENT(E_id),
    CONSTRAINT fk_ticket_dept FOREIGN KEY (D_number) REFERENCES DEPARTMENT(D_number) ON DELETE CASCADE
);

-- Creating ATTACHMENT Table (Weak Entity)
CREATE TABLE ATTACHMENT (
    A_file_name VARCHAR2(100) NOT NULL,
    T_id NUMBER NOT NULL,
    A_file_type VARCHAR2(20),
    A_upload_date DATE,
    PRIMARY KEY (A_file_name, T_id),
    CONSTRAINT fk_attach_ticket FOREIGN KEY (T_id) REFERENCES TICKET(T_id) ON DELETE CASCADE
);

-- Creating KNOWLEDGE_BASE_ARTICLE Table
CREATE TABLE KNOWLEDGE_BASE_ARTICLE (
    KBA_id NUMBER PRIMARY KEY,
    KBA_title VARCHAR2(100) NOT NULL,
    KBA_content VARCHAR2(2000),
    KBA_category VARCHAR2(50),
    KBA_created_date DATE,
    SA_id NUMBER NOT NULL,
    CONSTRAINT fk_kba_agent FOREIGN KEY (SA_id) REFERENCES SUPPORT_AGENT(E_id)
);

-- Creating TICKET_LINKED_TO_KBA Table. The (M:N Relationship)
CREATE TABLE TICKET_LINKED_TO_KBA (
    T_id NUMBER,
    KBA_id NUMBER,
    PRIMARY KEY (T_id, KBA_id),
    CONSTRAINT fk_link_ticket FOREIGN KEY (T_id) REFERENCES TICKET(T_id) ON DELETE CASCADE,
    CONSTRAINT fk_link_kba FOREIGN KEY (KBA_id) REFERENCES KNOWLEDGE_BASE_ARTICLE(KBA_id) ON DELETE CASCADE
);
INSERT INTO DEPARTMENT VALUES (1, 'IT', 'Handles technical and help desk support');
INSERT INTO DEPARTMENT VALUES (2, 'HR', 'Human resources and employee relations');
INSERT INTO DEPARTMENT VALUES (3, 'FINANCE', 'Financial and accounting department');
INSERT INTO DEPARTMENT VALUES (4, 'Marketing', 'Marketing and communication');
INSERT INTO DEPARTMENT VALUES (5, 'Risk Management', 'Identifying and mitigating organizational risks');
INSERT INTO DEPARTMENT VALUES (6, 'Quality Assurance', 'Ensures process quality, standards compliance, and continuous improvement within the organization');

INSERT INTO EMPLOYEE VALUES (100, 'Reham',   'Mobarak',  'rere@icloud.com',   '0502000001', 1);
INSERT INTO EMPLOYEE VALUES (101, 'Nadeen',  'yahya',  'nadeen@gmail.com',  '0500000002', 1);
INSERT INTO EMPLOYEE VALUES (102, 'Mohamad',  'Fahad', 'mmm@hotmail.com',  '0500000003', 2);
INSERT INTO EMPLOYEE VALUES (103, 'Leen',  'Khaled', 'lno@icloud.com',  '0500000004', 5);
INSERT INTO EMPLOYEE VALUES (104, 'Ahmad',  'Yousef', 'Ahmad22@gmail.com',  '0500000005', 3);
INSERT INTO EMPLOYEE VALUES (105, 'Fahad', 'Khalid', 'fahad@gmail.com', '0500000006', 6);
INSERT INTO EMPLOYEE VALUES (106, 'Ali',   'Saleh',  'ali@gmail.com',   '0500000001', 4);
INSERT INTO EMPLOYEE VALUES (107, 'Sara',  'Ahmed',  'sara@icloud.com',  '0500001112', 1);
INSERT INTO EMPLOYEE VALUES (108, 'Omar',  'Nasser', 'omar@gmail.com',  '0500001113', 2);
INSERT INTO EMPLOYEE VALUES (109, 'Lama',  'Hassan', 'lama@outlook.com',  '0500001114', 3);
INSERT INTO EMPLOYEE VALUES (110, 'Reem',  'Yousef', 'reem@icloud.com',  '0500001115', 4);
INSERT INTO EMPLOYEE VALUES (111, 'Sama', 'Ali', 'soso@gmail.com', '0500001116', 6);

INSERT INTO CUSTOMER VALUES (111, 'HQ');
INSERT INTO CUSTOMER VALUES (102, 'Riyadh Branch');
INSERT INTO CUSTOMER VALUES (103, 'Dammam Branch');
INSERT INTO CUSTOMER VALUES (104, 'Jeddah Branch');
INSERT INTO CUSTOMER VALUES (105, 'HQ');
INSERT INTO CUSTOMER VALUES (107, 'Riyadh Branch');

INSERT INTO SUPPORT_AGENT VALUES (100, 'Support Engineer');
INSERT INTO SUPPORT_AGENT VALUES (101, 'Team Leader');
INSERT INTO SUPPORT_AGENT VALUES (106, 'Senior Agent');
INSERT INTO SUPPORT_AGENT VALUES (108, 'Support Engineer');
INSERT INTO SUPPORT_AGENT VALUES (109, 'Junior Agent');
INSERT INTO SUPPORT_AGENT VALUES (110, 'Senior Agent');

INSERT INTO SA_SKILLS VALUES (100, 'Network Troubleshooting');
INSERT INTO SA_SKILLS VALUES (100, 'Email Support');
INSERT INTO SA_SKILLS VALUES (101, 'Hardware Repair');
INSERT INTO SA_SKILLS VALUES (106, 'System Administration');
INSERT INTO SA_SKILLS VALUES (101, 'Database Support');
INSERT INTO SA_SKILLS VALUES (110, 'VPN Configuration');
