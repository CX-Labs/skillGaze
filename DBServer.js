var express = require('express');
var app = express();

/* Initialize morgan for server logs*/
var logger = require('morgan');
app.use(logger('dev'));

const pg = require('pg');
const connectionString = process.env.DATABASE_URL || 'postgres://postgres:admin@localhost:5432/skillQ';

const client = new pg.Client(connectionString);
client.connect();
const query = client.query(
  'CREATE TABLE users(userId SERIAL PRIMARY KEY, userName VARCHAR(120) UNIQUE NOT NULL, password VARCHAR(50) NOT NULL, emailId VARCHAR(355) UNIQUE NOT NULL, mobile FLOAT(10,0) UNIQUE, orgName VARCHAR(100), designation VARCHAR(50), role VARCHAR(100), profilePic VARCHAR(100), joiningDate DATE, lastLoginDate DATE)');
query.on('end', () => { client.end(); });