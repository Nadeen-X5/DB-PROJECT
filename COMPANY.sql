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
FOREIGN KEY(E_id) REFERENCES EMPLOYEE(E_id)
);
-- Creating SUPPORT_AGENT Table.
CREATE TABLE SUPPORT_AGENT(
E_id INTEGER NOT NULL,
role VARCHAR(20) NOT NULL,
PRIMARY KEY(E_id),
FOREIGN KEY(E_id) REFERENCES EMPLOYEE(E_id)
);
-- Creating SA_SKILLS Table. multi valued attrbute for support agent
CREATE TABLE SA_SKILLS(
SA_id INTEGER NOT NULL,
skill VARCHAR(30) NOT NULL,
PRIMARY KEY(SA_id,skill),
FOREIGN KEY(SA_id) REFERENCES SUPPORT_AGENT(E_id)
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
