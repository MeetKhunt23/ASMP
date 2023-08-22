module.exports = app => {
  const seller_product = require("../controllers/sellers_product.js");
  app.post("/seller_product/addproduct", seller_product.addproduct);
  app.post("/seller_product/addproductimage", seller_product.addproductimage);
  app.post("/seller_product/updateproduct", seller_product.updateproduct);
  app.post("/seller_product/removeImage", seller_product.removeImage);
  app.post("/seller_product/seller_product_listing", seller_product.seller_product_listing);
  app.post("/seller_product/seller_product_detail", seller_product.seller_product_detail);  
  app.post("/seller_product/order_detail1", seller_product.order_detail1);
  app.post("/seller_product/orderlisting",seller_product.orderlisting);
  app.post("/seller_product/order_detail",seller_product.order_detail);
  app.post("/seller_product/product_delete", seller_product.product_delete);
};
