var thinky = require('../util/thinky.js');

var Tags = thinky.createModel("Tag", {
    id: type.string(), 
    index: type.string(),
    mode:  {user: type.Number(),
	   group: type.Number(),
	   all: type.Number()},
    user: type.string(),
    access_time: type.date().default(r.now()),
    modification_time: type.date().default(r.now()),
    change_time: type.date().default(r.now()),
    name: type.string().required(),
    parent_tag: type.string(),
    client_tag: [type.string()],
    gmark: [type.string()]
});

module.exports = Tags;

