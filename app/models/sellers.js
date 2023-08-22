const sql = require("./db.js");

// constructor
const Sellers = function(sellers) {
  this.phone = sellers.phone;
  this.name = sellers.name;
  this.email = sellers.email;
  this.country_id = sellers.country_id;
  this.state_id = sellers.state_id;
  this.city_id = sellers.city_id;
  this.device_token = sellers.device_token;
  this.device_type = sellers.device_type;
};

Sellers.createSeller = (newUser, result) => {
  sql.query("INSERT INTO sellers SET ?", newUser, (err, res) => {
    result(null, res.insertId);
    return; 
  });
};

Sellers.findPhoneSellers = (phone, result) => {
  sql.query(`SELECT * FROM sellers WHERE phone = ${phone} `, (err, res) => {
  result(null, res[0]);
  return;  
  });
};

Sellers.updateByIdSeller = (id, device_type,device_token, result) => {
  sql.query(
    "UPDATE sellers SET device_type = ?, device_token = ? WHERE id = ?",
    [device_type, device_token, id],
    (err, res) => {
      result(null, id);
      return;  
    }
  );
};

Sellers.findPhoneExits = (phone,user_id, result) => {
  sql.query(`SELECT * FROM sellers WHERE phone = ${phone} AND id != ${user_id}`, (err, res) => {
  result(null, res[0]);
  return;  
  });
};

Sellers.CheckEmail = (email,user_id, result) => {
  sql.query(`SELECT * FROM sellers WHERE email = ? AND id != ?`,
  [email, user_id]
    , (err, res) => {
  result(null, res[0]);
  return;  
  });
};

Sellers.updateByIdUser = (id,name,email,phone,country_id,state_id,city_id,filename, result) => {
  sql.query(
    "UPDATE sellers SET name = ?, email = ?,phone = ?, country_id = ?, state_id = ?, city_id = ?, profile_picture = ?  WHERE id = ?",
    [name, email, phone, country_id, state_id, city_id,filename, id],
    (err, res) => {
      result(null, id);
      return;  
    }
  );
};

Sellers.findUserDetail = (user_id, result) => {
  sql.query(`SELECT u.*,u.profile_picture as current_image,c.name as country_name,s.name as state_name,t.name as city_name FROM sellers as u
  LEFT JOIN countries c ON c.id = u.country_id
  LEFT JOIN states s ON s.id = u.state_id
  LEFT JOIN cities t ON t.id = u.city_id
  WHERE u.id = ${user_id} `, (err, res) => {
  result(null, res[0]);
  return;  
  });
};

Sellers.UserLogout = (id, result) => {
  sql.query(
    "UPDATE sellers SET device_type = ?, device_token = ?  WHERE id = ?",
    ['0', '', id],
    (err, res) => {
      result(null, id);
      return;  
    }
  );
};

Sellers.updateSellerRating = (seller_id,average_rating,total, result) => {
  sql.query(
    "UPDATE sellers SET seller_avg_rating = ?, seller_total_review = ?  WHERE id = ?",
    [average_rating, total, seller_id],
    (err, res) => {

      //console.log(res);return false;
      result(null, seller_id);
      return;  
    }
  );
};

/*Customer.create = (newCustomer, result) => {
  sql.query("INSERT INTO customers SET ?", newCustomer, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    console.log("created customer: ", { id: res.insertId, ...newCustomer });
    result(null, { id: res.insertId, ...newCustomer });
  });
};

Customer.findById = (customerId, result) => {
  sql.query(`SELECT * FROM customers WHERE id = ${customerId}`, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    if (res.length) {
      console.log("found customer: ", res[0]);
      result(null, res[0]);
      return;
    }

    // not found Customer with the id
    result({ kind: "not_found" }, null);
  });
};

Customer.getAll = result => {
  sql.query("SELECT * FROM customers", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("customers: ", res);
    result(null, res);
  });
};

Customer.updateById = (id, customer, result) => {
  sql.query(
    "UPDATE customers SET email = ?, name = ?, active = ? WHERE id = ?",
    [customer.email, customer.name, customer.active, id],
    (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(null, err);
        return;
      }

      if (res.affectedRows == 0) {
        // not found Customer with the id
        result({ kind: "not_found" }, null);
        return;
      }

      console.log("updated customer: ", { id: id, ...customer });
      result(null, { id: id, ...customer });
    }
  );
};

Customer.remove = (id, result) => {
  sql.query("DELETE FROM customers WHERE id = ?", id, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    if (res.affectedRows == 0) {
      // not found Customer with the id
      result({ kind: "not_found" }, null);
      return;
    }

    console.log("deleted customer with id: ", id);
    result(null, res);
  });
};

Customer.removeAll = result => {
  sql.query("DELETE FROM customers", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log(`deleted ${res.affectedRows} customers`);
    result(null, res);
  });
};*/

module.exports = Sellers;
