const SellerProduct = require("../models/sellers_product.js");
const ProductImage = require("../models/product_image.js");
var empty = require('is-empty');

exports.addproduct = (req, res) => {
  const {user_id,product_name,description,category_id,country_id,state_id,city_id,price,selling_price,exp_delivery_time} = req.body;
  
  let errors = '';
   
  if (!user_id) {
    errors = 'User id is required.';
  }
  else if (!product_name) {
    errors = 'Product name is required.';
  }
  else if (!description) {
    errors = 'Description is required.';
  }
  else if (!category_id) {
    errors = 'category id is required.';
  }
  else if (!country_id) {
    errors = 'Country id is required.';
  }
  else if (!state_id) {
    errors = 'State id is required.';
  }
  else if (!city_id) {
    errors = 'City id is required.';
  }
  else if (!price) {
    errors = 'Price id is required.';
  }
  else if (!selling_price) {
    errors = 'Selling price id is required.';
  }
  else if (!exp_delivery_time) {
    errors = 'Exp delivery time id is required.';
  }


  if (errors.length > 0) {

    return res.send({
         success:"no",
         message: errors,
         data: []
    });
  }
   //console.log(req.body);return false;
  const Product = new SellerProduct({
      sellers_id:user_id,
      name:product_name,
      description:description,
      category_id:category_id,
      country_id:country_id,
      state_id:state_id,
      city_id:city_id,
      price:price,
      selling_price:selling_price,
      expected_delivery_time:exp_delivery_time
    });
    //console.log(Product);return false;
    SellerProduct.productAdd(Product, (err, data) => {

        var obj = {};
        obj['product_id'] = data;
        return res.send({
         success:"yes",
         message: 'product added successfully.',
         data: obj
    });
    });
};

exports.updateproduct = (req, res) => {
  const {product_id,user_id,product_name,description,category_id,country_id,state_id,city_id,price,selling_price,exp_delivery_time} = req.body;
  
  let errors = '';
  
  if (!product_id) {
    errors = 'Productid is required.';
  }
  else if (!user_id) {
    errors = 'User id is required.';
  }
  else if (!product_name) {
    errors = 'Product name is required.';
  }
  else if (!description) {
    errors = 'Description is required.';
  }
  else if (!category_id) {
    errors = 'category id is required.';
  }
  else if (!country_id) {
    errors = 'Country id is required.';
  }
  else if (!state_id) {
    errors = 'State id is required.';
  }
  else if (!city_id) {
    errors = 'City id is required.';
  }
  else if (!price) {
    errors = 'Price id is required.';
  }
  else if (!selling_price) {
    errors = 'Selling price id is required.';
  }
  else if (!exp_delivery_time) {
    errors = 'Exp delivery time id is required.';
  }


  if (errors.length > 0) {

    return res.send({
         success:"no",
         message: errors,
         data: []
    });

  }

  SellerProduct.updateProduct(product_id,user_id,product_name,description,category_id,country_id,state_id,city_id,price,selling_price,exp_delivery_time,(err, update) => {
      return res.send({
         success:"yes",
         message: 'Product updated successfully.',
         data:  [] 
      })
  })
};

exports.addproductimage = (req, res) => {

const {product_id} = req.body;
  
  let errors = '';
   
  if (!product_id) {
    errors = 'Product id is required.';
  }
  else if (!req.files || Object.keys(req.files).length === 0) 
  {
      errors = 'product image is required.';
  }
  if (errors.length > 0) {

    return res.send({
         success:"no",
         message: errors,
         data: []
    });
  }

    let productPic = req.files.product_image;
    var filename = productPic.name;
    var uploadPath = "uploads/product/"+filename
    productPic.mv(uploadPath, function(err) {
    })

    const images = new ProductImage({
      product_id:product_id,
      image:filename
    });

    ProductImage.productImageAdd(images, (err, data) => {
          
        if(data !="")
        {
          var obj = {};
          obj['image_id'] = data;
            return res.send({
                 success:"yes",
                 message: 'product image added successfully.',
                 data: obj
            });
        }
        else
        {
            return res.send({
                 success:"no",
                 message: 'error',
                 data: obj
            });
        }
    })

}

exports.removeImage = (req, res) => {
    const {image_id} = req.body;
    let errors = '';

    if (!image_id) {
      errors = 'Image id is required.';
    }
  
    if (errors.length > 0) {

      return res.send({
           success:"no",
           message: errors,
           data: []
      });
    }
    ProductImage.remove(image_id, (err, data1) => {
        return res.send({
               success:"yes",
               message: 'product image delete successfully.',
               data: []
          });
    });
};

exports.seller_product_listing = (req, res) => {
  const { user_id,filter_type,category_id,search_text,page} = req.body;

  let errors = '';
 
  if (!user_id) {
    errors = 'User id is required.';
  }
  else if (!page) {
    errors = 'page is required.';
  }

  if (errors.length > 0) {

    return res.send({
         success:"no",
         message: errors,
         data: []
    });
  }

  var uid=0

  if(user_id !=undefined && user_id !="")
  {
    uid = user_id;
  }
  
  var catid = '';
  if(category_id  !=undefined && category_id !='')
  {
    catid = category_id;
  }

  var searchText = '';
  if(search_text !=undefined && search_text !='')
  {
    searchText = search_text;
  }

  var pages = page;

  var limit = '10';

  if(pages == '')
  {
     pages = 1;
     sp = 0;
  }
  else
  {
     pages = pages;
     sp = (pages-1)*limit;
  }

  SellerProduct.getproductCount(uid,filter_type,catid,searchText, (err, products) => {
      if(products.length > 0)
      {
          var getcount  = products.length;
          var totalpage = Math.ceil(getcount/limit);

          SellerProduct.getproductList(uid,filter_type,catid,searchText,sp,limit, (err, productsdata) => {

               if(productsdata.length > 0)
               {
                    var newCats = [];
                    proData = productsdata;
                    proData.forEach(function(pro){
                      var obj ={};
                      obj['id'] = pro.id; 
                      obj['product_url'] = pro.product_url; 
                      obj['name'] = pro.name; 
                      obj['description'] = pro.description; 
                      obj['avg_rating'] = pro.avg_rating; 
                      obj['total_review'] = pro.total_review; 
                      obj['price'] = pro.price; 
                      obj['image'] = pro.image?pro.image:""; 
                      obj['created_at'] = pro.created_at; 
                      obj['expected_delivery_time'] = pro.expected_delivery_time; 
                      obj['category_name'] = pro.category_name; 
                      obj['category_id'] = pro.category_id; 
                      obj['is_featured'] = pro.is_featured; 
                      obj['selling_products'] = pro.selling_products; 
                      obj['selling_price'] = pro.selling_price; 
                      obj['sellers_id'] = pro.sellers_id; 
                      obj['seller_name'] = pro.seller_name?pro.seller_name:""; 
                      obj['seller_image'] = pro.seller_image?nodeSiteUrl+'file/users/'+pro.seller_image:""; 
                      obj['seller_avg_rating']       = pro.seller_avg_rating?pro.seller_avg_rating:0;
                      obj['seller_total_review']       = pro.seller_total_review?pro.seller_total_review:0;
                      newCats.push(obj);      
                    });

                    return res.send({
                         success:"yes",
                         message: "",
                         data: newCats,
                         total_page: totalpage,
                         page: pages
                    });
               }
               else
                {
                    return res.send({
                         success:"no",
                         message: "",
                         data: []
                    });

                }
          })

      }
      else
      {
        return res.send({
             success:"no",
             message: "",
             data: []
        });
      }
  })
};

exports.seller_product_detail = (req, res) => {
  const { user_id,product_id} = req.body;

  let errors = '';
   
  if (!product_id) {
    errors = 'Product id is required.';
  }

  if (errors.length > 0) {

    return res.send({
         success:"no",
         message: errors,
         data: []
    });
  }

  var uid=0

  if(user_id !=undefined && user_id !="")
  {
    uid = user_id;
  }

  SellerProduct.get_product_detail(uid,product_id, (err, data) => {

    if(data)
    {
        var returnArray = {};
        returnArray['id']                  = data.id; 
        returnArray['product_url']         = data.product_key;
        returnArray['name']                = data.name;
        returnArray['price']               = data.price;
        returnArray['description']         = data.description;
        returnArray['avg_rating']          = data.avg_rating; 
        returnArray['category_id']         = data.category_id;
        returnArray['category_name']       = data.category_name;
        returnArray['total_review']        = data.total_review;
        returnArray['is_featured']         = data.is_featured;
        returnArray['selling_price']       = data.selling_price;
        returnArray['seller_name'] = data.seller_name?data.seller_name:""; 
        returnArray['seller_image'] = data.seller_image?nodeSiteUrl+'file/users/'+data.seller_image:""; 
        returnArray['seller_avg_rating']       = data.seller_avg_rating?data.seller_avg_rating:0;
        returnArray['seller_total_review']       = data.seller_total_review?data.seller_total_review:0;
        returnArray['country_id']                  = data.country_id; 
        returnArray['state_id']                  = data.state_id; 
        returnArray['city_id']                  = data.city_id; 
        returnArray['country_name']                  = data.country_name?data.country_name:""; 
        returnArray['state_name']                  = data.state_name?data.state_name:""; 
        returnArray['city_name']                  = data.city_name?data.city_name:""; 
        returnArray['expected_delivery_time']                  = data.expected_delivery_time; 
        
        SellerProduct.product_review(data.id, (err, review) => {
            if (review.length) 
            {
                returnArray['review'] = review;     
            }
            else
            {
                returnArray['review'] = []; 
            }

            SellerProduct.product_image(data.id, (err, image) => {
                if (image.length) 
                {
                    returnArray['image'] = image;     
                }
                else
                {
                    returnArray['image'] = []; 
                }

                 return res.send({
                     success:"yes",
                     message: '',
                     data: returnArray
                });
            })

        })

       
    }
    else
    {
        return res.send({
             success:"no",
             message: '',
             data: []
        });
    }
   
  })

};


exports.order_detail1 = (req, res) => {
  const { user_id,order_id} = req.body;

  let errors = '';
  if(!user_id)
  {
    errors = 'User id is required.';
  }
  else if(!order_id) {
    errors = 'Order id is required.';
  }


  if (errors.length > 0) {

    return res.send({
         success:"no",
         message: errors,
         data: []
    });
  }

  SellerProduct.order_detail_listing1(user_id,order_id, (err, orderDetail) => {
      if(orderDetail)
      {
          return res.send({
               success:"yes",
               message: '',
               data: orderDetail
          });
      }
      else
      {
           return res.send({
               success:"no",
               message: '',
               data: []
          });
      }
  })

};

exports.product_delete = (req, res) => {
  const { user_id,product_id} = req.body;

  let errors = '';
  if(!user_id)
  {
    errors = 'User id is required.';
  }
  else if(!product_id) {
    errors = 'Product id is required.';
  }


  if (errors.length > 0) {

    return res.send({
         success:"no",
         message: errors,
         data: []
    });
  }

  SellerProduct.remove(user_id,product_id, (err, data1) => {
        return res.send({
               success:"yes",
               message: 'product image delete successfully.',
               data: []
          });
  });


};

exports.orderlisting = (req, res) => {
  const { user_id,page} = req.body;

  let errors = '';
  if(!user_id)
  {
    errors = 'User id is required.';
  }
  else if(!page) {
    errors = 'page is required.';
  }


  if (errors.length > 0) {

    return res.send({
         success:"no",
         message: errors,
         data: []
    });
  }
  
  var pages = page;

  var limit = '10';

  if(pages == '')
  {
     pages = 1;
     sp = 0;
  }
  else
  {
     pages = pages;
     sp = (pages-1)*limit;
  }

  SellerProduct.get_orders_list_count(user_id, (err, data) => {

      if(data.length > 0)
      {
          var getcount  = data.length;
          var totalpage = Math.ceil(getcount/limit);

          SellerProduct.get_orders_list(user_id,sp,limit, (err, orders) => {

              if(orders.length > 0)
              {
                    var newCats = [];
                    proData = orders;
                    proData.forEach(function(pro){
                      var obj ={};
                      
                      obj['order_id'] = pro.order_id; 
                      obj['unique_order_id'] = pro.unique_order_id; 
                      obj['total_shipping'] = pro.total_shipping; 
                      obj['total_price'] = pro.total_price; 
                      obj['order_total'] = pro.total_price; 
                      obj['created_at'] = pro.created_at; 
                      obj['buyer_fullname'] = pro.buyer_fullname; 
                      obj['buyer_email'] = pro.buyer_email; 
                      obj['buyer_phone_number'] = pro.buyer_phone_number; 
                      obj['buyer_profile_picture'] = pro.profile_picture?nodeSiteUrl+'file/users/'+pro.profile_picture:""; 
                      obj['seller_fullname'] = pro.seller_name; 
                      obj['seller_email'] = pro.seller_email; 
                      obj['seller_phone_number'] = pro.seller_phone; 
                      obj['seller_profile_picture'] = pro.seller_profile_picture?nodeSiteUrl+'file/users/'+pro.seller_profile_picture:"";
                      obj['full_address'] = pro.full_address; 

                      obj['status']= pro.product_status; 
                      obj['under_process_date']= pro.under_process_date?pro.under_process_date:""; 
                      obj['dispatched_date']= pro.dispatched_date?pro.dispatched_date:"";
                      obj['received_date']= pro.received_date?pro.received_date:"";  
                      obj['cancelled_date']= pro.received_date?pro.cancelled_date:"";
                      
                      obj['product_id'] = pro.product_id; 
                      obj['product_name'] = pro.product_name; 
                      obj['product_image'] = pro.product_image; 
                      obj['total_product'] = pro.total_product; 
                      if(pro.total_product > 1)
                      {
                        obj['is_more_product'] = 1; 
                      }
                      else
                      {
                        obj['is_more_product'] = 0; 
                      }
                      newCats.push(obj);      
                    });

                    return res.send({
                       success:"yes",
                       message: "",
                       data: newCats,
                       total_page: totalpage,
                       page: pages
                  });
              }
              else
              {
                  return res.send({
                         success:"no",
                         message: "",
                         data: []
                    });
              }
          })

      }
      else
      {
        return res.send({
             success:"no",
             message: "",
             data: []
        });
      }
  })
};

exports.order_detail = (req, res) => {
  const { user_id,order_id} = req.body;

  let errors = '';
  if(!user_id)
  {
    errors = 'User id is required.';
  }
  else if(!order_id) {
    errors = 'Order id is required.';
  }

  if (errors.length > 0) {

    return res.send({
         success:"no",
         message: errors,
         data: []
    });
  }
  SellerProduct.order_detail_listing(user_id,order_id, (err, orderDetail) => {
      if(orderDetail)
      {
          return res.send({
               success:"yes",
               message: '',
               data: orderDetail
          });
      }
      else
      {
           return res.send({
               success:"no",
               message: '',
               data: []
          });
      }
  })
}