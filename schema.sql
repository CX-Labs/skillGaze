/*Create database*/



/*SQ_Session*/

CREATE TABLE SQ_Session (
    sid character varying NOT NULL,
    sess json  NOT NULL,
    expire timestamp(6) without time zone NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    logindate timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE ONLY session
        ADD CONSTRAINT session_pk PRIMARY KEY (sid);

-- FYear

CREATE TABLE SQ_FYear (
    SQ_FYear_ID SERIAL,
    SQ_client_id INTEGER NOT NULL,
    SQ_org_id INTEGER NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    startDate date DEFAULT date(EXTRACT(YEAR FROM now()) || '-01'|| '-01'),
    endDate date DEFAULT date(EXTRACT(YEAR FROM now()) || '-12'|| '-31')
    name character varying(100) -- 'Jan-2017:Dec-2017'
);


--  PK

ALTER TABLE ONLY SQ_FYear
    ADD CONSTRAINT SQ_FYear_PK PRIMARY KEY (SQ_FYear_ID);



/*SQ_Registration*/
CREATE TABLE SQ_Registration(
    SQ_Registration_ID SERIAL,
    firstname character varying(200) NOT NULL,
    lastname character varying(200) NOT NULL,
    email character varying(150) NOT NULL,
    company character varying(200) NOT NULL,
    designation character varying(100) NOT NULL,
    phonenumber character varying(15) NOT NULL,
    isprocessed character(1) DEFAULT 'N'::bpchar NOT NULL,
    iserror character(1) DEFAULT 'N'::bpchar NOT NULL,
    error_message text,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    UNIQUE (company, email, phonenumber)
);

-- PK

ALTER TABLE ONLY SQ_Registration
    ADD CONSTRAINT registration_pk PRIMARY KEY (SQ_Registration_ID);


/*SQ_Client*/
CREATE TABLE SQ_Client(
    SQ_Client_ID SERIAL,
    name  character varying(200) NOT NULL,
    description  text,
    logo_url  character varying(400),
    firstname  character varying(200) NOT NULL,
    lastname  character varying(200) NOT NULL,
    email  character varying(150) NOT NULL,
    designation  character varying(100),
    address  character varying(1000),
    city  character varying(100),
    state  character varying(100),
    country  character varying(100),
    zipcode  character varying(40),
    phonenumber  character varying(15) NOT NULL,
    key character varying(100) NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    UNIQUE (email, name, phonenumber)
);

-- PK

ALTER TABLE ONLY SQ_Client
        ADD CONSTRAINT client_pk PRIMARY KEY (SQ_Client_ID);

/*SQ_Org*/

CREATE TABLE SQ_Org(
    SQ_Org_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL, 
    name character varying(100) NOT NULL,
    description character varying(255),
    parentOrgId INTEGER,
    key character varying(100) NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_Org
        ADD CONSTRAINT org_pk PRIMARY KEY (SQ_Org_ID);

-- FK

ALTER TABLE ONLY SQ_Org
        ADD CONSTRAINT client_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED;  

ALTER TABLE ONLY  SQ_Org
    ADD CONSTRAINT org_unique UNIQUE (name);


/*SQ_User*/

CREATE TABLE SQ_User(
    SQ_User_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_Employee_ID INTEGER NOT NULL,   
    username character varying(150) NOT NULL,
    password character varying(200),
    email character varying(150),
    key character varying(150) NOT NULL,
    isadmin character(1) DEFAULT 'N'::bpchar NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_User
        ADD CONSTRAINT user_pk PRIMARY KEY (SQ_User_ID);

-- FK

ALTER TABLE ONLY SQ_User
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_User
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;  

ALTER TABLE ONLY  SQ_User
    ADD CONSTRAINT user_unique UNIQUE (email);

/*SQ_Role*/

CREATE TABLE SQ_Role(
    SQ_Role_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(100),
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    key character varying(150) NOT NULL
    );

-- PK

ALTER TABLE ONLY SQ_Role
        ADD CONSTRAINT role_pk PRIMARY KEY (SQ_Role_ID);

-- FK

ALTER TABLE ONLY SQ_Role
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_Role
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;  


/*SQ_UserRole*/

CREATE TABLE SQ_UserRole(
    SQ_UserRole_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_User_ID INTEGER NOT NULL,
    SQ_Role_ID INTEGER NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_UserRole
        ADD CONSTRAINT userrole_pk PRIMARY KEY (SQ_UserRole_ID);

-- FK

ALTER TABLE ONLY SQ_UserRole
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_UserRole
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_UserRole
    ADD UNIQUE (SQ_User_ID, SQ_Role_ID);

/*SQ_AppViews*/

CREATE TABLE SQ_AppViews (
    SQ_AppViews_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    app_view_id INTEGER NOT NULL,
    app_view_name character varying(100) NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_AppViews
        ADD CONSTRAINT appview_pk PRIMARY KEY (SQ_AppViews_ID);

-- FK

ALTER TABLE ONLY SQ_AppViews
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_AppViews
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

/*SQ_UserViewAccess*/

CREATE TABLE SQ_UserViewAccess (
    SQ_UserViewAccess_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_Role_ID INTEGER NOT NULL,
    appviewid numeric(10,0),
    appviewname character varying(255),
    allow character(1) DEFAULT 'N'::bpchar NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_UserViewAccess
        ADD CONSTRAINT userviewaccess_pk PRIMARY KEY (SQ_UserViewAccess_ID);

-- FK

ALTER TABLE ONLY SQ_UserViewAccess
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_UserViewAccess
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_UserViewAccess
        ADD CONSTRAINT roleid_fk FOREIGN KEY (SQ_Role_ID) REFERENCES SQ_Role(SQ_Role_ID) DEFERRABLE INITIALLY DEFERRED;


/*SQ_Employee*/


CREATE TABLE SQ_Employee (
SQ_Employee_ID SERIAL,
SQ_Client_ID INTEGER NOT NULL,
SQ_Org_ID INTEGER NOT NULL,
firstName  character varying(200) NOT NULL,
lastName character varying(200) NOT NULL,
email character varying(150) NOT NULL,
employee_code INTEGER NOT NULL,
key character varying(150) NOT NULL,
IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
created timestamp without time zone DEFAULT now() NOT NULL,
createdBy INTEGER NOT NULL,
updated timestamp without time zone DEFAULT now() NOT NULL,
Updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY  SQ_Employee
        ADD CONSTRAINT employee_pk PRIMARY KEY ( SQ_Employee_ID);

-- FK

ALTER TABLE ONLY SQ_Employee
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_Employee
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

/*SQ_EmpAddress*/

CREATE TABLE SQ_EmpAddress (
SQ_EmpAddress_ID SERIAL,
SQ_Client_ID INTEGER NOT NULL,
SQ_Org_ID INTEGER NOT NULL,
SQ_Employee_ID INTEGER NOT NULL,
Details  character varying(1000) NOT NULL,
City character varying(150) NOT NULL,
State character varying(100) NOT NULL,
Country character varying(100) NOT NULL,
ZipCode character varying(100) NOT NULL,
Type character varying(4) NOT NULL,-- //  temp /perm / Same 
IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
created timestamp without time zone DEFAULT now() NOT NULL,
createdBy INTEGER NOT NULL,
updated timestamp without time zone DEFAULT now() NOT NULL,
Updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY  SQ_EmpAddress
        ADD CONSTRAINT empaddress_pk PRIMARY KEY ( SQ_EmpAddress_ID);

-- FK

ALTER TABLE ONLY SQ_EmpAddress
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_EmpAddress
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;


ALTER TABLE ONLY SQ_EmpAddress
        ADD CONSTRAINT empid_fk FOREIGN KEY (SQ_Employee_ID) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED; 


/*SQ_EmpWorkExperience*/

CREATE TABLE SQ_EmpWorkExperience (
    SQ_EmpWorkExperience_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_Employee_ID INTEGER NOT NULL,
            designation character varying(100),
    company character varying(200),
    location character varying(200),
    fromMonth character varying(40),
    fromYear character varying(5),
    toMonth character varying(40),
    toYear character varying(5),
    currentlyWorking character(1) DEFAULT 'N'::bpchar NOT NULL,
    description text,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_EmpWorkExperience
        ADD CONSTRAINT workexperience_pk PRIMARY KEY (SQ_EmpWorkExperience_ID);

-- FK

ALTER TABLE ONLY SQ_EmpWorkExperience
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_EmpWorkExperience
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_EmpWorkExperience
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (SQ_Employee_ID) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;


/*SQ_EmpSkills*/

CREATE TABLE SQ_EmpSkills (
    SQ_EmpSkill_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_Employee_ID INTEGER NOT NULL,
    primarySkill character(1) DEFAULT 'N'::bpchar NOT NULL,
    skillId INTEGER NOT NULL,
    skillName character varying(100),
    rating INTEGER NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_EmpSkills
        ADD CONSTRAINT skill_pk PRIMARY KEY (SQ_EmpSkill_ID);

-- FK

ALTER TABLE ONLY SQ_EmpSkills
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_EmpSkills
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_EmpSkills
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (SQ_Employee_ID) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_EmpSkills
        ADD CONSTRAINT rating CHECK (rating IN(1, 2, 3, 4, 5));

/*SQ_EmpEducation*/

CREATE TABLE SQ_EmpEducation (
    SQ_EmpEducation_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_Employee_ID INTEGER NOT NULL,
    school character varying(400),
    fromDateAttended numeric(5,0),
    toDateAttended numeric(5,0),
    course character varying(100),
    courseId INTEGER NOT NULL,
    description text,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_EmpEducation
        ADD CONSTRAINT education_pk PRIMARY KEY (SQ_EmpEducation_ID);

-- FK

ALTER TABLE ONLY SQ_EmpEducation
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_EmpEducation
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_EmpEducation
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (SQ_Employee_ID) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;


/*SQ_EmpInterest*/

CREATE TABLE SQ_EmpInterest (
    SQ_EmpInterest_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_Employee_ID INTEGER NOT NULL,
    area character varying(100),
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_EmpInterest
        ADD CONSTRAINT interest_pk PRIMARY KEY (SQ_EmpInterest_ID);

-- FK

ALTER TABLE ONLY SQ_EmpInterest
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_EmpInterest
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_EmpInterest
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (SQ_Employee_ID) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;


/*SQ_EmpImages*/

CREATE TABLE SQ_EmpImages(
    SQ_EmpImage_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_Employee_ID INTEGER NOT NULL,
    profileImage_url character varying(400),
    coverImage_url character varying(400),
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_EmpImages
        ADD CONSTRAINT images_pk PRIMARY KEY (SQ_EmpImage_ID);

-- FK

ALTER TABLE ONLY SQ_EmpImages
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_EmpImages
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_EmpImages
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (SQ_Employee_ID) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;


/*SQ_Designation*/

CREATE TABLE SQ_Designation (
    SQ_Designation_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    name character varying(100),
    description character varying(200),
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_Designation
        ADD CONSTRAINT designation_pk PRIMARY KEY (SQ_Designation_ID);

-- FK

ALTER TABLE ONLY SQ_Designation
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_Designation
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;


/*SQ_Department*/

CREATE TABLE SQ_Department (
    SQ_Department_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    name character varying(100),
    description character varying(200),
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_Department
        ADD CONSTRAINT ddodepartment_pk PRIMARY KEY (SQ_Department_ID);

-- FK

ALTER TABLE ONLY SQ_Department
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_Department
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;



/*SQ_Skills*/

CREATE TABLE SQ_Skills (
    SQ_Skill_ID SERIAL,
    name character varying(100),
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL
    
    
);

-- PK

ALTER TABLE ONLY SQ_Skills
        ADD CONSTRAINT ddoskill_pk PRIMARY KEY (SQ_Skill_ID);

/*SQ_EmpWorkDetails*/

CREATE TABLE SQ_EmpWorkDetails(
    SQ_EmpWorkDetails_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_Employee_ID INTEGER NOT NULL,
    reportingTo INTEGER,
    designation  INTEGER NOT NULL,
    department  INTEGER NOT NULL,
    primaryskill INTEGER NOT NULL,
    empStatus character varying(50),
    joiningDate timestamp without time zone, 
    confirmDate timestamp without time zone, 
    separatedDate timestamp without time zone, 
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_EmpWorkDetails
        ADD CONSTRAINT department_pk PRIMARY KEY (SQ_EmpWorkDetails_ID);

-- FK

ALTER TABLE ONLY SQ_EmpWorkDetails
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_EmpWorkDetails
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_EmpWorkDetails
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (SQ_Employee_ID) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_EmpWorkDetails
        ADD CONSTRAINT skillid_fk FOREIGN KEY (primaryskill) REFERENCES SQ_Skills(SQ_Skill_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE SQ_EmpWorkDetails ADD COLUMN isbillable character(1) DEFAULT 'N'::bpchar NOT NULL;


/*SQ_EmpPersonalDetails*/

CREATE TABLE SQ_EmpPersonalDetails(
    SQ_EmpPersonalDetails_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
            SQ_Employee_ID INTEGER NOT NULL,
    DOB timestamp without time zone, 
    gender character(1) NOT NULL,
    maritalStatus  character varying(50),
    anniversaryDate timestamp without time zone, 
    bloodGroup character varying(50),
    panNo character varying(50),
    aadharNo character varying(50),
    phoneNo character varying(12),
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_EmpPersonalDetails
        ADD CONSTRAINT personaldetails_pk PRIMARY KEY (SQ_EmpPersonalDetails_ID);

-- FK

ALTER TABLE ONLY SQ_EmpPersonalDetails
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_EmpPersonalDetails
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_EmpPersonalDetails
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (SQ_Employee_ID) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;



/*SQ_Task*/

CREATE TABLE SQ_Task(
    SQ_Task_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
task text NOT NULL,
task_owner INTEGER NOT NULL,
isdeleted character varying(1) NOT NULL,
iscompleted character varying(1) NOT NULL,
task_type numeric(1, 0) DEFAULT 1 NOT NULL,
task_start_date  timestamp without time zone DEFAULT now() NOT NULL,
task_end_date  timestamp without time zone DEFAULT now() NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_Task
        ADD CONSTRAINT task_pk PRIMARY KEY (SQ_Task_ID);

-- FK

ALTER TABLE ONLY SQ_Task
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_Task
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Task
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (task_owner) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;

/*SQ_Group*/

/*SQ_Group*/

CREATE TABLE SQ_Group (
    SQ_Group_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    name character varying(100),
    owner_id INTEGER NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
 );

-- PK

ALTER TABLE ONLY SQ_Group
        ADD CONSTRAINT group_pk PRIMARY KEY (SQ_Group_ID);

-- FK

ALTER TABLE ONLY SQ_Group
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_Group
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Group
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (owner_id) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;



/*SQ_Group_Member*/

CREATE TABLE SQ_Group_Member (
    SQ_Group_Member_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_Group_ID INTEGER NOT NULL,
    member_id INTEGER NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);


-- PK

ALTER TABLE ONLY SQ_Group_Member
        ADD CONSTRAINT groupmember_pk PRIMARY KEY (SQ_Group_Member_ID);

-- FK

ALTER TABLE ONLY SQ_Group_Member
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_Group_Member
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Group_Member
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (member_id) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Group_Member
        ADD CONSTRAINT group_fk FOREIGN KEY (SQ_Group_ID) REFERENCES SQ_Group(SQ_Group_ID) DEFERRABLE INITIALLY DEFERRED;



/*SQ_Posts*/

CREATE TABLE SQ_Posts (
    SQ_Posts_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    content text,
    post_type character varying(10),
    sharable character(1) DEFAULT 'N'::bpchar,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_Posts
        ADD CONSTRAINT posts_pk PRIMARY KEY (SQ_Posts_ID);

-- FK

ALTER TABLE ONLY SQ_Posts
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_Posts
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Posts
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (author_id) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;



/*SQ_Post_Tag*/

CREATE TABLE SQ_Post_Tag (
    SQ_Post_Tag_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_Posts_ID INTEGER NOT NULL,
    SQ_Group_ID INTEGER,
    tag_user_id INTEGER,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_Post_Tag
        ADD CONSTRAINT posttag_pk PRIMARY KEY (SQ_Post_Tag_ID);

-- FK

ALTER TABLE ONLY SQ_Post_Tag
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_Post_Tag
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Post_Tag
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (tag_user_id) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Post_Tag
        ADD CONSTRAINT group_fk FOREIGN KEY (SQ_Group_ID) REFERENCES SQ_Group(SQ_Group_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Post_Tag
        ADD CONSTRAINT posts_fk FOREIGN KEY (SQ_Posts_ID) REFERENCES SQ_Posts(SQ_Posts_ID) DEFERRABLE INITIALLY DEFERRED;


/*SQ_Post_Share*/

CREATE TABLE SQ_Post_Share (
    SQ_Post_Share_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_Posts_ID INTEGER NOT NULL,
    share_author_id INTEGER NOT NULL,
    share_network character varying(60),
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_Post_Share
        ADD CONSTRAINT postshare_pk PRIMARY KEY (SQ_Post_Share_ID);

-- FK

ALTER TABLE ONLY SQ_Post_Share
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_Post_Share
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Post_Share
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (share_author_id) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Post_Share
        ADD CONSTRAINT posts_fk FOREIGN KEY (SQ_Posts_ID) REFERENCES SQ_Posts(SQ_Posts_ID) DEFERRABLE INITIALLY DEFERRED;


/*SQ_Post_Like*/

CREATE TABLE SQ_Post_Like (
    SQ_Post_Like_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_Posts_ID INTEGER NOT NULL,
    like_author_id INTEGER NOT NULL,
    like_value numeric(10,0),
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);


-- PK

ALTER TABLE ONLY SQ_Post_Like
        ADD CONSTRAINT postlike_pk PRIMARY KEY (SQ_Post_Like_ID);

-- FK

ALTER TABLE ONLY SQ_Post_Like
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_Post_Like
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Post_Like
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (like_author_id) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Post_Like
        ADD CONSTRAINT posts_fk FOREIGN KEY (SQ_Posts_ID) REFERENCES SQ_Posts(SQ_Posts_ID) DEFERRABLE INITIALLY DEFERRED;


/*SQ_Post_Attachment*/

CREATE TABLE SQ_Post_Attachment (
    SQ_Post_Attachment_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_Posts_ID INTEGER NOT NULL,
    title character varying(100),
    description character varying(200),
    attachment_paths text,
    attachment_type character varying(100),
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_Post_Attachment
        ADD CONSTRAINT postattachment_pk PRIMARY KEY (SQ_Post_Attachment_ID);

-- FK

ALTER TABLE ONLY SQ_Post_Attachment
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_Post_Attachment
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Post_Attachment
        ADD CONSTRAINT posts_fk FOREIGN KEY (SQ_Posts_ID) REFERENCES SQ_Posts(SQ_Posts_ID) DEFERRABLE INITIALLY DEFERRED;


/*SQ_Post_Comment*/

CREATE TABLE SQ_Post_Comment (
    SQ_Post_Comment_ID SERIAL,
    SQ_Client_ID INTEGER NOT NULL,
    SQ_Org_ID INTEGER NOT NULL,
    SQ_Posts_ID  INTEGER NOT NULL,
    comment_author_id  INTEGER NOT NULL,
    content text,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    IsReference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL
    );

-- PK

ALTER TABLE ONLY SQ_Post_Comment
        ADD CONSTRAINT postcomment_pk PRIMARY KEY (SQ_Post_Comment_ID);

-- FK

ALTER TABLE ONLY SQ_Post_Comment
        ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED; 

ALTER TABLE ONLY SQ_Post_Comment
        ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Post_Comment
        ADD CONSTRAINT employeeid_fk FOREIGN KEY (comment_author_id) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Post_Comment
        ADD CONSTRAINT posts_fk FOREIGN KEY (SQ_Posts_ID) REFERENCES SQ_Posts(SQ_Posts_ID) DEFERRABLE INITIALLY DEFERRED;



/* SQ_Project */

CREATE TABLE SQ_Project(
    SQ_Project_ID SERIAL,
    SQ_Client_ID integer NOT NULL,
    SQ_Org_ID integer NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    name character varying(255) NOT NULL,
    search_key character varying(60) UNIQUE NOT NULL, -- Unique
    key character varying(150) NOT NULL,
    sales_representative_ID integer,
    isTrackable character(1) DEFAULT 'Y'::bpchar,
    isreference character(1) DEFAULT 'N'::bpchar NOT NULL,
    image_url character varying(1000)
);

-- PK

ALTER TABLE ONLY SQ_Project
    ADD CONSTRAINT SQ_Project_PK PRIMARY KEY (SQ_Project_ID);

-- FK

ALTER TABLE ONLY SQ_Project
    ADD CONSTRAINT SQ_project_emp_fk FOREIGN KEY (sales_representative_ID) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Project
    ADD CONSTRAINT SQ_project_clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Project
    ADD CONSTRAINT SQ_project_org_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

/* SQ_ProjectRoles */

CREATE TABLE SQ_ProjectRoles(
    SQ_ProjectRoles_ID SERIAL,
    SQ_Client_ID integer NOT NULL,
    SQ_Org_ID integer NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,    
    name character varying(255) NOT NULL,
    key character varying(150) NOT NULL,
    isreference character(1) DEFAULT 'N'::bpchar NOT NULL,
    search_key character varying(60) UNIQUE -- Unique
);

-- PK

ALTER TABLE ONLY SQ_ProjectRoles
    ADD CONSTRAINT SQ_ProjectRoles_PK PRIMARY KEY (SQ_ProjectRoles_ID);


-- SQ_ProjectRoles values

INSERT INTO SQ_ProjectRoles(SQ_Client_ID, SQ_Org_ID, IsActive, createdby, updatedby, name, key, search_key) VALUES
(0, 0, 'Y', 0, 0, 'Stake Holder', 1, 'Stake Holder'),
(0, 0, 'Y', 0, 0, 'Project Manager', 2, 'Project Manager'),
(0, 0, 'Y', 0, 0, 'Architect', 3, 'Architect'),
(0, 0, 'Y', 0, 0, 'Business Analyst', 4, 'Business Analyst'),
(0, 0, 'Y', 0, 0, 'Lead', 5, 'Lead'),
(0, 0, 'Y', 0, 0, 'Developer', 6, 'Developer'),
(0, 0, 'Y', 0, 0, 'QA Lead', 7, 'QA Lead'),
(0, 0, 'Y', 0, 0, 'Tester', 8, 'Tester'),
(0, 0, 'Y', 0, 0, 'Senior Web Designer', 9, 'Senior Web Designer'),
(0, 0, 'Y', 0, 0, 'UX Designer', 10, 'UX Designer'),
(0, 0, 'Y', 0, 0, 'Reporter', 11, 'Reporter'),
(0, 0, 'Y', 0, 0, 'Visitor', 12, 'Visitor'),
(0, 0, 'Y', 0, 0, 'HR Admin', 13, 'HR Admin'),
(0, 0, 'Y', 0, 0, 'Customer', 14, 'Customer');

/* SQ_Project_Allocation */

CREATE TABLE SQ_Project_Allocation(
    SQ_Project_Allocation_ID SERIAL,
    SQ_Client_ID integer NOT NULL,
    SQ_Org_ID integer NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,    
    SQ_Project_ID integer NOT NULL,
    SQ_Employee_ID integer NOT NULL,
    SQ_ProjectRoles_ID integer NOT NULL,
    StartDate timestamp without time zone NOT NULL,
    EndDate timestamp without time zone NOT NULL,
    key character varying(150) NOT NULL,
    isreference character(1) DEFAULT 'N'::bpchar NOT NULL,
    allocpercent numeric(3,0) NOT NULL,
    IsShadow character(1) DEFAULT 'N'::bpchar NOT NULL
);

-- PK 

ALTER TABLE ONLY SQ_Project_Allocation
    ADD CONSTRAINT SQ_Project_Allocation_PK PRIMARY KEY (SQ_Project_Allocation_ID);

-- FK

ALTER TABLE ONLY SQ_Project_Allocation
    ADD CONSTRAINT SQ_Project_Allocation_clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Project_Allocation
    ADD CONSTRAINT SQ_Project_Allocation_org_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Project_Allocation
    ADD CONSTRAINT SQ_Project_alloc_pro_id_fkey FOREIGN KEY (SQ_Project_ID) REFERENCES SQ_Project(SQ_Project_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_Project_Allocation
    ADD CONSTRAINT SQ_Project_alloc_SQ_emp_fkey FOREIGN KEY (SQ_Employee_ID) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;  

ALTER TABLE ONLY SQ_Project_Allocation
    ADD CONSTRAINT SQ_Project_alloc_role_id_fkey FOREIGN KEY (SQ_ProjectRoles_ID) REFERENCES SQ_ProjectRoles(SQ_ProjectRoles_ID) DEFERRABLE INITIALLY DEFERRED;


/* SQ_ProjectNotes */

CREATE TABLE SQ_ProjectNotes(
    SQ_ProjectNotes_ID SERIAL,
    SQ_Client_ID integer NOT NULL,
    SQ_Org_ID integer NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    SQ_Project_ID integer NOT NULL,
    Type integer NOT NULL,
    Status integer NOT NULL,
    Title character varying(255) NOT NULL,
    key character varying(150) NOT NULL,
    isreference character(1) DEFAULT 'N'::bpchar NOT NULL,
    Description text NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_ProjectNotes
    ADD CONSTRAINT SQ_ProjectNotes_PK PRIMARY KEY (SQ_ProjectNotes_ID);

-- FK

ALTER TABLE ONLY SQ_ProjectNotes
    ADD CONSTRAINT SQ_ProjectNotes_clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_ProjectNotes
    ADD CONSTRAINT SQ_ProjectNotes_org_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_ProjectNotes
    ADD CONSTRAINT SQ_ProjectNotes_c_project_fkey FOREIGN KEY (SQ_Project_ID) REFERENCES SQ_Project(SQ_Project_ID) DEFERRABLE INITIALLY DEFERRED;


/* SQ_MOM  */

CREATE TABLE SQ_MOM(
    SQ_MOM_ID SERIAL,
    SQ_Client_ID integer NOT NULL,
    SQ_Org_ID integer NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    Agenda character varying(255) NOT NULL,
    Description text NOT NULL,
    SQ_Project_ID integer,
    Is_Publish character(1) DEFAULT 'N'::bpchar NOT NULL,
    key character varying(150) NOT NULL,
    isreference character(1) DEFAULT 'N'::bpchar NOT NULL,
    Start_Time character varying(255) NOT NULL,
    End_Time character varying(255) NOT NULL,
    Start_Date timestamp without time zone NOT NULL,
    End_Date timestamp without time zone NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_MOM
    ADD CONSTRAINT SQ_MOM_PK PRIMARY KEY (SQ_MOM_ID);

-- FK

ALTER TABLE ONLY SQ_MOM
    ADD CONSTRAINT SQ_MOM_clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_MOM
    ADD CONSTRAINT SQ_MOM_org_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_MOM
    ADD CONSTRAINT SQ_MOM_c_project_fkey FOREIGN KEY (SQ_Project_ID) REFERENCES SQ_Project(SQ_Project_ID) DEFERRABLE INITIALLY DEFERRED;

/* SQ_MOM_Task */

CREATE TABLE SQ_MOM_Task(
    SQ_MOM_Task_ID SERIAL,
    SQ_Client_ID integer NOT NULL,
    SQ_Org_ID integer NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    key character varying(150) NOT NULL,
    isreference character(1) DEFAULT 'N'::bpchar NOT NULL,
    updatedby integer NOT NULL,
    SQ_MOM_ID integer NOT NULL,
    SQ_Task_ID integer NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_MOM_Task
    ADD CONSTRAINT SQ_MOM_Task_PK PRIMARY KEY (SQ_MOM_Task_ID);

-- FK

ALTER TABLE ONLY SQ_MOM_Task
    ADD CONSTRAINT SQ_MOM_Task_clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_MOM_Task
    ADD CONSTRAINT SQ_MOM_Task_org_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_MOM_Task
    ADD CONSTRAINT SQ_MOM_Task_mom_id_fkey FOREIGN KEY (SQ_MOM_ID) REFERENCES SQ_MOM(SQ_MOM_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_MOM_Task
    ADD CONSTRAINT SQ_MOM_Task_SQ_emp_fkey FOREIGN KEY (SQ_Task_ID) REFERENCES SQ_Task(SQ_Task_ID) DEFERRABLE INITIALLY DEFERRED;

/* SQ_MOM_Participant */

CREATE TABLE SQ_MOM_Participant(
    SQ_MOM_Participant_ID SERIAL,
    SQ_Client_ID integer NOT NULL,
    SQ_Org_ID integer NOT NULL,
    IsActive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    key character varying(150) NOT NULL,
    isreference character(1) DEFAULT 'N'::bpchar NOT NULL,
    updatedby integer NOT NULL,
    SQ_MOM_ID integer NOT NULL,
    SQ_Employee_ID integer NOT NULL
);

-- PK

ALTER TABLE ONLY SQ_MOM_Participant
    ADD CONSTRAINT SQ_MOM_Participant_PK PRIMARY KEY (SQ_MOM_Participant_ID);

-- FK

ALTER TABLE ONLY SQ_MOM_Participant
    ADD CONSTRAINT SQ_MOM_Participant_clientid_fk FOREIGN KEY (SQ_Client_ID) REFERENCES SQ_Client(SQ_Client_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_MOM_Participant
    ADD CONSTRAINT SQ_MOM_Participant_org_fk FOREIGN KEY (SQ_Org_ID) REFERENCES SQ_Org(SQ_Org_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_MOM_Participant
    ADD CONSTRAINT SQ_MOM_Participant_mom_id_fkey FOREIGN KEY (SQ_MOM_ID) REFERENCES SQ_MOM(SQ_MOM_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_MOM_Participant
    ADD CONSTRAINT SQ_MOM_Participant_SQ_emp_fkey FOREIGN KEY (SQ_Employee_ID) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;



-- Values for SQ_AppViews

INSERT INTO SQ_APPVIEWS (SQ_client_id, SQ_org_id, isactive, createdby, updatedby, app_view_id, app_view_name) VALUES
 (0, 0,'Y', 0, 0, 1, 'Home'),
 (0, 0,'Y', 0, 0, 2, 'Employee Dashboard'),
 (0, 0,'Y', 0, 0, 3, 'Karmascore'),
 (0, 0,'Y', 0, 0, 4, 'Karma Setup'),
 (0, 0,'Y', 0, 0, 5, 'Business Workflow'),
 (0, 0,'Y', 0, 0, 6, 'Org Chart'),
 (0, 0,'N', 0, 0, 7, 'Job Openings'),
 (0, 0,'Y', 0, 0, 8, 'Groups'),
 (0, 0,'Y', 0, 0, 9, 'Performance'),
 (0, 0,'Y', 0, 0, 10, 'Executive Dashboard'),
 (0, 0,'Y', 0, 0, 11, 'Availability Sheet'),
 (0, 0,'N', 0, 0, 12, 'Job Applicants'),
 (0, 0,'Y', 0, 0, 13, 'Projects'),
 (0, 0,'Y', 0, 0, 14, 'Finance'),
 (0, 0,'Y', 0, 0, 15, 'Sales'),
 (0, 0,'Y', 0, 0, 16, 'HR'),
 (0, 0,'Y', 0, 0, 17, 'Karma Approval'),
 (0, 0,'Y', 0, 0, 18, 'Setup'),
 (0, 0,'Y', 0, 0, 19, 'Account'),
 (0, 0,'Y', 0, 0, 20, 'Designation'),
 (0, 0,'Y', 0, 0, 21, 'Department'),
 (0, 0,'Y', 0, 0, 22, 'Role'),
 (0, 0,'Y', 0, 0, 23, 'Employee'),
 (0, 0,'Y', 0, 0, 24, 'Roles & Security'),
 (0, 0,'Y', 0, 0, 25, 'Help'),
 (0, 0,'Y', 0, 0, 26, 'Karmascore Filters'),
 (0, 0,'Y', 0, 0, 27, 'Support'),
 (0, 0,'Y', 0, 0, 28, 'Redeem'),
 (0, 0,'Y', 0, 0, 29, 'Add New Project'),
 (0, 0,'Y', 0, 0, 30, 'Project New Resource'),
 (0, 0,'Y', 0, 0, 31, 'Product Setup'),
 (0, 0,'Y', 0, 0, 32, 'Attribute'),
 (0, 0,'Y', 0, 0, 33, 'Attribute Value'),
 (0, 0,'Y', 0, 0, 34, 'Category'),
 (0, 0,'Y', 0, 0, 35, 'Product'),
 (0, 0,'Y', 0, 0, 36, 'Settings'),
 (0, 0,'Y', 0, 0, 37, 'Mom'),
 (0, 0,'Y', 0, 0, 38, 'Goals'),
 (0, 0,'Y', 0, 0, 39, 'Leave Management'),
 (0, 0,'Y', 0, 0, 45, 'Access Management'),
 (0, 0,'Y', 0, 0, 46, 'All Apps'),
 (0, 0,'Y', 0, 0, 47, 'Access Control'),
 (0, 0,'Y', 0, 0, 48, 'My Apps'),
 (0, 0,'Y', 0, 0, 49, 'Leave Settings'),
 (0, 0,'Y', 0, 0, 41, 'Leave Type'),
 (0, 0,'Y', 0, 0, 42, 'Holiday'),
 (0, 0,'Y', 0, 0, 43, 'Weekly Policy'),
 (0, 0,'Y', 0, 0, 44, 'Credit Leaves');
-- Karma setup tables


-- SQ_KarmaCategory

CREATE TABLE SQ_karmacategory (
    SQ_karmacategory_id SERIAL,
    SQ_client_id INTEGER NOT NULL,
    SQ_org_id INTEGER NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    name character varying(90) NOT NULL,
    description character varying(255)
);


-- PK 

ALTER TABLE ONLY SQ_karmacategory
    ADD CONSTRAINT SQ_karmacategory_pk PRIMARY KEY (SQ_karmacategory_id);


--  SQ_KarmaRating

CREATE TABLE SQ_karmarating (
    SQ_karmarating_id SERIAL,
    SQ_client_id INTEGER NOT NULL,
    SQ_org_id INTEGER NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    name character varying(90) NOT NULL,
    description character varying(255),
    imagepath character varying(1000)
);


-- PK 

ALTER TABLE ONLY SQ_karmarating
    ADD CONSTRAINT SQ_karmarating_id_pk PRIMARY KEY (SQ_karmarating_id);


-- SQ_KarmaRule

CREATE TABLE SQ_karmarule (
    SQ_karmarule_id SERIAL,
    SQ_client_id INTEGER NOT NULL,
    SQ_org_id INTEGER NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    name character varying(90) NOT NULL,
    description character varying(255)
);


-- PK

ALTER TABLE ONLY SQ_karmarule
    ADD CONSTRAINT SQ_karmarule_id_pk PRIMARY KEY (SQ_karmarule_id);




-- SQ_Karma

CREATE TABLE SQ_karma (
    SQ_karma_id SERIAL,
    SQ_client_id INTEGER NOT NULL,
    SQ_org_id INTEGER NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    name character varying(90) NOT NULL,
    description character varying(255),
    SQ_karmacategory_id INTEGER NOT NULL,
    SQ_wallet_id INTEGER DEFAULT 0 NOT NULL,
    isrulebased character(1) DEFAULT 'N'::bpchar,
    isratingbased character(1) DEFAULT 'N'::bpchar,
    showontimeline character(1) DEFAULT 'N'::bpchar,
    autoapproval character(1) DEFAULT 'N'::bpchar,
    isreference character(1) DEFAULT 'N'::bpchar NOT NULL,
    SQ_karmarule_id INTEGER
);

-- PK

ALTER TABLE ONLY SQ_karma
    ADD CONSTRAINT SQ_karma_pk PRIMARY KEY (SQ_karma_id);

-- FK    

ALTER TABLE ONLY SQ_karma
    ADD CONSTRAINT SQ_karma_category_fk FOREIGN KEY (SQ_karmacategory_id) REFERENCES SQ_karmacategory(SQ_karmacategory_id) DEFERRABLE INITIALLY DEFERRED;    


-- SQ_KarmaRating_Instances


CREATE TABLE SQ_karmaratings_instance (
    SQ_karmaratings_instance_id SERIAL,
    SQ_client_id INTEGER NOT NULL,
    SQ_org_id INTEGER NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    SQ_karma_id INTEGER NOT NULL,
    SQ_karmarating_id INTEGER NOT NULL,
    karma_points INTEGER,
    reward_points INTEGER
);


-- PK

ALTER TABLE ONLY SQ_karmaratings_instance
    ADD CONSTRAINT SQ_karmaratings_instance_pk PRIMARY KEY (SQ_karmaratings_instance_id);


-- FK

ALTER TABLE ONLY SQ_karmaratings_instance
    ADD CONSTRAINT SQ_karmaratings_id_fk FOREIGN KEY (SQ_karma_id) REFERENCES SQ_karma(SQ_karma_id) DEFERRABLE INITIALLY DEFERRED;


-- FK



ALTER TABLE ONLY SQ_karmaratings_instance
    ADD CONSTRAINT SQ_karmaratings_instance_fk FOREIGN KEY (SQ_karmarating_id) REFERENCES SQ_karmarating(SQ_karmarating_id) DEFERRABLE INITIALLY DEFERRED;



--  SQ_KarmaRange_Instance

CREATE TABLE SQ_karmarange_instance (
    SQ_karmarange_instnace_id SERIAL,
    SQ_client_id INTEGER NOT NULL,
    SQ_org_id INTEGER NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    SQ_karma_id INTEGER NOT NULL,
    startrange numeric,
    endrange numeric,
    factor numeric
);


-- PK

ALTER TABLE ONLY SQ_karmarange_instance
    ADD CONSTRAINT SQ_karmarange_instance_pk PRIMARY KEY (SQ_karmarange_instnace_id);


-- FK

ALTER TABLE ONLY SQ_karmarange_instance
    ADD CONSTRAINT SQ_karmarange_karma_id_fk FOREIGN KEY (SQ_karma_id) REFERENCES SQ_karma(SQ_karma_id) DEFERRABLE INITIALLY DEFERRED;



 -- SQ_Nomination table

CREATE TABLE SQ_nomination (
    SQ_nomination_id SERIAL,
    SQ_client_id INTEGER NOT NULL,
    SQ_org_id INTEGER NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    SQ_karmacategory_id INTEGER NOT NULL,
    SQ_karma_id INTEGER NOT NULL,
    comments text,
    from_employee_id INTEGER NOT NULL,
    to_employee_id INTEGER NOT NULL,
    processed character(1) DEFAULT 'N'::bpchar,
    approved character(1) DEFAULT 'N'::bpchar,
    rejected character(1) DEFAULT 'N'::bpchar,
    SQ_karmarating_id INTEGER,
    karmaunits INTEGER,
    instance_id INTEGER,
    rejectmsg character varying(1000),
    appovalcbpid INTEGER
);




-- PK

ALTER TABLE ONLY SQ_nomination
    ADD CONSTRAINT SQ_nomination_pk PRIMARY KEY (SQ_nomination_id);

-- FK

ALTER TABLE ONLY SQ_nomination
    ADD CONSTRAINT SQ_nomination_karma_id_fk FOREIGN KEY (SQ_karma_id) REFERENCES SQ_karma(SQ_karma_id) DEFERRABLE INITIALLY DEFERRED;

-- FK

ALTER TABLE ONLY SQ_nomination
    ADD CONSTRAINT SQ_nomination_karmacategory_id_fk FOREIGN KEY (SQ_karmacategory_id) REFERENCES SQ_karmacategory(SQ_karmacategory_id) DEFERRABLE INITIALLY DEFERRED;



-- SQ_Wallet


CREATE TABLE SQ_wallet (
    SQ_wallet_id SERIAL
    SQ_client_id INTEGER NOT NULL,
    SQ_org_id INTEGER NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    SQ_employee_id INTEGER NOT NULL,
    SQ_FYear_id INTEGER NOT NULL,
    points INTEGER DEFAULT 0,
    reward_points INTEGER DEFAULT 0,
    karma_points INTEGER DEFAULT 0,
    description character varying(255),
    sharable character(1) DEFAULT 'N'::bpchar
);


--  PK

ALTER TABLE ONLY SQ_wallet
    ADD CONSTRAINT SQ_wallet_pk PRIMARY KEY (SQ_wallet_id);


-- FK

ALTER TABLE ONLY SQ_wallet
    ADD CONSTRAINT SQ_wallet_employee_fkey FOREIGN KEY (SQ_Employee_id) REFERENCES SQ_Employee(SQ_Employee_ID) DEFERRABLE INITIALLY DEFERRED;


-- PK

ALTER TABLE ONLY SQ_wallet
    ADD CONSTRAINT SQ_wallet_year_fkey FOREIGN KEY ( SQ_FYear_id) REFERENCES  SQ_FYear ( SQ_FYear_id) DEFERRABLE INITIALLY DEFERRED;


-- SQ_KarmaRewardHistory


CREATE TABLE SQ_karmarewardhistory (
    SQ_karmarewardhistory_id SERIAL,
    SQ_client_id INTEGER NOT NULL,
    SQ_org_id INTEGER NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    SQ_wallet_id INTEGER NOT NULL,
    SQ_nomination_id INTEGER NOT NULL,
    reward_points numeric(10,0),
    karma_points numeric(10,0)
);

--  PK

ALTER TABLE ONLY SQ_karmarewardhistory
    ADD CONSTRAINT SQ_karmarewardhistory_PK PRIMARY KEY (SQ_karmarewardhistory_id);

-- FK

ALTER TABLE ONLY SQ_karmarewardhistory
    ADD CONSTRAINT SQ_karmarewardhistory_fk FOREIGN KEY (SQ_nomination_id) REFERENCES SQ_nomination(SQ_nomination_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SQ_karmarewardhistory_wallet_id_fk; Type: FK CONSTRAINT; Schema: adempiere; Owner: adempiere
--

ALTER TABLE ONLY SQ_karmarewardhistory
    ADD CONSTRAINT SQ_karmarewardhistory_wallet_id_fk FOREIGN KEY (SQ_wallet_id) REFERENCES SQ_wallet(SQ_wallet_id) DEFERRABLE INITIALLY DEFERRED;


-- SQ_wallethistory



CREATE TABLE SQ_wallethistory (
    SQ_wallethistory_id SERIAL,
    SQ_client_id INTEGER NOT NULL,
    SQ_org_id INTEGER NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    SQ_wallet_id INTEGER NOT NULL,
    SQ_nomination_id INTEGER,
    points numeric(10,0),
    trx_type character varying(20)
);


-- PK

ALTER TABLE ONLY SQ_wallethistory
    ADD CONSTRAINT SQ_wallethistory_pk PRIMARY KEY (SQ_wallethistory_id);


-- FK

ALTER TABLE ONLY SQ_wallethistory
    ADD CONSTRAINT SQ_wallethistory_nomination_id_fk FOREIGN KEY (SQ_nomination_id) REFERENCES SQ_nomination(SQ_nomination_id) DEFERRABLE INITIALLY DEFERRED;

-- FK

ALTER TABLE ONLY SQ_wallethistory
    ADD CONSTRAINT SQ_wallethistory_wallet_id_fk FOREIGN KEY (SQ_wallet_id) REFERENCES SQ_wallet(SQ_wallet_id) DEFERRABLE INITIALLY DEFERRED;


-- SQ_employee_history


CREATE TABLE SQ_employee_history (
    SQ_employee_history_id SERIAL,
    SQ_client_id INTEGER NOT NULL,
    SQ_org_id INTEGER NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    SQ_employee_id INTEGER NOT NULL, 
    title character varying(400),
    details text,
    tablename character varying(200),
    event character varying(200),
    recordId INTEGER NOT NULL,
    SQ_Karma_ID INTEGER
);



ALTER TABLE ONLY SQ_employee_history
    ADD CONSTRAINT SQ_employee_history_PK  PRIMARY KEY (SQ_employee_history_id);


--
-- PostgreSQL database dump
--


CREATE TABLE SQ_productattribute (
    SQ_productattribute_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(10) NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL
);


ALTER TABLE adempiere.SQ_productattribute OWNER TO adempiere;


ALTER TABLE ONLY SQ_productattribute
    ADD CONSTRAINT productattribute_pk PRIMARY KEY (SQ_productattribute_id);



--
-- PostgreSQL database dump
--


CREATE TABLE SQ_productattribute_values (
    SQ_productattribute_value_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    value character varying(1000) NOT NULL,
    code character varying(10) NOT NULL,
    SQ_productattribute_id integer NOT NULL
);


ALTER TABLE adempiere.SQ_productattribute_values OWNER TO adempiere;

ALTER TABLE ONLY SQ_productattribute_values
    ADD CONSTRAINT SQ_productattribute_values_pk PRIMARY KEY (SQ_productattribute_value_id);

ALTER TABLE ONLY SQ_productattribute_values
    ADD CONSTRAINT SQ_productattribute_values_fk FOREIGN KEY (SQ_productattribute_id) REFERENCES SQ_productattribute(SQ_productattribute_id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump
--


CREATE TABLE SQ_productcategory (
    SQ_productcategory_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(10) NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL
);


ALTER TABLE adempiere.SQ_productcategory OWNER TO adempiere;

ALTER TABLE ONLY SQ_productcategory
    ADD CONSTRAINT product_category_pk PRIMARY KEY (SQ_productcategory_id);




--
-- PostgreSQL database dump
--

CREATE TABLE SQ_product (
    SQ_product_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(10) NOT NULL,
    price integer NOT NULL,
    quantity integer NOT NULL,
    SQ_productcategory_id integer NOT NULL
);


ALTER TABLE adempiere.SQ_product OWNER TO adempiere;

ALTER TABLE ONLY SQ_product
    ADD CONSTRAINT product_pk PRIMARY KEY (SQ_product_id);

ALTER TABLE ONLY SQ_product
    ADD CONSTRAINT product_category_fk FOREIGN KEY (SQ_productcategory_id) REFERENCES SQ_productcategory(SQ_productcategory_id) DEFERRABLE INITIALLY DEFERRED;




--
-- PostgreSQL database dump
--


CREATE TABLE SQ_productattribute_instance (
    SQ_productattribute_instance_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    quantity integer NOT NULL,
    SQ_product_id integer NOT NULL
);


ALTER TABLE adempiere.SQ_productattribute_instance OWNER TO adempiere;

ALTER TABLE ONLY SQ_productattribute_instance
    ADD CONSTRAINT SQ_productattribute_instance_pk PRIMARY KEY (SQ_productattribute_instance_id);

ALTER TABLE ONLY SQ_productattribute_instance
    ADD CONSTRAINT product_fk FOREIGN KEY (SQ_product_id) REFERENCES SQ_product(SQ_product_id) DEFERRABLE INITIALLY DEFERRED;




--
-- PostgreSQL database dump
--

CREATE TABLE SQ_productattributes_set (
    SQ_productattributes_set_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    SQ_product_id integer NOT NULL,
    SQ_productattribute_id integer NOT NULL,
    SQ_productattribute_value_id integer NOT NULL,
    SQ_productattribute_instance_id integer NOT NULL
);


ALTER TABLE adempiere.SQ_productattributes_set OWNER TO adempiere;

ALTER TABLE ONLY SQ_productattributes_set
    ADD CONSTRAINT product_attributeset_pk PRIMARY KEY (SQ_productattributes_set_id);

ALTER TABLE ONLY SQ_productattributes_set
    ADD CONSTRAINT SQ_productattribute_instance_fk FOREIGN KEY (SQ_productattribute_instance_id) REFERENCES SQ_productattribute_instance(SQ_productattribute_instance_id) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_productattributes_set
    ADD CONSTRAINT product_attribute_fk FOREIGN KEY (SQ_productattribute_id) REFERENCES SQ_productattribute(SQ_productattribute_id) DEFERRABLE INITIALLY DEFERRED;


ALTER TABLE ONLY SQ_productattributes_set
    ADD CONSTRAINT product_attributevalues_fk FOREIGN KEY (SQ_productattribute_value_id) REFERENCES SQ_productattribute_values(SQ_productattribute_value_id) DEFERRABLE INITIALLY DEFERRED;


ALTER TABLE ONLY SQ_productattributes_set
    ADD CONSTRAINT product_fk FOREIGN KEY (SQ_product_id) REFERENCES SQ_product(SQ_product_id) DEFERRABLE INITIALLY DEFERRED;



--
-- PostgreSQL database dump
--


CREATE TABLE SQ_product_images (
    SQ_product_images_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    imagepath character varying(2000) NOT NULL,
    isdefault character(1) DEFAULT 'Y'::bpchar NOT NULL,
    SQ_product_id integer NOT NULL
);


ALTER TABLE adempiere.SQ_product_images OWNER TO adempiere;


ALTER TABLE ONLY SQ_product_images
    ADD CONSTRAINT product_images_pk PRIMARY KEY (SQ_product_images_id);


ALTER TABLE ONLY SQ_product_images
    ADD CONSTRAINT product_images_fk FOREIGN KEY (SQ_product_id) REFERENCES SQ_product(SQ_product_id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump
--
CREATE TABLE SQ_order_status (
    SQ_orderstatus_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    name character varying(100) NOT NULL,
    status character varying(100) NOT NULL
);


ALTER TABLE adempiere.SQ_order_status OWNER TO adempiere;

ALTER TABLE ONLY SQ_order_status
    ADD CONSTRAINT SQ_order_status_pk PRIMARY KEY (SQ_orderstatus_id);

INSERT INTO SQ_order_status (SQ_client_id, SQ_org_id, createdby, updatedby, name, status) VALUES
 ( 11, 1000001, 1001190, 1001190, 'pending', 'pr'),
 (11, 1000001, 1001190, 1001190, 'completed', 'cmp'),
 (11, 1000001, 1001190, 1001190, 'cancelled', 'cl');



 

CREATE TABLE SQ_product_order (
    SQ_product_order_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    description character varying(1000) NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    totalprice integer NOT NULL,
    SQ_orderstatus_id integer NOT NULL,
    processed character(1) DEFAULT 'N'::bpchar NOT NULL,
    isapproved character(1) DEFAULT 'Y'::bpchar NOT NULL,
    SQ_employee_id integer NOT NULL
);


ALTER TABLE adempiere.SQ_product_order OWNER TO adempiere;

ALTER TABLE ONLY SQ_product_order
    ADD CONSTRAINT product_order_pk PRIMARY KEY (SQ_product_order_id);

ALTER TABLE ONLY SQ_product_order
    ADD CONSTRAINT product_emp_id_fk FOREIGN KEY (SQ_employee_id) REFERENCES SQ_employee(SQ_employee_id) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_product_order
    ADD CONSTRAINT product_order_status_fk FOREIGN KEY (SQ_orderstatus_id) REFERENCES SQ_order_status(SQ_orderstatus_id) DEFERRABLE INITIALLY DEFERRED;


CREATE TABLE SQ_product_order_items (
    SQ_product_order_items_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    quantity integer NOT NULL,
    unitprice numeric(10,2) NOT NULL,
    lineprice numeric(10,2) NOT NULL,
    SQ_product_order_id integer NOT NULL,
    processed character(1) DEFAULT 'N'::bpchar NOT NULL,
    SQ_productattribute_id integer,
    SQ_productattributevalue_id numeric(10,2),
    SQ_product_id integer NOT NULL
);


ALTER TABLE adempiere.SQ_product_order_items OWNER TO adempiere;

ALTER TABLE ONLY SQ_product_order_items
    ADD CONSTRAINT SQ_product_order_items_pk PRIMARY KEY (SQ_product_order_items_id);

ALTER TABLE ONLY SQ_product_order_items
    ADD CONSTRAINT SQ_product_order_fk FOREIGN KEY (SQ_product_order_id) REFERENCES SQ_product_order(SQ_product_order_id) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_product_order_items
    ADD CONSTRAINT product_fk FOREIGN KEY (SQ_product_id) REFERENCES SQ_product(SQ_product_id) DEFERRABLE INITIALLY DEFERRED;


CREATE TABLE SQ_redeemhistory (
    SQ_redeemhistory_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    SQ_wallet_id integer NOT NULL,
    SQ_product_order_id integer NOT NULL,
    redeem_points integer NOT NULL
);


ALTER TABLE ONLY SQ_redeemhistory
    ADD CONSTRAINT SQ_redeemhistory_pk PRIMARY KEY (SQ_redeemhistory_id);

ALTER TABLE ONLY SQ_redeemhistory
    ADD CONSTRAINT SQ_redeemhistory_order_id_fk FOREIGN KEY (SQ_product_order_id) REFERENCES SQ_product_order(SQ_product_order_id) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_redeemhistory
    ADD CONSTRAINT SQ_redeemhistory_wallet_id_fk FOREIGN KEY (SQ_wallet_id) REFERENCES SQ_wallet(SQ_wallet_id) DEFERRABLE INITIALLY DEFERRED;


-- SQ_url_metadata 
CREATE TABLE SQ_url_metadata (
    SQ_url_metadata_id SERIAL,
    SQ_posts_id integer NOT NULL,
    link text NOT NULL,
    metadata text NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedcount integer DEFAULT 0
);

ALTER TABLE ONLY SQ_url_metadata
    ADD CONSTRAINT SQ_url_metadata_pk PRIMARY KEY (SQ_url_metadata_id);


ALTER TABLE ONLY SQ_url_metadata
    ADD CONSTRAINT SQ_url_metadata_post_id_fk FOREIGN KEY (SQ_posts_id) REFERENCES SQ_posts(SQ_posts_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SQ_employeegoal; Type: TABLE; Schema: adempiere; Owner: adempiere; Tablespace: 
--

CREATE TABLE SQ_employeegoal (
    SQ_employeegoal_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    name character varying(1000) NOT NULL,
    parentgoalid integer,
    targetdate timestamp without time zone NOT NULL,
    measurementcriteria text NOT NULL,
    SQ_goalstatus_id integer NOT NULL,
    SQ_employee_id integer NOT NULL,
    karmapoints integer
);

--
-- Name: SQ_employeegoal_pk; Type: CONSTRAINT; Schema: adempiere; Owner: adempiere; Tablespace: 
--

ALTER TABLE ONLY SQ_employeegoal
    ADD CONSTRAINT SQ_employeegoal_pk PRIMARY KEY (SQ_employeegoal_id);


--
-- Name: SQ_employeegoal_SQ_employee_fkey; Type: FK CONSTRAINT; Schema: adempiere; Owner: adempiere
--

ALTER TABLE ONLY SQ_employeegoal
    ADD CONSTRAINT SQ_employeegoal_SQ_employee_fkey FOREIGN KEY (SQ_employee_id) REFERENCES SQ_employee(SQ_employee_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SQ_goalnote; Type: TABLE; Schema: adempiere; Owner: adempiere; Tablespace: 
--

CREATE TABLE SQ_goalnote (
    SQ_goalnote_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    details text NOT NULL,
    notetype text NOT NULL,
    SQ_employeegoal_id integer NOT NULL
);

--
-- Name: SQ_goalnote_pk; Type: CONSTRAINT; Schema: adempiere; Owner: adempiere; Tablespace: 
--

ALTER TABLE ONLY SQ_goalnote
    ADD CONSTRAINT SQ_goalnote_pk PRIMARY KEY (SQ_goalnote_id);


--
-- Name: SQ_goalnote_SQ_employeegoal_fkey; Type: FK CONSTRAINT; Schema: adempiere; Owner: adempiere
--

ALTER TABLE ONLY SQ_goalnote
    ADD CONSTRAINT SQ_goalnote_SQ_employeegoal_fkey FOREIGN KEY (SQ_employeegoal_id) REFERENCES SQ_employeegoal(SQ_employeegoal_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SQ_goalrating; Type: TABLE; Schema: adempiere; Owner: adempiere; Tablespace: 
--

CREATE TABLE SQ_goalrating (
    SQ_goalrating_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    SQ_employeegoal_id integer NOT NULL,
    selfcomment text,
    managercomment text,
    karmapoints integer,
    SQ_nomination_id integer,
    ratingtext character varying(60)
);

--
-- Name: SQ_goalrating_pk; Type: CONSTRAINT; Schema: adempiere; Owner: adempiere; Tablespace: 
--

ALTER TABLE ONLY SQ_goalrating
    ADD CONSTRAINT SQ_goalrating_pk PRIMARY KEY (SQ_goalrating_id);


--
-- Name: SQ_SQ_nomination_id_fkey; Type: FK CONSTRAINT; Schema: adempiere; Owner: adempiere
--

ALTER TABLE ONLY SQ_goalrating
    ADD CONSTRAINT SQ_SQ_nomination_id_fkey FOREIGN KEY (SQ_nomination_id) REFERENCES SQ_nomination(SQ_nomination_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SQ_goalrating_SQ_employeegoal_fkey; Type: FK CONSTRAINT; Schema: adempiere; Owner: adempiere
--

ALTER TABLE ONLY SQ_goalrating
    ADD CONSTRAINT SQ_goalrating_SQ_employeegoal_fkey FOREIGN KEY (SQ_employeegoal_id) REFERENCES SQ_employeegoal(SQ_employeegoal_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SQ_goalshare; Type: TABLE; Schema: adempiere; Owner: adempiere; Tablespace: 
--

CREATE TABLE SQ_goalshare (
    SQ_goalshare_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    SQ_employeegoal_id integer NOT NULL,
    sharewith_SQ_employee_id integer NOT NULL
);

--
-- Name: SQ_goalshare_pk; Type: CONSTRAINT; Schema: adempiere; Owner: adempiere; Tablespace: 
--

ALTER TABLE ONLY SQ_goalshare
    ADD CONSTRAINT SQ_goalshare_pk PRIMARY KEY (SQ_goalshare_id);


--
-- Name: SQ_goalshare_SQ_employeegoal_fkey; Type: FK CONSTRAINT; Schema: adempiere; Owner: adempiere
--

ALTER TABLE ONLY SQ_goalshare
    ADD CONSTRAINT SQ_goalshare_SQ_employeegoal_fkey FOREIGN KEY (SQ_employeegoal_id) REFERENCES SQ_employeegoal(SQ_employeegoal_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SQ_goalshare_sharewith_SQ_employee_fkey; Type: FK CONSTRAINT; Schema: adempiere; Owner: adempiere
--

ALTER TABLE ONLY SQ_goalshare
    ADD CONSTRAINT SQ_goalshare_sharewith_SQ_employee_fkey FOREIGN KEY (sharewith_SQ_employee_id) REFERENCES SQ_employee(SQ_employee_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: SQ_goalstatus; Type: TABLE; Schema: adempiere; Owner: adempiere; Tablespace: 
--

CREATE TABLE SQ_goalstatus (
    SQ_goalstatus_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    name character varying(255) NOT NULL,
    key character varying(60) NOT NULL
);

--
-- Name: SQ_goalstatus_pk; Type: CONSTRAINT; Schema: adempiere; Owner: adempiere; Tablespace: 
--

ALTER TABLE ONLY SQ_goalstatus
    ADD CONSTRAINT SQ_goalstatus_pk PRIMARY KEY (SQ_goalstatus_id);


--
-- Data for Name: SQ_goalstatus; Type: TABLE DATA; Schema: adempiere; Owner: adempiere
-- Insert values for SQ_goalstatus table

INSERT INTO SQ_goalstatus VALUES (1, 0, 0, 0, 0, 'Draft', 'Draft');
INSERT INTO SQ_goalstatus VALUES (2, 0, 0, 0, 0, 'Pending', 'Pending');
INSERT INTO SQ_goalstatus VALUES (3, 0, 0, 0, 0, 'In Progress', 'In Progress');
INSERT INTO SQ_goalstatus VALUES (4, 0, 0, 0, 0, 'Completed', 'Completed');
INSERT INTO SQ_goalstatus VALUES (5, 0, 0, 0, 0, 'Achieved', 'Achieved');
INSERT INTO SQ_goalstatus VALUES (6, 0, 0, 0, 0, 'Re-Open', 'reopen');
INSERT INTO SQ_goalstatus VALUES (7, 0, 0, 0, 0, 'Cancel', 'cancel');

-- SQ_client_setting

CREATE TABLE SQ_client_setting (
    SQ_client_setting_id SERIAL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    roleIds character varying(200) NOT NULL,
    setting_id numeric(1,0) NOT NUll
);


ALTER TABLE ONLY SQ_client_setting
    ADD CONSTRAINT SQ_client_setting_pk PRIMARY KEY (SQ_client_setting_id);

ALTER TABLE ONLY SQ_client_setting
    ADD CONSTRAINT clientid_fk FOREIGN KEY (SQ_client_id) REFERENCES SQ_client(SQ_client_id) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_client_setting
    ADD CONSTRAINT orgid_fk FOREIGN KEY (SQ_org_id) REFERENCES SQ_org(SQ_org_id) DEFERRABLE INITIALLY DEFERRED;

-- SQ_emailtemplate

CREATE TABLE SQ_emailtemplate (
    SQ_emailtemplate_id SERIAL,
    title text NOT NULL,
    body text NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    isreference character(1) DEFAULT 'N'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE ONLY SQ_emailtemplate
    ADD CONSTRAINT emailtemplate_pk PRIMARY KEY (SQ_emailtemplate_id);

--SQ_emailtemplate data

INSERT INTO SQ_emailtemplate(title, body) VALUES 
('We are missing you', './templates/Template1.hbs'),
('Your wallet is expire soon', './templates/Template2.hbs'),
('Good to see you contributing more', './templates/Template6.hbs'),
('You seem to be tough', './templates/Template3.hbs'),
('Less karmascore points  ', './templates/Template4.hbs'),
('Top 10 KarmaScores', './templates/Template5.hbs'),
('Registration', './templates/Template7.hbs'),
('Nomination', './templates/Template8.hbs');

-- SQ_WalletSettings

CREATE TABLE SQ_WalletSettings (
    SQ_WalletSettings_ID SERIAL,
    SQ_client_id INTEGER NOT NULL,
    SQ_org_id INTEGER NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby INTEGER NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby INTEGER NOT NULL,
    default_points INTEGER DEFAULT 500 NOT NULL,
    emp_percent numeric(3,0) DEFAULT 50 NOT NULL,
    manager_percent numeric(3,0) DEFAULT 40 NOT NULL,
    manager_manager_percent numeric(3,0) DEFAULT 10 NOT NULL
);

--  PK

ALTER TABLE ONLY SQ_WalletSettings
    ADD CONSTRAINT SQ_WalletSettings_PK PRIMARY KEY (SQ_WalletSettings_ID);

--SQ_walletsettings data

INSERT INTO SQ_walletsettings(SQ_client_id, SQ_org_id, createdby, updatedby) VALUES 
(0, 0, 0, 0);


--SQ_KarmaAccess

CREATE TABLE SQ_karmaaccess (
    SQ_karmaaccess_id integer NOT NULL,
    SQ_client_id integer NOT NULL,
    SQ_org_id integer NOT NULL,
    isactive character(1) DEFAULT 'Y'::bpchar,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdby integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedby integer NOT NULL,
    SQ_karma_id integer NOT NULL,
    SQ_employee_id text,
    SQ_role_id text
);

ALTER TABLE ONLY SQ_KarmaAccess
    ADD CONSTRAINT SQ_KarmaAccess_pk PRIMARY KEY (SQ_KarmaAccess_ID);

ALTER TABLE ONLY SQ_KarmaAccess
    ADD CONSTRAINT karmaid_fk FOREIGN KEY (SQ_karma_id) REFERENCES SQ_karma(SQ_karma_id) DEFERRABLE INITIALLY DEFERRED;


    CREATE TABLE SQ_AccessApp (
    SQ_AccessApp_ID SERIAL,
    SQ_Client_Id integer,
    SQ_Org_Id integer,
    IsActive character(1) DEFAULT 'Y'::bpchar,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedBy integer NOT NULL,
    name character varying(150) NOT NULL,
    imageUrl character varying(255) NOT NULL,
    allowedUserCount integer NOT NULL,
    activeUserCount integer NOT NULL,
    clientName character(255) NOT NULL,
    description character varying(255) NOT NULL,
    ownerId integer NOT NULL
);

-- PK 
ALTER TABLE ONLY SQ_AccessApp
    ADD CONSTRAINT SQ_accessapp_pkey PRIMARY KEY (SQ_AccessApp_ID);

ALTER TABLE ONLY SQ_AccessApp
    ADD CONSTRAINT SQ_app_ownerId_fkey FOREIGN KEY (ownerId) REFERENCES SQ_employee(SQ_employee_id) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_AccessApp
    ADD CONSTRAINT SQ_AccessApp_name_key UNIQUE (name);



----------------------------------------------------------------------------------------
CREATE TABLE SQ_AccessApp_Status (
    SQ_AccessApp_Status_ID serial,
    SQ_Client_Id integer NOT NULL,
    SQ_Org_Id integer NOT NULL,
    isActive character(1) DEFAULT 'Y'::bpchar,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedBy integer NOT NULL,
    name character varying(255),
    key character varying(255),
    isReference character(1) DEFAULT 'N'::bpchar

);

-- PK 
ALTER TABLE ONLY SQ_AccessApp_Status
    ADD CONSTRAINT SQ_AccessAppstatus_pkey PRIMARY KEY   (SQ_AccessApp_Status_ID);

    ----------------------------------------------------------------------------------------
CREATE TABLE SQ_AccessApp_Request (
    SQ_AccessApp_Request_ID serial,
    SQ_Employee_ID integer NOT NULL,
    SQ_AccessApp_ID integer NOT NULL,
    SQ_Client_Id integer NOT NULL,
    SQ_Org_Id integer NOT NULL,
    isActive character(1) DEFAULT 'Y'::bpchar,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedBy integer NOT NULL,
    fromDate timestamp without time zone,
    endDate timestamp without time zone,
    SQ_AccessApp_Status_ID integer NOT NULL,
    requestReason character varying(255),
    rejectReason character varying(255)
);


ALTER TABLE ONLY SQ_AccessApp_Request
    ADD CONSTRAINT SQ_AccessAppRequest_pkey PRIMARY KEY   (SQ_AccessApp_Request_ID);

ALTER TABLE ONLY SQ_AccessApp_Request
    ADD CONSTRAINT SQ_AccessAppRequest_user_app_id_fkey FOREIGN KEY (SQ_AccessApp_ID) REFERENCES SQ_AccessApp(SQ_AccessApp_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_AccessApp_Request
    ADD CONSTRAINT SQ_AccessAppRequest_Employee_ID_fkey FOREIGN KEY (SQ_Employee_ID) REFERENCES SQ_employee(SQ_employee_id) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_AccessApp_Request
    ADD CONSTRAINT SQ_AccessApp_Request_SQ_AccessApp_Status_ID_fkey FOREIGN KEY  (SQ_AccessApp_Status_ID) REFERENCES SQ_AccessApp_Status(SQ_AccessApp_Status_ID) DEFERRABLE INITIALLY DEFERRED;

---------------------------------------------------------------------------------------


CREATE TABLE SQ_AppAccessHistory (
    SQ_AppAccessHistory_ID SERIAL,
    SQ_AppAccess_ID INTEGER NOT NULL,
    SQ_AppAccessRequest_ID INTEGER NOT NULL,
    SQ_AppStatus_ID INTEGER NOT NULL,
    SQ_Client_Id integer NOT NULL,
    SQ_Org_Id integer NOT NULL,
    isActive character(1) DEFAULT 'Y'::bpchar,
    created timestamp without time zone DEFAULT now() NOT NULL,
    createdBy integer NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    updatedBy integer NOT NULL,
    request_start_date timestamp without time zone,
    request_end_date timestamp without time zone
);
ALTER TABLE ONLY SQ_AppAccessHistory
    ADD CONSTRAINT SQ_AppAccessHistory_pkey PRIMARY KEY   (SQ_AppAccessHistory_ID);

ALTER TABLE ONLY SQ_AppAccessHistory
    ADD CONSTRAINT SQ_AppAccessHistory_SQ_AppAccess_ID_fkey FOREIGN KEY  (SQ_AppAccess_ID) REFERENCES SQ_AccessApp(SQ_AccessApp_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_AppAccessHistory
    ADD CONSTRAINT SQ_AppAccessHistory_SQ_AppAccessRequest_ID_fkey FOREIGN KEY  (SQ_AppAccessRequest_ID) REFERENCES SQ_AccessApp_Request(SQ_AccessApp_Request_ID) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY SQ_AppAccessHistory
    ADD CONSTRAINT SQ_AppAccessHistory_SQ_AppStatus_ID_fkey FOREIGN KEY  (SQ_AppStatus_ID) REFERENCES SQ_AccessApp_Status(SQ_AccessApp_Status_ID) DEFERRABLE INITIALLY DEFERRED;


    