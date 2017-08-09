CREATE TABLE users(
    userId SERIAL PRIMARY KEY,
    emailId VARCHAR(355) UNIQUE NOT NULL, 
    password VARCHAR(50) NOT NULL, 
    fullname VARCHAR(355) UNIQUE NOT NULL, 
    mobile INTEGER UNIQUE, 
    orgName VARCHAR(100), 
    designation VARCHAR(50), 
    profilepic VARCHAR,
    role VARCHAR(100), 
    joiningDate DATE default CURRENT_DATE, 
    lastLoginDate DATE default CURRENT_DATE);

   -- alter table users add 

    -- CREATE TABLE users(
    --     userId SERIAL PRIMARY KEY, 
    --     email VARCHAR(120) UNIQUE NOT NULL, 
    --     fullname VARCHAR(355),
    --     password VARCHAR(50) NOT NULL);

CREATE TABLE skills(
    skillId SERIAL PRIMARY KEY,
    skillName VARCHAR(355) UNIQUE NOT NULL, 
    totalScore INTEGER NOT NULL, 
    passScore INTEGER NOT NULL, 
    duration INTEGER, 
    numberOfQs  INTEGER,
    shortDescription VARCHAR(355), 
    longDescription TEXT, ---change to TEXT
    active VARCHAR(1), 
    level VARCHAR(20),
    creationDate DATE default CURRENT_DATE, 
    publishDate DATE);

    CREATE TABLE userSkills(
    userSkillId SERIAL PRIMARY KEY,
    userId INTEGER NOT NULL REFERENCES users(userId),
    skillId INTEGER NOT NULL REFERENCES skills(skillId),
    userScore INTEGER NOT NULL, 
    attemptNum INTEGER NOT NULL, 
    complete    VARCHAR(1),
    comments TEXT,
    timetaken INTEGER, 
    rank INTEGER, 
    testDate DATE default CURRENT_DATE);

CREATE TABLE topics(
    topicId SERIAL PRIMARY KEY,
    parentTopicId INTEGER REFERENCES topics(topicId),
    topicName VARCHAR(355) UNIQUE NOT NULL, 
    shortDescription VARCHAR(355), 
    longDescription TEXT, ---change to TEXT
    status VARCHAR(10), --change to status
    level VARCHAR(20),
    creationDate DATE default CURRENT_DATE, 
    updateDate DATE default CURRENT_DATE);

alter table topics add column parentTopicId INTEGER REFERENCES topics(topicId);


CREATE TABLE skillTopics(
    skillTopicId SERIAL PRIMARY KEY,
    skillId INTEGER NOT NULL REFERENCES skills(skillId),
    topicId INTEGER NOT NULL REFERENCES topics(topicId),
    noOfQs INTEGER NOT NULL, 
    percWeight INTEGER NOT NULL, 
    shortDescription VARCHAR(355), 
    longDescription TEXT,
    creationDate DATE default CURRENT_DATE, 
    updateDate DATE default CURRENT_DATE);

CREATE TABLE questions(
    questionId SERIAL PRIMARY KEY,
    topicId INTEGER NOT NULL REFERENCES topics(topicId),
    questionName VARCHAR(355),
    questionType VARCHAR(100) NOT NULL, 
    status VARCHAR(10),
    shortDescription VARCHAR(355), 
    longDescription TEXT,
    creationDate DATE default CURRENT_DATE, 
    updateDate DATE default CURRENT_DATE);

CREATE TABLE answers(
    answerId SERIAL PRIMARY KEY,
    questionId INTEGER NOT NULL REFERENCES questions(questionId),
    answerName VARCHAR(100),
    answerText VARCHAR(355) NOT NULL, 
    weightage INTEGER,
    correct VARCHAR(1),
    status VARCHAR(10),
    shortDescription VARCHAR(355), 
    longDescription TEXT,
    creationDate DATE default CURRENT_DATE, 
    updateDate DATE default CURRENT_DATE);