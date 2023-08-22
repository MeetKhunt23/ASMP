const sql = require("./db.js");

// constructor
const order_details = function(order_details) {
  this.order_id = order_details.order_id;
  this.product_id = order_details.product_id;
  this.category_id = order_details.category_id;
  this.price = order_details.price;
  this.selling_price = order_details.selling_price;
  this.quantity = order_details.quantity;
  this.total_price = order_details.total_price;
};

order_details.OrderDetailAdd = (orderdata, result) => {
  sql.query("INSERT INTO order_details SET ?", orderdata, (err, res) => {
    //console.log(err);return;
    result(null, res.insertId);
    return; 
  });
};

order_details.remove = (user_id,product_id, result) => {
  sql.query("DELETE FROM cart WHERE user_id = ? AND product_id = ?", [user_id,product_id], (err, res) => {
    result(null, res);
  });
};

order_details.getShipping = (result) => {
    sql.query(`SELECT free_homedelivery_on_amount,shipping_charge FROM admin LIMIT 1`, (err, res) => {
    result(null, res[0]);
    return;  
    });
}

module.exports = order_details;
