 INSERT INTO skills VALUES(
   100,
    'JavaScript', 
    100, 
    80, 
    1, 
    'A questionaire covering basic to advanced aspects of JavaScript. Check your level.', 
    'A questionaire covering basic to advanced aspects of JavaScript. Check your level.', 
    'A', 
    '1',
    current_date, 
    current_date);

 INSERT INTO skills VALUES(
   101,
    'Jquery', 
    100, 
    80, 
    1, 
    'A questionaire covering basic to advanced aspects of Jquery. Check your level.', 
    'A questionaire covering basic to advanced aspects of Jquery. Check your level.', 
    'A', 
    '1',
    current_date, 
    current_date);

     INSERT INTO skills VALUES(
   102,
    'Angular2', 
    100, 
    80, 
    1, 
    'A questionaire covering basic to advanced aspects of Angular2. Check your level.', 
    'A questionaire covering basic to advanced aspects of Angular2. Check your level.', 
    'A', 
    '1',
    current_date, 
    current_date);

       INSERT INTO skills VALUES(
   103,
    'ReactJS', 
    100, 
    80, 
    1, 
    'A questionaire covering basic to advanced aspects of ReactJS. Check your level.', 
    'A questionaire covering basic to advanced aspects of ReactJS. Check your level.', 
    'A', 
    '1',
    current_date, 
    current_date);

       INSERT INTO skills VALUES(
   104,
    'UX', 
    100, 
    80, 
    1, 
    'A questionaire covering basic to advanced aspects of UX. Check your level.', 
    'A questionaire covering basic to advanced aspects of UX. Check your level.', 
    'A', 
    '1',
    current_date, 
    current_date);


    INSERT INTO userskills VALUES(
   200,
    1, 
    100, 
    80, 
    1, 
    'Y', 
    'Test taken.', 
    40,
    99, 
    current_date);

      INSERT INTO userskills VALUES(
   201,
    1, 
    101, 
    80, 
    1, 
    'Y', 
    'Test taken.', 
    40,
    98, 
    current_date);

     INSERT INTO userskills VALUES(
   202,
    1, 
    103, 
    80, 
    1, 
    'Y', 
    'Test taken.', 
    45,
    18, 
    current_date);

insert into topics values(
  4,
'Intro to HTML',
'Introduction to the basic concepts of HTML',
'Introduction to the basic concepts of HTML',
'A',
'Beginner',
current_date,
current_date,
null
);

insert into topics values(
  5,
'Intro to CSS',
'Introduction to the basic concepts of CSS',
'Introduction to the basic concepts of CSS',
'A',
'Beginner',
current_date,
current_date,
null
);

topicId SERIAL PRIMARY KEY,
    parentTopicId INTEGER REFERENCES topics(topicId),
    topicName VARCHAR(355) UNIQUE NOT NULL, 
    shortDescription VARCHAR(355), 
    longDescription TEXT, ---change to TEXT
    status VARCHAR(10), --change to status
    level VARCHAR(20),
    creationDate DATE, 
    updateDate DATE);
   