var thinky = require('../util/thinky.js');

var Bookmarks = thinky.createModel("Bookmark", {
    id: type.string(), 
    index: type.string(),
    mode: type.boolean(),
    user: [type.string()],
    access_time: type.date().default(r.now()),
    modification_time: type.date().default(r.now()),
    change_time: type.date().default(r.now()),
    url: type.string()
});

module.exports = Bookmarks;

