const express = require('express');
const router = express.Router();

// var promise = require('bluebird');

// var options = {
//   // Initialization Options
//   promiseLib: promise
// };

const pgp = require('pg-promise')();
const path = require('path');
var app = express();
const connectionString = process.env.DATABASE_URL ||  'postgres://postgres:admin@localhost:5432/skillq';

var db = pgp(connectionString);//Create your Database object from the connection details

const cs = new pgp.helpers.ColumnSet([ 'topicId','noOfQs', 'percWeight', 'skillid'], {table: 'skillTopics'});



/* Initialize morgan for server logs*/
// var logger = require('morgan');
// app.use(logger('dev'));

// var nodemailer = require('nodemailer');

/*This is to set the http headers*/
var cors = require('cors');

var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ limit: '50mb' }));
app.use(bodyParser.json({ limit: '50mb' }));
app.use(express.static(__dirname + '/app'));
app.use(cors());
// var striptags = require('striptags');

//Password Encrypt
// var AES = require("crypto-js/aes");
// var CryptoJS = require("crypto-js");
// var encryptKey = "skillGaze";

//New user registration
app.post("/reg/", function (req, res, next) {
    //  console.log(req.body.email);
    db.none('insert into users(emailid, fullname, password) ' +
      'values($1, $2, $3)',
    [req.body.email,req.body.fullname,req.body.password])
    .then(function () {
      res.status(200)
        .json({
          status: 'success',
          message: 'User Registered successfully'
        });
    })
    .catch(function (err) {
      return next(err);
    });

});

//check user existence  
app.get("/user1/:email", function (req, res, next) {
   var email = req.params.email;
  //  console.log(email);
  db.oneOrNone('select * from users where emailid = $1', email)
    .then(function (data) {
        // console.log(data);
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'User count'
        });
    })
    .catch(function (err) {
        return next(err);
      });
 });

//get login details 
app.get("/login/:email/:password", function (req, res, next) {
   var email = req.params.email;
   var pwd = req.params.password;

   db.oneOrNone('select * from users where emailid = $1 and password = $2', [email,pwd])
    .then(function (data) {
     
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'User exists'
        });
    })
    .catch(function (err) {
        return next(err);
      });
 });


//get user details 
app.get("/userprofile/:userid", function (req, res, next) {
   var userid = req.params.userid;
  
   db.oneOrNone('select * from users where userid = $1', [userid])
    .then(function (data) {
     
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'User details'
        });
    })
    .catch(function (err) {
        return next(err);
      });
 });

 //get all skills 
app.get("/alldata/", function (req, res, next) {
   
   var status='A';

  db.many('select * from skills where active =$1 ORDER BY PUBLISHDATE DESC', status)
    .then(function (data) {
        // console.log(data);
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Skill data returned'
        });
    })
    .catch(function (err) {
        return next(err);
      });
 });

 //get all topics 
app.get("/alltopics/", function (req, res, next) {
   
   var status='A';

  db.many('select * from topics where status =$1 ORDER BY creationDate DESC', status)
    .then(function (data) {
        // console.log(data);
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Topics data returned'
        });
    })
    .catch(function (err) {
        return next(err);
      });
 });

//get user skills 
app.get("/udata/:userId", function (req, res, next) {
   
  //  var status='A';
   var userId = req.params.userId;

  db.many('select * from userskills u INNER JOIN skills s ON s.skillId = u.skillId  where u.userid =$1 ORDER BY testdate DESC', userId)
    .then(function (data) {
        // console.log(data);
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Skill data returned'
        });
    })
    .catch(function (err) {
        return next(err);
      });
 });

//New skill creation
app.post("/newSkill/", function (req, res, next) {
       console.log(req.body.savtopic);
       var topics = req.body.savtopic;
    db.one('insert into skills(skillName,totalScore,passScore,duration,numberOfQs,shortDescription,longDescription,active,level,creationDate) ' +
      'values($1, $2, $3,$4,$5,$6,$7,$8,$9,$10) RETURNING skillId',
    [req.body.skillname,req.body.totalscore,req.body.passscore,req.body.duration, req.body.numberOfQs, req.body.shortdesc,req.body.longdesc,'N','d', new Date()])
    .then(function (data) {
        console.log(data);
        var skillId = data.skillid;
        topics.forEach(function(){
          topics.push({skillid:skillId});
        });
         console.log('here'+topics);
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Skill data created'
        });
    })
    .catch(function (err) {
      return next(err);
    });

});

//New topic creation
app.post("/newTopic/", function (req, res, next) {
       console.log(req.body.savtopic);
       var topics = req.body.savtopic;
    db.one('insert into skills(skillName,totalScore,passScore,duration,numberOfQs,shortDescription,longDescription,active,level,creationDate) ' +
      'values($1, $2, $3,$4,$5,$6,$7,$8,$9,$10) RETURNING skillId',
    [req.body.skillname,req.body.totalscore,req.body.passscore,req.body.duration, req.body.numberOfQs, req.body.shortdesc,req.body.longdesc,'N','d', new Date()])
    .then(function (data) {
        console.log(data);
        var skillId = data.skillid;
        topics.forEach(function(){
          topics.push({skillid:skillId});
        });
         console.log('here'+topics);
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Skill data created'
        });
    })
    .catch(function (err) {
      return next(err);
    });

});

console.log('Server file executed successfully');
app.listen(9000);