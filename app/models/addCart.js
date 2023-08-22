const sql = require("./db.js");

// constructor
const AddCart = function(addcart) {
  this.user_id = addcart.user_id;
  this.product_id = addcart.product_id;
  this.price = addcart.price;
  this.selling_price = addcart.selling_price;
  this.quantity = addcart.quantity;
  this.total_price = addcart.total_price;
};

AddCart.exist_in_cart = (user_id,product_id, result) => {
    sql.query(`SELECT id,quantity,price FROM cart WHERE product_id = ${product_id} AND user_id = ${user_id}`, (err, res) => {
    result(null, res[0]);
    return;  
    });
};


AddCart.updateCart = (cart_quantity,total_price,selling_price,price,user_id,product_id, result) => {
  sql.query(
    "UPDATE cart SET quantity = ?, total_price = ?, price = ?, selling_price = ? WHERE user_id = ? AND product_id = ?",
    [cart_quantity, total_price, price, selling_price, user_id, product_id],
    (err, res) => {
      result(null, product_id);
      return;  
    }
  );
};

AddCart.cartAdd = (newCart, result) => {
  sql.query("INSERT INTO cart SET ?", newCart, (err, res) => {
    result(null, res.insertId);
    return; 
  });
};

AddCart.remove = (id, result) => {
  sql.query("DELETE FROM cart WHERE id = ?", id, (err, res) => {
    result(null, res);
  });
};

AddCart.cart_listing = (user_id, result) => {
    sql.query(`SELECT a.id, a.address_one, a.address_two, a.city,a.state,a.country,a.pincode, a.latitude, a.longitude, u.name as full_name,u.phone as phone_number,u.email
    FROM addresses AS a
    LEFT JOIN buyers u ON u.address_id = a.id
    WHERE a.user_id = ${user_id} GROUP BY a.user_id`, 
    (err, res) => {
        var returnArray ={};
        if(res[0])
        {
          var row =  res[0];  
          returnArray['address_id'] = row.id;
          returnArray['address_one'] = row.address_one;
          returnArray['address_two'] = row.address_two;
          returnArray['city'] = row.city;
          returnArray['state'] = row.state;
          returnArray['country'] = row.country;
          returnArray['pincode'] = row.pincode;
          returnArray['latitude'] = row.latitude;
          returnArray['longitude'] = row.longitude;
          returnArray['full_name'] = row.full_name;
          returnArray['phone_number'] = row.phone_number;
          returnArray['email'] = row.email;
        }
        else
        {
            returnArray['address_id'] = '';
            returnArray['address_one'] = '';
            returnArray['address_two'] = '';
            returnArray['city'] = '';
            returnArray['state'] = '';
            returnArray['country'] = '';
            returnArray['pincode'] = '';
            returnArray['latitude'] = '';
            returnArray['longitude'] = '';
            returnArray['full_name'] = '';
            returnArray['phone_number'] = '';
            returnArray['email'] ='';
        }
        
        sql.query(`SELECT free_homedelivery_on_amount,shipping_charge FROM admin LIMIT 1`, 
        (err, res) => {

            var DeliverRow = res[0];
            
            var grand_total = 0;

              sql.query(`SELECT c.id,c.product_id, c.user_id, c.price, c.quantity, c.total_price, p.name,
              (SELECT image FROM product_images WHERE product_id = p.id ORDER BY id ASC LIMIT 1) as image, p.expected_delivery_time,c.selling_price
              ,p.sellers_id,s.name as seller_name,s.profile_picture as seller_image,s.seller_avg_rating,s.seller_total_review
              FROM cart c LEFT JOIN products p ON c.product_id = p.id
              LEFT JOIN sellers as s ON s.id=p.sellers_id
              WHERE c.user_id = ${user_id} GROUP BY p.id`, 
              (err, products) => {
                  if(products.length > 0)
                  { 
                        var newCats = [];
                        proData = products;
                        var total = 0;
                        var product_count = 0;
                        proData.forEach(function(pro){
                            var obj ={};
                            obj['id']       = pro.id;
                            obj['product_id'] = pro.product_id;
                            obj['name']     = pro.name;
                            obj['price']    = pro.price;  
                            obj['selling_price']= pro.selling_price;  
                            obj['quantity']   = pro.quantity;
                            obj['image']    =  pro.image?nodeSiteUrl+'file/product/'+pro.image:""; 
                            obj['total_price']= pro.total_price;  
                            obj['expected_delivery_time']= pro.expected_delivery_time;  
                            obj['sellers_id'] = pro.sellers_id; 
                            obj['seller_name'] = pro.seller_name?pro.seller_name:""; 
                            obj['seller_image'] = pro.seller_image?nodeSiteUrl+'file/users/'+pro.seller_image:""; 
                            obj['seller_avg_rating']       = pro.seller_avg_rating?pro.seller_avg_rating:0;
                            obj['seller_total_review']       = pro.seller_total_review?pro.seller_total_review:0;
                            total += pro.total_price;  
                            product_count += pro.quantity; 
                            newCats.push(obj); 
                        });
                         
                        returnArray['product'] = newCats;
                        returnArray['free_homedelivery_on_amount'] =   DeliverRow.free_homedelivery_on_amount;     

                        if(total >= DeliverRow.free_homedelivery_on_amount)
                        {
                          returnArray['shipping_charge']             = 0;
                          returnArray['total_amount']               = total;
                        }
                        else
                        {
                          if(total > 0) 
                          {
                            returnArray['shipping_charge'] = DeliverRow.shipping_charge;
                            returnArray['total_amount']     = total + DeliverRow.shipping_charge;
                          }
                          else 
                          {
                            returnArray['shipping_charge']   = 0;
                            returnArray['total_amount']    = 0;
                          } 
                        }
                        grand_total += returnArray['total_amount'];
                        returnArray['product_count'] = product_count; 
                  }
                  else
                  {
                     returnArray['product'] = [];
                  }

                  returnArray['grand_total'] = grand_total;  

                  result(null, returnArray);
                  return;

              });

        });
    });
};

module.exports = AddCart;
