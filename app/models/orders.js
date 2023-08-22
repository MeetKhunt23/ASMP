const sql = require("./db.js");

// constructor
const Orders = function(order) {
  this.unique_order_id = order.unique_order_id;
  this.user_id = order.user_id;
  this.address_id = order.address_id;
  this.total_shipping = order.total_shipping;
  this.total_price = order.total_price;
  this.order_total = order.order_total;
  this.status = order.status;
  this.full_address = order.full_address;
  this.latitude = order.latitude;
  this.longitude = order.longitude;
  /*this.accept_date = order.accept_date;
  this.shipped_date = order.shipped_date;
  this.delivered_date = order.delivered_date;*/
};

Orders.get_address_by_id = (address_id, result) => {
    sql.query(`SELECT *,c.name as country_name,s.name as state_name,ct.name as city_name  FROM addresses as a 
    LEFT JOIN countries as c ON c.id = a.country
    LEFT JOIN states as s ON s.id = a.state
    LEFT JOIN cities as ct ON ct.id = a.city
    WHERE a.id = ${address_id}`, (err, res) => {
    // console.log(res);return;
    result(null, res[0]);
    return;  
    });
}

Orders.OrderAdd = (orderdata, result) => {
  sql.query("INSERT INTO product_order SET ?", orderdata, (err, res) => {
    // console.log(err);return;
    result(null, res.insertId);
    return; 
  });
};

Orders.order_detail_listing = (user_id,order_id, result) => {
 sql.query(`SELECT o.full_address,o.created_at,o.total_price,o.id as order_id,o.status,o.unique_order_id,o.order_total,o.total_shipping,u.name as full_name,u.email,u.phone,u.id as user_id,o.partially_delivered_date,o.delivered_date
    FROM product_order AS o
    LEFT JOIN buyers u ON o.user_id = u.id
    WHERE o.id = ${order_id}`, 
    (err, res) => {
        var returnArray ={};
        if(res[0])
        {
            var row =  res[0];  
            returnArray['order_id'] = row.order_id;
            returnArray['unique_order_id'] = row.unique_order_id;
            returnArray['total_shipping'] = row.total_shipping;
            returnArray['total_price'] = row.total_price;
            returnArray['order_total'] = row.order_total;
            returnArray['created_at'] = row.created_at;
            returnArray['full_name'] = row.full_name;
            returnArray['email'] = row.email;
            returnArray['phone_number'] = row.phone;
            returnArray['full_address'] = row.full_address;
            returnArray['status'] = row.status;
            returnArray['partially_delivered_date'] = row.partially_delivered_date?row.partially_delivered_date:"";
            returnArray['delivered_date'] = row.delivered_date?row.delivered_date:"";
            returnArray['user_id'] = row.user_id;

            sql.query(`SELECT p.id as product_id,p.product_key,p.name,
            (SELECT if(image !='',CONCAT('`+nodeSiteUrl+`','file/product/',image),'') FROM product_images WHERE product_id = p.id ORDER BY id ASC LIMIT 1) as image
            ,od.price,od.quantity,od.total_price,p.selling_price,p.sellers_id,s.name as seller_name,s.profile_picture as seller_image,s.seller_avg_rating,s.seller_total_review
            ,od.status,od.under_process_date,od.dispatched_date,od.received_date,od.cancelled_date
            FROM order_details as od
            LEFT JOIN products as p ON p.id=od.product_id 
            LEFT JOIN sellers as s ON s.id=p.sellers_id
            WHERE od.order_id= ${row.order_id}`, 
            (err, products) => {
               var product_count = 0;
               if(products.length > 0)
               {
                    var newCats = [];
                    proData = products;
                   
                    proData.forEach(function(pro){
                        var obj ={};
                        obj['ProductId']       = pro.product_id;
                        obj['ProductName'] = pro.name;
                        obj['name']     = pro.name;
                        obj['Price']    = pro.price;  
                        obj['selling_price']= pro.selling_price;  
                        obj['Quantity']   = pro.quantity;
                        obj['image']    =  pro.image; 
                        obj['TotalPrice']= pro.total_price;  
                        obj['product_url']= pro.product_key;  
                        obj['sellers_id'] = pro.sellers_id; 
                        obj['seller_name'] = pro.seller_name?pro.seller_name:""; 
                        obj['seller_image'] = pro.seller_image?nodeSiteUrl+'file/users/'+pro.seller_image:""; 
                        obj['seller_avg_rating']       = pro.seller_avg_rating?pro.seller_avg_rating:0;
                        obj['seller_total_review']       = pro.seller_total_review?pro.seller_total_review:0;
                        obj['status']= pro.status; 
                        obj['under_process_date']= pro.under_process_date?pro.under_process_date:""; 
                        obj['dispatched_date']= pro.dispatched_date?pro.dispatched_date:"";
                        obj['received_date']= pro.received_date?pro.received_date:"";  
                        obj['cancelled_date']= pro.received_date?pro.cancelled_date:"";
                        product_count += pro.quantity;
                        newCats.push(obj); 
                    });
                    returnArray['ProductCount']  = product_count; 
                    returnArray['products'] = newCats;
               }
               else
               {
                  returnArray['products'] = [];
               }
               result(null, returnArray);
               return;
            })
        }
        else
        {
            result(null, returnArray);
            return;
        }
    });

}


Orders.get_orders_list_count = (user_id, result) => {

 /* var where = '';
  if(type == '1')
  {
    where = " AND o.status != 3";
  }
  else
  {
    where = " AND o.status = 3";
  }
*/
  sql.query(`SELECT o.id FROM product_order as o LEFT JOIN buyers u ON o.user_id = u.id WHERE o.user_id= ${user_id} GROUP BY o.id ORDER BY o.id DESC`,
   
  (err, res) => {
  //console.log(res); return false;
 
  result(null, res);
  return;  
  });
};

Orders.get_orders_list = (user_id,sp,limit, result) => {

  var sp     = sp; 
  var limit  = limit;
  var where = '';

  sql.query(`SELECT o.full_address,o.order_total,o.created_at,o.total_price,
  o.id as order_id,o.status,o.unique_order_id,o.partially_delivered_date,
  o.delivered_date,o.total_shipping,u.name as buyer_fullname,u.email as buyer_email,u.phone as buyer_phone_number,u.profile_picture,
  (SELECT count(id) FROM order_details WHERE order_id = o.id) as total_product,
  (SELECT p.name FROM order_details as d LEFT JOIN products as p ON p.id=d.product_id WHERE d.order_id = o.id limit 1) as product_name,
  (SELECT if(i.image !='',CONCAT('`+nodeSiteUrl+`','file/product/',i.image),'') FROM order_details as d LEFT JOIN products as p ON p.id=d.product_id LEFT JOIN product_images as i ON i.product_id = p.id WHERE d.order_id = o.id limit 1) as product_image,
  (SELECT s.name FROM order_details as d LEFT JOIN products as p ON p.id=d.product_id LEFT JOIN sellers as s ON s.id = p.sellers_id WHERE d.order_id = o.id limit 1) as seller_name,
  (SELECT s.email FROM order_details as d LEFT JOIN products as p ON p.id=d.product_id LEFT JOIN sellers as s ON s.id = p.sellers_id WHERE d.order_id = o.id limit 1) as seller_email,
  (SELECT s.profile_picture FROM order_details as d LEFT JOIN products as p ON p.id=d.product_id LEFT JOIN sellers as s ON s.id = p.sellers_id WHERE d.order_id = o.id limit 1) as seller_profile_picture,
  (SELECT s.phone FROM order_details as d LEFT JOIN products as p ON p.id=d.product_id LEFT JOIN sellers as s ON s.id = p.sellers_id WHERE d.order_id = o.id limit 1) as seller_phone
  FROM product_order as o
  LEFT JOIN buyers u ON o.user_id = u.id 
  WHERE o.user_id= ${user_id} GROUP BY o.id ORDER BY o.created_at DESC LIMIT `+sp+`,`+limit,
   
  (err, res) => {
  result(null, res);
  return;  
  });
};

Orders.get_order_status = (product_id,order_id, result) => {
    sql.query(`SELECT count(id) as total FROM order_details
    WHERE order_id = ${order_id} AND status !=3`, (err, res) => {
    result(null, res[0]);
    return;  
    });
}

Orders.updateStatus = (product_id,order_id,status,current_date, result) => {
  var field = "";
  if(status == 1)
  {
     field = ", under_process_date = '"+current_date+"'";
  }
  else if(status == 2)
  {
      field = ", dispatched_date = '"+current_date+"'";
  }
  else if(status == 3)
  {
    field = ", received_date = '"+current_date+"'";
  }
  else 
  {
    field = ", cancelled_date = '"+current_date+"'";
  }

  sql.query(
    "UPDATE order_details SET status = ? "+field+" WHERE product_id = ? AND order_id = ?",
    [status, product_id, order_id],
    (err, res) => {
      result(null, product_id);
      return;  
    }
  );
};

Orders.updateStatusOrder = (order_id,orderStatus,delivered_date, result) => {
  sql.query(
    "UPDATE product_order SET status = ?, delivered_date = ? WHERE id = ?",
    [orderStatus, delivered_date, order_id],
    (err, res) => {
      result(null, order_id);
      return;  
    }
  );
};
Orders.updateStatusOrderPar = (order_id,orderStatus,partially_delivered_date, result) => {
  sql.query(
    "UPDATE product_order SET status = ?, partially_delivered_date = ? WHERE id = ?",
    [orderStatus, partially_delivered_date, order_id],
    (err, res) => {
      result(null, order_id);
      return;  
    }
  );
};

Orders.get_product = (id, result) => {
    sql.query(`SELECT p.id,p.name,p.image,p.price,p.description,p.category_id,
      p.avg_rating,c.name as category_name,c.id as category_id,
      p.expected_delivery_time,p.created_at,p.is_featured,
      p.featured_date,p.selling_price  
      FROM products as p 
      LEFT JOIN category as c ON c.id=p.category_id
      WHERE p.id = ${id}`, (err, res) => {
        // console.log(res); return false
    result(null, res[0]);
    return;  
    });
};

Orders.updateOrder = (total_shipping,order_total,total_price,orderid, result) => {

  sql.query(
    "UPDATE product_order SET total_shipping = ? , order_total = ?, total_price = ? WHERE id = ?",
    [total_shipping, order_total, total_price,orderid],
    (err, res) => {
      result(null, orderid);
      return;  
    }
  );
};

module.exports = Orders;
