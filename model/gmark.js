var bookmarks = require('./bookmarks.js');
var user = require('./user.js');
var tags = require('./tags.js')

module.exports = {
    Bookmarks: bookmarks,
    User: user,
    Tags: tags
};



//order by name
exports.tags = function(res, req) {
    Tags.orderBy({index: {name}}).run().then(function(posts) {
        res.json({
            posts: posts
        });
    }).error(handleError(res));
}
