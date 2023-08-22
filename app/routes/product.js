module.exports = app => {
  const product = require("../controllers/product.js");
  app.post("/product/getproductListing", product.getproductListing);
  app.post("/product/get_product_detail", product.get_product_detail);
  app.post("/product/add_or_remove_to_wishlist", product.add_or_remove_to_wishlist);
  app.post("/product/getWishlistProducts", product.getWishlistProducts);
  app.post("/product/post_review_rating", product.post_review_rating);  
  app.post("/product/review_listing", product.review_listing);
  app.post("/product/add_to_cart", product.add_to_cart);
  app.post("/product/change_product_quantity", product.change_product_quantity);
  app.post("/product/remove_product_from_cart", product.remove_product_from_cart);
  app.post("/product/cart_listing", product.cart_listing);
  app.post("/product/add_order", product.add_order);
  app.post("/product/order_detail", product.order_detail);
  app.post("/product/orderlisting",product.orderlisting);
  app.post("/product/order_status_change",product.order_status_change);
};
