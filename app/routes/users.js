module.exports = app => {
  var router = require("express").Router();
  const users = require("../controllers/users.js");
  const fileUpload = require('express-fileupload');
  app.use(fileUpload());
  // Create a new Customer
  app.post("/send_otp", users.send_otp);

  // Retrieve all Customers
  app.post("/otpVerify", users.otpVerify);

  app.get("/countries", users.countries); 

  app.post("/states", users.states);

  app.post("/cities", users.cities);
  app.post("/users/profile_update", users.profile_update);
  app.post("/users/userinfo", users.userinfo);
  app.post("/users/logout", users.logout);
  app.post("/users/add_or_edit_address", users.add_or_edit_address);
  app.post("/users/getAddressListing", users.getAddressListing);      
  app.post("/users/set_default_address", users.set_default_address);
  app.post("/users/delete_address", users.delete_address);
  app.post("/users/post_feedback", users.post_feedback);  
  app.post("/users/feedback_list", users.feedback_list);
  app.post("/users/dashboard_details", users.dashboard_details);
  
  
  
  /*// Retrieve a single Customer with customerId
  app.get("/customers/:customerId", customers.findOne);

  // Update a Customer with customerId
  app.put("/customers/:customerId", customers.update);

  // Delete a Customer with customerId
  app.delete("/customers/:customerId", customers.delete);

  // Create a new Customer
  app.delete("/customers", customers.deleteAll);*/
};
