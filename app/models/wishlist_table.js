const sql = require("./db.js");

// constructor
const WishlistTable = function(wishlist) {
  this.user_id = wishlist.user_id;
  this.product_id = wishlist.product_id;
};

WishlistTable.wishlistAdd = (wishlist, result) => {
  sql.query("INSERT INTO wishlist SET ?", wishlist, (err, res) => {
    result(null, res.insertId);
    return; 
  });
};
module.exports = WishlistTable;
