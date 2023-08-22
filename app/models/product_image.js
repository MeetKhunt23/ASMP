const sql = require("./db.js");

// constructor
const ProductImage = function(product) {
  this.product_id = product.product_id;
  this.image = product.image;
};
ProductImage.productImageAdd = (productImgdata, result) => {
  sql.query("INSERT INTO product_images SET ?", productImgdata, (err, res) => {
  	if(res ==undefined)
  	{
  		result(null, '');
  	}
  	else
  	{
  		result(null, res.insertId);
  	}
    
    return; 
  });
};

ProductImage.remove = (id, result) => {
  sql.query("DELETE FROM product_images WHERE id = ?", id, (err, res) => {
    result(null, res);
  });
};
module.exports = ProductImage;
