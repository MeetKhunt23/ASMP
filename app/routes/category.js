module.exports = app => {
  const category = require("../controllers/category.js");
  app.get("/category/allCategory", category.allCategory);
  app.post("/category/addPreference", category.addPreference);  
  
};
