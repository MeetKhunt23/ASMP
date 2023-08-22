const express = require("express");
const bodyParser = require("body-parser");
const file = require("./app/routes/file");
const app = express();
global.nodeSiteUrl = 'http://localhost:5000/'; // node  
// parse requests of content-type - application/json
app.use(bodyParser.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

// simple route
app.get("/", (req, res) => {
  res.json({ message: "Welcome to SMP application." });
});

require("./app/routes/page.js")(app);
require("./app/routes/users.js")(app);
require("./app/routes/seller_product.js")(app);
require("./app/routes/category.js")(app);
require("./app/routes/product.js")(app);

app.use("/file", file);
// set port, listen for requests
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});