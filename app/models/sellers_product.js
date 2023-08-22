const sql = require("./db.js");

// constructor
const SellerProduct = function (product) {
  this.sellers_id = product.sellers_id;
  this.category_id = product.category_id;
  this.country_id = product.country_id;
  this.state_id = product.state_id;
  this.city_id = product.city_id;
  this.name = product.name;
  this.price = product.price;
  this.selling_price = product.selling_price;
  this.description = product.description;
  this.expected_delivery_time = product.expected_delivery_time;
};

SellerProduct.productAdd = (productdata, result) => {
  sql.query("INSERT INTO products SET ?", productdata, (err, res) => {
    result(null, res.insertId);
    return;
  });
};

SellerProduct.updateProduct = (
  product_id,
  user_id,
  product_name,
  description,
  category_id,
  country_id,
  state_id,
  city_id,
  price,
  selling_price,
  exp_delivery_time,
  result
) => {
  sql.query(
    "UPDATE products SET sellers_id = ?, name = ?,description = ?, category_id = ?, country_id = ?, state_id = ?, city_id = ?,price=?, selling_price= ?, expected_delivery_time= ?  WHERE id = ?",
    [
      user_id,
      product_name,
      description,
      category_id,
      country_id,
      state_id,
      city_id,
      price,
      selling_price,
      exp_delivery_time,
      product_id,
    ],
    (err, res) => {
      result(null, product_id);
      return;
    }
  );
};

SellerProduct.getproductCount = (
  uid,
  filter_type,
  category_id,
  search_text,
  result
) => {
  var strlimit = "";
  var strCon = "";
  var order_by = "p.id DESC";
  if (filter_type == "1") {
    order_by = "p.avg_rating DESC";
  } else if (filter_type == "2") {
    order_by = "p.price DESC";
  } else if (filter_type == "3") {
    order_by = "p.price ASC";
  }

  if (filter_type == "4") {
    strCon += " AND p.is_featured=1";
  }

  if (category_id != "") {
    strCon += " AND p.category_id IN (" + category_id + ")";
  }

  if (search_text != "") {
    strCon += " AND p.name LIKE '%" + search_text + "%'";
  }

  sql.query(
    `SELECT p.id,p.product_key as product_url,p.name,p.description, p.avg_rating,p.total_review,p.price,(SELECT if(image !='',CONCAT('` +
      nodeSiteUrl +
      `','file/product/',image),'')  FROM product_images WHERE product_id = p.id ORDER BY id ASC LIMIT 1) as image,
    p.created_at,p.expected_delivery_time,
    c.name as category_name,p.category_id,p.is_featured,
    (SELECT COUNT(o.product_id) FROM order_details as o where p.id=o.product_id) as selling_products,
    p.selling_price,p.is_featured
    FROM products as p LEFT JOIN category as c ON c.id=p.category_id 
    WHERE 1=1 ` +
      strCon +
      ` AND p.cancel_status=0 AND sellers_id = ${uid} ORDER BY ` +
      order_by +
      `` +
      strlimit,

    (err, res) => {
      result(null, res);
      return;
    }
  );
};

SellerProduct.getproductList = (
  uid,
  filter_type,
  category_id,
  search_text,
  sp,
  limit,
  result
) => {
  var strCon = "";
  var order_by = "p.id DESC";

  var strlimit = " LIMIT " + sp + "," + limit + "";

  if (filter_type == "1") {
    order_by = "p.avg_rating DESC";
  } else if (filter_type == "2") {
    order_by = "p.price DESC";
  } else if (filter_type == "3") {
    order_by = "p.price ASC";
  }

  if (filter_type == "4") {
    strCon += " AND p.is_featured=1";
  }

  if (category_id != "") {
    strCon += " AND p.category_id IN (" + category_id + ")";
  }

  if (search_text != "") {
    strCon += " AND p.name LIKE '%" + search_text + "%'";
  }

  sql.query(
    `SELECT p.id,p.product_key as product_url,p.name,p.description, p.avg_rating,p.total_review,p.price,(SELECT if(image !='',CONCAT('` +
      nodeSiteUrl +
      `','file/product/',image),'')  FROM product_images WHERE product_id = p.id ORDER BY id ASC LIMIT 1) as image,
    p.created_at,p.expected_delivery_time,
    c.name as category_name,p.category_id,p.is_featured,
    (SELECT COUNT(o.product_id) FROM order_details as o where p.id=o.product_id) as selling_products,
    p.selling_price,p.is_featured,p.sellers_id,s.name as seller_name,s.profile_picture as seller_image,s.seller_avg_rating,s.seller_total_review
    FROM products as p LEFT JOIN category as c ON c.id=p.category_id 
    LEFT JOIN sellers as s ON s.id=p.sellers_id 
    WHERE 1=1 ` +
      strCon +
      ` AND p.cancel_status=0 AND sellers_id = ${uid} ORDER BY ` +
      order_by +
      `` +
      strlimit,

    (err, res) => {
      result(null, res);
      return;
    }
  );
};

SellerProduct.get_product_detail = (uid, product_id, result) => {
  sql.query(
    `SELECT p.id,p.product_key,p.name,p.price,p.description,p.category_id,p.avg_rating,p.country_id,p.state_id,p.city_id,c.name as country_name,st.name as state_name,ct.name as city_name,
    (SELECT name FROM category WHERE id = p.category_id ) as category_name,p.total_review,p.expected_delivery_time,
    p.is_featured,p.selling_price ,p.sellers_id,s.name as seller_name,s.profile_picture as seller_image,s.seller_avg_rating,s.seller_total_review
    FROM products as p
    LEFT JOIN sellers as s ON s.id=p.sellers_id
    LEFT JOIN countries as c ON c.id=p.country_id
    LEFT JOIN states as st ON st.id= p.state_id
    LEFT JOIN cities as ct ON ct.id=p.city_id
    WHERE 1=1 AND (CAST(p.id AS CHAR) = ? OR p.product_key= ?)`,
    [product_id, product_id],
    (err, res) => {
      result(null, res[0]);
      return;
    }
  );
};

SellerProduct.product_review = (product_id, result) => {
  sql.query(
    `SELECT r.id,r.user_id,r.review,r.rating,r.created_at as posted_at,u.name
  FROM product_review as r, buyers as u
  WHERE product_id = ${product_id} AND u.id = r.user_id order by r.id DESC`,
    (err, review) => {
      if (review.length) {
        var newRew = [];
        rewData = review;
        rewData.forEach(function (pro) {
          var obj = {};
          obj["id"] = pro.id;
          obj["user_id"] = pro.user_id;
          obj["review"] = pro.review;
          obj["rating"] = pro.rating;
          obj["posted_at"] = pro.posted_at;
          obj["name"] = pro.name;
          newRew.push(obj);
        });

        result(null, newRew);
        return;
      } else {
        result(null, []);
        return;
      }
    }
  );
};

SellerProduct.product_image = (product_id, result) => {
  sql.query(
    `SELECT id,
   if(image !='',CONCAT('` +
      nodeSiteUrl +
      `','file/product/',image),'') AS image
   FROM product_images
   WHERE product_id = ${product_id}`,
    (err, image) => {
      if (image.length) {
        var newImg = [];
        imgData = image;
        imgData.forEach(function (pro) {
          var obj = {};
          obj["id"] = pro.id;
          obj["image"] = pro.image;
          newImg.push(obj);
        });

        result(null, newImg);
        return;
      } else {
        result(null, []);
        return;
      }
    }
  );
};

SellerProduct.remove = (user_id, product_id, result) => {
  sql.query(
    "DELETE FROM products WHERE sellers_id = ? AND id = ?",
    [user_id, product_id],
    (err, res) => {
      result(null, res);
    }
  );
};

SellerProduct.get_orders_list_count = (user_id, result) => {
  sql.query(
    `SELECT p.id,o.* FROM products as p,order_details as o WHERE p.sellers_id = ${user_id} AND p.id = o.product_id GROUP BY o.order_id`,

    (err, res) => {
      //console.log(err);

      result(null, res);
      return;
    }
  );
};

SellerProduct.get_orders_list = (user_id, sp, limit, result) => {
  var sp = sp;
  var limit = limit;
  var where = "";

  sql.query(
    `SELECT o.order_id,po.unique_order_id,po.total_shipping,SUM(o.total_price) as total_price,
    po.created_at,u.name as buyer_fullname,u.email as buyer_email,u.phone as buyer_phone_number,u.profile_picture,
    (SELECT count(od.id) as total FROM products as pd,order_details as od WHERE pd.sellers_id = ${user_id} AND od.product_id = pd.id AND od.order_id = po.id) as total_product,
    (SELECT pd.id FROM products as pd,order_details as od WHERE pd.sellers_id = ${user_id} AND od.product_id = pd.id AND od.order_id = po.id limit 1) as product_id,
    (SELECT pd.name FROM products as pd,order_details as od WHERE pd.sellers_id = ${user_id} AND od.product_id = pd.id AND od.order_id = po.id limit 1) as product_name,
    (SELECT od.status FROM products as pd,order_details as od WHERE pd.sellers_id = ${user_id} AND od.product_id = pd.id AND od.order_id = po.id limit 1) as product_status,
    (SELECT od.under_process_date FROM products as pd,order_details as od WHERE pd.sellers_id = ${user_id} AND od.product_id = pd.id AND od.order_id = po.id limit 1) as under_process_date,
    (SELECT od.dispatched_date FROM products as pd,order_details as od WHERE pd.sellers_id = ${user_id} AND od.product_id = pd.id AND od.order_id = po.id limit 1) as dispatched_date,
    (SELECT od.received_date FROM products as pd,order_details as od WHERE pd.sellers_id = ${user_id} AND od.product_id = pd.id AND od.order_id = po.id limit 1) as received_date,
    (SELECT od.cancelled_date FROM products as pd,order_details as od WHERE pd.sellers_id = ${user_id} AND od.product_id = pd.id AND od.order_id = po.id limit 1) as cancelled_date,
    (SELECT if(i.image !='',CONCAT('` +
      nodeSiteUrl +
      `','file/product/',i.image),'') FROM products as pd,order_details as od,product_images as i WHERE pd.sellers_id = ${user_id} AND od.product_id = pd.id AND od.order_id = po.id AND i.product_id = pd.id limit 1) as product_image,
    (SELECT s.name FROM sellers as s WHERE s.id = ${user_id}) as seller_name,
    (SELECT s.email FROM sellers as s WHERE s.id = ${user_id}) as seller_email,
    (SELECT s.profile_picture FROM sellers as s WHERE s.id = ${user_id}) as seller_profile_picture,
    (SELECT s.phone FROM sellers as s WHERE s.id = ${user_id}) as seller_phone,po.full_address
    FROM products as p,order_details as o,product_order as po,buyers u 
            WHERE p.sellers_id = ${user_id} AND p.id = o.product_id AND po.id=o.order_id AND u.id =po.user_id GROUP BY o.order_id order by po.created_at DESC LIMIT ` +
      sp +
      `,` +
      limit,

    (err, res) => {
      console.log(err);
      result(null, res);
      return;
    }
  );
};

SellerProduct.order_detail_listing = (user_id, order_id, result) => {
  sql.query(
    `SELECT o.full_address,o.created_at,o.total_price,o.id as order_id,o.status,o.unique_order_id,o.order_total,o.total_shipping,u.name as full_name,u.email,u.phone,u.id as user_id,o.partially_delivered_date,o.delivered_date
    FROM product_order AS o
    LEFT JOIN buyers u ON o.user_id = u.id
    WHERE o.id = ${order_id}`,
    (err, res) => {
      var returnArray = {};
      if (res[0]) {
        var row = res[0];
        returnArray["order_id"] = row.order_id;
        returnArray["unique_order_id"] = row.unique_order_id;
        returnArray["total_shipping"] = row.total_shipping;
        returnArray["total_price"] = row.total_price;
        returnArray["order_total"] = row.order_total;
        returnArray["created_at"] = row.created_at;
        returnArray["full_name"] = row.full_name;
        returnArray["email"] = row.email;
        returnArray["phone_number"] = row.phone;
        returnArray["full_address"] = row.full_address;
        returnArray["user_id"] = row.user_id;

        sql.query(
          `SELECT p.id as product_id,p.product_key,p.name,
            (SELECT if(image !='',CONCAT('` +
            nodeSiteUrl +
            `','file/product/',image),'') FROM product_images WHERE product_id = p.id ORDER BY id ASC LIMIT 1) as image
            ,od.price,od.quantity,od.total_price,p.selling_price,p.sellers_id,s.name as seller_name,s.profile_picture as seller_image,s.seller_avg_rating,s.seller_total_review
            ,od.status,od.under_process_date,od.dispatched_date,od.received_date,od.cancelled_date
            FROM order_details as od
            LEFT JOIN products as p ON p.id=od.product_id 
            LEFT JOIN sellers as s ON s.id=p.sellers_id
            WHERE od.order_id= ${row.order_id} AND p.sellers_id= ${user_id}`,
          (err, products) => {
            var product_count = 0;
            var totalPrice = 0;
            if (products.length > 0) {
              var newCats = [];
              proData = products;

              proData.forEach(function (pro) {
                var obj = {};
                obj["ProductId"] = pro.product_id;
                obj["ProductName"] = pro.name;
                obj["name"] = pro.name;
                obj["Price"] = pro.price;
                obj["selling_price"] = pro.selling_price;
                obj["Quantity"] = pro.quantity;
                obj["image"] = pro.image;
                obj["TotalPrice"] = pro.total_price;
                obj["product_url"] = pro.product_key;
                obj["sellers_id"] = pro.sellers_id;
                obj["seller_name"] = pro.seller_name ? pro.seller_name : "";
                obj["seller_image"] = pro.seller_image
                  ? nodeSiteUrl + "file/users/" + pro.seller_image
                  : "";
                obj["seller_avg_rating"] = pro.seller_avg_rating
                  ? pro.seller_avg_rating
                  : 0;
                obj["seller_total_review"] = pro.seller_total_review
                  ? pro.seller_total_review
                  : 0;
                obj["status"] = pro.status;
                obj["under_process_date"] = pro.under_process_date
                  ? pro.under_process_date
                  : "";
                obj["dispatched_date"] = pro.dispatched_date
                  ? pro.dispatched_date
                  : "";
                obj["received_date"] = pro.received_date
                  ? pro.received_date
                  : "";
                obj["cancelled_date"] = pro.received_date
                  ? pro.cancelled_date
                  : "";
                product_count += pro.quantity;
                totalPrice += pro.total_price;
                newCats.push(obj);
              });
              returnArray["ProductCount"] = product_count;
              returnArray["products"] = newCats;
              returnArray["total_price"] = totalPrice;
              returnArray["order_total"] = totalPrice;
            } else {
              returnArray["products"] = [];
            }
            result(null, returnArray);
            return;
          }
        );
      } else {
        result(null, returnArray);
        return;
      }
    }
  );
};

SellerProduct.order_detail_listing1 = (user_id, order_id, result) => {
  sql.query(
    `SELECT o.full_address,o.created_at,o.total_price,o.id as order_id,o.status,o.unique_order_id,o.order_total,o.total_shipping,u.name as full_name,u.email,u.phone,u.id as user_id,o.partially_delivered_date,o.delivered_date
    FROM product_order AS o
    LEFT JOIN buyers u ON o.user_id = u.id
    WHERE o.id = ${order_id}`,
    (err, res) => {
      var returnArray = {};
      var product_total = 0;
      if (res[0]) {
        var row = res[0];
        returnArray["order_id"] = row.order_id;
        returnArray["unique_order_id"] = row.unique_order_id;
        returnArray["created_at"] = row.created_at;
        returnArray["full_name"] = row.full_name;
        returnArray["email"] = row.email;
        returnArray["phone_number"] = row.phone;
        returnArray["full_address"] = row.full_address;
        returnArray["status"] = row.status;
        returnArray["partially_delivered_date"] = row.partially_delivered_date
          ? row.partially_delivered_date
          : "";
        returnArray["delivered_date"] = row.delivered_date
          ? row.delivered_date
          : "";
        returnArray["user_id"] = row.user_id;

        sql.query(
          `SELECT p.id as product_id,p.product_key,p.name,
            (SELECT if(image !='',CONCAT('` +
            nodeSiteUrl +
            `','file/product/',image),'') FROM product_images WHERE product_id = p.id ORDER BY id ASC LIMIT 1) as image
            ,od.price,od.quantity,od.total_price,p.selling_price,p.sellers_id,s.name as seller_name,s.profile_picture as seller_image,s.seller_avg_rating,s.seller_total_review,
            od.status,od.under_process_date,od.dispatched_date,od.received_date,od.cancelled_date
            FROM order_details as od
            LEFT JOIN products as p ON p.id=od.product_id 
            LEFT JOIN sellers as s ON s.id=p.sellers_id
            WHERE od.order_id= ${row.order_id} AND p.sellers_id = ${user_id}`,
          (err, products) => {
            var product_count = 0;
            if (products.length > 0) {
              var newCats = [];
              proData = products;

              proData.forEach(function (pro) {
                var obj = {};
                obj["ProductId"] = pro.product_id;
                obj["ProductName"] = pro.name;
                obj["name"] = pro.name;
                obj["Price"] = pro.price;
                obj["selling_price"] = pro.selling_price;
                obj["Quantity"] = pro.quantity;
                obj["image"] = pro.image;
                obj["TotalPrice"] = pro.total_price;
                obj["product_url"] = pro.product_key;
                obj["sellers_id"] = pro.sellers_id;
                obj["seller_name"] = pro.seller_name ? pro.seller_name : "";
                obj["seller_image"] = pro.seller_image
                  ? nodeSiteUrl + "file/users/" + pro.seller_image
                  : "";
                obj["seller_avg_rating"] = pro.seller_avg_rating
                  ? pro.seller_avg_rating
                  : 0;
                obj["seller_total_review"] = pro.seller_total_review
                  ? pro.seller_total_review
                  : 0;
                obj["status"] = pro.status;
                obj["under_process_date"] = pro.under_process_date
                  ? pro.under_process_date
                  : "";
                obj["dispatched_date"] = pro.dispatched_date
                  ? pro.dispatched_date
                  : "";
                obj["received_date"] = pro.received_date
                  ? pro.received_date
                  : "";
                obj["cancelled_date"] = pro.received_date
                  ? pro.cancelled_date
                  : "";
                product_count += pro.quantity;
                product_total += pro.total_price;
                newCats.push(obj);
              });
              returnArray["total_price"] = product_total;
              returnArray["total_shipping"] = row.total_shipping;
              returnArray["order_total"] = product_total + row.total_shipping;
              returnArray["ProductCount"] = product_count;
              returnArray["products"] = newCats;
            } else {
              returnArray["total_price"] = 0;
              returnArray["total_shipping"] = 0;
              returnArray["order_total"] = 0;
              returnArray["ProductCount"] = 0;
              returnArray["products"] = [];
            }
            result(null, returnArray);
            return;
          }
        );
      } else {
        result(null, returnArray);
        return;
      }
    }
  );
};

module.exports = SellerProduct;
