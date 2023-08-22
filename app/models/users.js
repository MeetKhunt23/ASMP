const sql = require("./db.js");

// constructor
const Users = function(user) {
  this.phone = user.phone;
  this.name = user.name;
  this.email = user.email;
  this.country_id = user.country_id;
  this.state_id = user.state_id;
  this.city_id = user.city_id;
  this.device_type = user.device_type;
  this.device_token = user.device_token;
};

Users.createUser = (newUser, result) => {
  sql.query("INSERT INTO buyers SET ?", newUser, (err, res) => {
    result(null, res.insertId);
    return; 
  });
};

Users.findPhoneExits = (phone,user_id, result) => {
  sql.query(`SELECT * FROM buyers WHERE phone = ${phone} AND id != ${user_id}`, (err, res) => {
  result(null, res[0]);
  return;  
  });
};

Users.CheckEmail = (email,user_id, result) => {
  sql.query(`SELECT * FROM buyers WHERE email = ? AND id != ?`,
  [email, user_id]
    , (err, res) => {
  result(null, res[0]);
  return;  
  });
};

Users.updateByIdUser = (id,name,email,phone,country_id,state_id,city_id,filename, result) => {
  sql.query(
    "UPDATE buyers SET name = ?, email = ?,phone = ?, country_id = ?, state_id = ?, city_id = ?,profile_picture=?  WHERE id = ?",
    [name, email, phone, country_id, state_id, city_id,filename, id],
    (err, res) => {
      result(null, id);
      return;  
    }
  );
};

Users.findUserDetail = (user_id, result) => {
  sql.query(`SELECT u.*,u.profile_picture as current_image,c.name as country_name,s.name as state_name,t.name as city_name FROM buyers as u 
  LEFT JOIN countries c ON c.id = u.country_id
  LEFT JOIN states s ON s.id = u.state_id
  LEFT JOIN cities t ON t.id = u.city_id
  WHERE u.id = ${user_id} `, (err, res) => {
  result(null, res[0]);
  return;  
  });
};

Users.UserLogout = (id, result) => {
  sql.query(
    "UPDATE buyers SET device_type = ?, device_token = ?  WHERE id = ?",
    ['0', '', id],
    (err, res) => {
      result(null, id);
      return;  
    }
  );
};

Users.addressDefaultSet = (user_id, result) => {
  sql.query(`SELECT * FROM buyers WHERE id = ${user_id}`, (err, res) => {
  result(null, res[0]);
  return;  
  });
};

Users.setDefaultAddress = (user_id,address_id, result) => {
  sql.query(
    "UPDATE buyers SET address_id=?  WHERE id = ?",
    [address_id, user_id],
    (err, res) => {
      result(null, user_id);
      return;  
    }
  );
};


module.exports = Users;
