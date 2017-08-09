const express = require('express');
const router = express.Router();
const pg = require('pg');
const path = require('path');
var app = express();
const connectionString = process.env.DATABASE_URL ||  'postgres://postgres:admin@localhost:5432/skillGaze';

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
var AES = require("crypto-js/aes");
var CryptoJS = require("crypto-js");
var encryptKey = "skillGaze";


router.post('/reg', (req, res, next) => {
  const results = [];
  // Grab data from http request
  const data = {userName: req.body.userName, password:  req.body.password};
  // Get a Postgres client from the connection pool
  pg.connect(connectionString, (err, client, done) => {
    // Handle connection errors
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({success: false, data: err});
    }
    // SQL Query > Insert Data
    client.query('INSERT INTO users(userName, password) values($1, $2)',
    [data.userName, data.password]);
    // SQL Query > Select Data
    const query = client.query('SELECT * FROM users ORDER BY id ASC');
    // Stream results back one row at a time
    query.on('row', (row) => {
      results.push(row);
    });
    // After all data is returned, close connection and return results
    query.on('end', () => {
      done();
      return res.json(results);
    });
  });
});

router.get('/user1', (req, res, next) => {
  const results = [];
  const data = {userName: req.body.userName, password:  req.body.password};
  // Get a Postgres client from the connection pool
  pg.connect(connectionString, (err, client, done) => {
    // Handle connection errors
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({success: false, data: err});
    }
    // SQL Query > Select Data
    const query = client.query('SELECT * FROM users where userName=$1;',[data.userName]);
    // Stream results back one row at a time
    query.on('row', (row) => {
      results.push(row);
    });
    // After all data is returned, close connection and return results
    query.on('end', () => {
      done();
      return res.json(results);
    });
  });
});

console.log('Server file executed successfully');
app.listen(9000);