var thinky = require('../util/thinky.js');

var User = thinky.createModel("User", {
    id: type.string(),
    name: type.string(),
    email: type.number(),
    password: type.String()
});

module.exports = User;



// post => create an new user
// get  => get a user using the name or id
// delete = delete the user using the id
