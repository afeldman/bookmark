require('dotenv').config('.env');

var thinky = require('thinky');
var r = thinky.r;
var type = thinky.type;

// Initialize thinky
// The most important thing is to initialize the pool of connection
thinky.init({
    host: process.env.RETHINKDB_HOST,
    port: process.env.RETHINKDB_PORT,
    db: process.env.RETHINKDB_DB,
});

exports.thinky = thinky;
