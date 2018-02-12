var thinky = require('thinky')(),
    rest = require('thinky-rest'),
    http = require('http');

// Define your models
var User = thinky.createModel('users', {
  username: thinky.type.string().required(),
  birthday: thinky.type.date().required()
});

// Initialize server
var server, app;
if (process.env.USE_RESTIFY) {
  var restify = require('restify');

  app = server = restify.createServer()
  app.use(restify.queryParser());
  app.use(restify.bodyParser());
} else {
  var express = require('express'),
      bodyParser = require('body-parser');

  app = express();
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({ extended: false }));
  server = http.createServer(app);
}

// Initialize thinky-rest
rest.initialize({
  app: app,
  thinky: thinky
});

// Create a REST resource
var userResource = rest.resource({
  model: User,
  endpoints: ['/users', '/users/:id']
});

// Start the server and access your rest routes
server.listen(function() {
  var host = server.address().address,
      port = server.address().port;

  console.log('listening at http://%s:%s', host, port);
});
