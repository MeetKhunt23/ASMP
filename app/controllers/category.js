const Category = require("../models/category.js");

exports.allCategory = (req, res) => {
  Category.allCategory((err, data) => {

    var newCats = [];
    catData = data;
    catData.forEach(function(data){
      var obj ={};
      obj['id'] = data.id; 
      obj['name'] = data.name; 
      obj['image'] = nodeSiteUrl+'file/category/'+data.image; 
      newCats.push(obj);      
    });

    return res.send({
         success:"yes",
         message: "",
         data: newCats
    });
  });
};

exports.addPreference = (req, res) => {
    const { user_id, category_ids} = req.body;
    let errors = '';
    if (!user_id) {
      errors = 'User id is required.';
    }

    if (errors.length > 0) {

      return res.send({
           success:"no",
           message: errors,
           data: req.body
      });
    }

    const id = user_id;
    Category.SelectCategory(id,category_ids,(err, update) => {
        return res.send({
           success:"yes",
           message: 'Preference added successfully.',
           data:  req.body 
        })
    })

};