//To create and maintain all database objects for the application

const pg = require('pg');
const connectionString = process.env.DATABASE_URL || 'postgres://postgres:admin@localhost:5432/skillQ';

const client = new pg.Client(connectionString);
client.connect();
const query = client.query(
  'CREATE TABLE users(userId SERIAL PRIMARY KEY, userName VARCHAR(120) UNIQUE NOT NULL, password VARCHAR(50) NOT NULL)');
query.on('end', () => { client.end(); });