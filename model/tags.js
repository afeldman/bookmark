var thinky = require('../util/thinky.js');

var Tags = thinky.createModel("Tag", {
    id: type.string(), 
    index: type.string(),
    mode: type.boolean(),
    user: [type.string()],
    access_time: type.date().default(r.now()),
    modification_time: type.date().default(r.now()),
    change_time: type.date().default(r.now()),
    name: type.string().required(),
    parent_tag: type.string(),
    client_tag: [type.string()],
    gmark: [type.string()]
});

module.exports = Tags;

//order by name
exports.tags = function(res, req) {
    Tags.orderBy({index: {name}}).run().then(function(posts) {
        res.json({
            posts: posts
        });
    }).error(handleError(res));
}
