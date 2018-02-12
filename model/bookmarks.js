var thinky = require('../util/thinky.js');

var Bookmarks = thinky.createModel("Bookmark", {
    id: type.string(), 
    index: type.string(),
    mode: {user: type.Number(),
	   group: type.Number(),
	   all: type.Number()},
    user: type.string(),
    access_time: type.date().default(r.now()),
    modification_time: type.date().default(r.now()),
    change_time: type.date().default(r.now()),
    url: type.string(),
    title: type.string(),
    keywords: [type.string()],
    comment: type.string()
});

module.exports = Bookmarks;

// /api/v1/bookmark/...
// post => create an new bookmark.
// if A bookmark can have diverent user.
//
// get  => get a user using the name or id
// delete = delete the user using the id
