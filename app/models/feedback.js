const sql = require("./db.js");

// constructor
const Feedback = function(feedback) {
  this.seller_id = feedback.seller_id;
  this.user_id = feedback.user_id;
  this.product_id = feedback.product_id;
  this.seller_feedback = feedback.seller_feedback;
};

Feedback.create = (feedbackData, result) => {
  sql.query("INSERT INTO feedback SET ?", feedbackData, (err, res) => {
    result(null, res.insertId);
    return; 
  });
};

Feedback.get_feedback = (user_id, result) => {
    sql.query(`SELECT * FROM feedback
    WHERE seller_id = ${user_id} ORDER BY id DESC`, 
    (err, res) => {
    result(null, res);
    return;  
    });
}

Feedback.dashboard_details = (user_id, result) => {

    sql.query(`SELECT count(id) as total_products FROM products
    WHERE sellers_id = ${user_id}`, 
    (err, res) => {
        var returnArray ={};
        if(res[0])
        {
            var row =  res[0];  
            returnArray['total_products'] = row.total_products;
           
            sql.query(`SELECT count(o.id) as total_orders,SUM(o.total_price) as total_revenue FROM products as p,order_details as o WHERE sellers_id = ${user_id} AND o.product_id=p.id AND o.status !=4`, 
            (err, products) => {
               if(products[0])
               {
                  var pro =  products[0]; 
                  returnArray['total_orders'] = pro.total_orders;
                  if(pro.total_revenue == null)
                  {
                    returnArray['total_revenue'] = 0;
                  }
                  else
                  {
                    returnArray['total_revenue'] = pro.total_revenue;
                  }
               }
               else
               {
                  returnArray['total_orders'] = 0;
                  returnArray['total_revenue'] = 0;
               }
               
               
               sql.query(`SELECT count(id) as total_feedback FROM feedback WHERE seller_id = ${user_id}`, 
                (err, feedback) => {
                   if(feedback[0])
                   {
                      var fb =  feedback[0]; 
                      returnArray['total_feedback'] = fb.total_feedback;
                   }
                   else
                   {
                      returnArray['total_feedback'] = 0;
                   }
                   result(null, returnArray);
                   return;
                })
            })
        }
        else
        {
            result(null, returnArray);
            return;
        }
    });
}


module.exports = Feedback;
