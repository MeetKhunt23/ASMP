const sql = require("./db.js"); 

// constructor
const Category = function(category) {
  this.name = category.name;
  this.image = category.image;
};

Category.allCategory = result => {
  sql.query(`SELECT id,name,image FROM category ORDER BY name ASC`, (err, res) => {
  result(null, res);
  return;  
  });
};

Category.SelectCategory = (id,category_ids,result) => {
  sql.query(
    "UPDATE buyers SET selected_category = ?  WHERE id = ?",
    [category_ids, id],
    (err, res) => {
      result(null, id);
      return;  
    }
  );
};

module.exports = Category;
