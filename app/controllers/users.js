const strtotime = require("strtotime");
const Phone = require("../models/verify_phone.js");
const Users = require("../models/users.js");
const Sellers = require("../models/sellers.js");
const Countries = require("../models/countries.js");
const Address = require("../models/address.js");
const Feedback = require("../models/feedback.js");
// Create and Save a new Customer

exports.countries = (req, res) => {
  Countries.countries((err, data) => {
    return res.send({
      success: "yes",
      message: "",
      data: data,
    });
  });
};

exports.states = (req, res) => {
  const { country_id } = req.body;
  let errors = "";

  if (!country_id) {
    errors = "Country is required.";
  }

  if (errors.length > 0) {
    return res.send({
      success: "no",
      message: errors,
      data: [],
    });
  }

  Countries.states(country_id, (err, data) => {
    if (data) {
      return res.send({
        success: "yes",
        message: "",
        data: data,
      });
    }
  });
};

exports.cities = (req, res) => {
  const { state_id } = req.body;
  let errors = "";

  if (!state_id) {
    errors = "state is required.";
  }

  if (errors.length > 0) {
    return res.send({
      success: "no",
      message: errors,
      data: [],
    });
  }

  Countries.cities(state_id, (err, data) => {
    if (data) {
      return res.send({
        success: "yes",
        message: "",
        data: data,
      });
    }
  });
};

exports.send_otp = (req, res) => {
  const { phone, user_type } = req.body;
  let errors = "";

  if (!phone) {
    errors = "Phone is required.";
  }
  if (!user_type) {
    errors = "User type is required.";
  }

  if (errors.length > 0) {
    return res.send({
      success: "no",
      message: errors,
      data: [],
    });
  }

  var otp = "000000";

  Phone.findByPhone(phone, user_type, (err, data) => {
    if (data) {
      const id = data.id;
      Phone.updateById(id, otp, (err, data) => {
        return res.send({
          success: "yes",
          message: "Your OTP has been sent successfully.",
          data: "",
        });
      });
    } else {
      const phoneData = new Phone({
        phone: phone,
        verification_code: otp,
        verified: "0",
        user_type: user_type,
      });

      Phone.create(phoneData, (err, data) => {
        return res.send({
          success: "yes",
          message: "Your OTP has been sent successfully.",
          data: "",
        });
      });
    }
  });
};

exports.otpVerify = (req, res) => {
  let errors = "";
  var user_type = req.body.user_type;

  if (!user_type) {
    errors = "user type is required.";
  }

  if (errors.length > 0) {
    return res.send({
      success: "no",
      message: errors,
      data: [],
    });
  }

  if (user_type == 0) {
    const { phone, code, user_type, device_type, device_token } = req.body;
    Phone.findPhoneVerify(phone, user_type, code, (err, data) => {
      if (data) {
        Phone.findPhone(phone, (err, user) => {
          if (user) {
            var status = 0;
            if (
              user.name != "" &&
              user.email != "" &&
              user.country_id != 0 &&
              user.state_id != 0 &&
              user.city_id != 0
            ) {
              var status = 1;
            }

            const id = user.id;
            Phone.updateByIdUser(
              id,
              device_type,
              device_token,
              (err, update) => {
                Phone.remove(data.id, (err, data1) => {});

                var userData = {};
                userData["phone"] = user.phone;
                userData["verification_code"] = code;
                userData["isRegister"] = status;
                userData["user_id"] = user.id;
                //console.log(userData);return false;

                return res.send({
                  success: "yes",
                  message: "",
                  data: userData,
                });
              }
            );
          } 
          else {
            const phoneData = new Users({
              name: "",
              email: "",
              phone: phone,
              country_id: 0,
              state_id: 0,
              city_id: 0,
              device_type: device_type,
              device_token: device_token,
            });

            Users.createUser(phoneData, (err, UserCreate) => {
              Phone.remove(data.id, (err, data1) => {});
              Phone.findPhone(phone, (err, user) => {
                if (user) {
                  var userData = {};
                  userData["phone"] = user.phone;
                  userData["verification_code"] = code;
                  userData["isRegister"] = 0;
                  userData["user_id"] = user.id;

                  return res.send({
                    success: "yes",
                    message: "",
                    data: userData,
                  });
                }
              });
            });
          }
        });
      } else {
        return res.send({
          success: "no",
          message:
            "Verification code incorrect, please enter correct verification code.",
          data: [],
        });
      }
    });
  } else {
    const { phone, code, user_type, device_type, device_token } = req.body;

    Phone.findPhoneVerify(phone, user_type, code, (err, data) => {
      if (data) {
        Sellers.findPhoneSellers(phone, (err, user) => {
          if (user) {
            var status = 0;
            if (
              user.name != "" &&
              user.email != "" &&
              user.country_id != 0 &&
              user.state_id != 0 &&
              user.city_id != 0
            ) {
              var status = 1;
            }
            user["isRegister"] = status;
            const id = user.id;
            Sellers.updateByIdSeller(
              id,
              device_type,
              device_token,
              (err, update) => {
                Phone.remove(data.id, (err, data1) => {});
                return res.send({
                  success: "yes",
                  message: "",
                  data: user,
                });
              }
            );
          } else {
            const phoneData = new Sellers({
              name: "",
              email: "",
              phone: phone,
              country_id: 0,
              state_id: 0,
              city_id: 0,
              device_type: device_type,
              device_token: device_token,
            });

            Sellers.createSeller(phoneData, (err, UserCreate) => {
              Phone.remove(data.id, (err, data1) => {});
              Sellers.findPhoneSellers(phone, (err, userField) => {
                userField["isRegister"] = 0;
                if (userField) {
                  return res.send({
                    success: "yes",
                    message: "",
                    data: userField,
                  });
                }
              });
            });
          }
        });
      } else {
        return res.send({
          success: "no",
          message:
            "Verification code incorrect, please enter correct verification code.",
          data: [],
        });
      }
    });
  }
};

exports.profile_update = (req, res) => {
  let errors = "";
  var user_type = req.body.user_type;

  if (!user_type) {
    errors = "user type is required.";
  }

  if (errors.length > 0) {
    return res.send({
      success: "no",
      message: errors,
      data: req.body,
    });
  }

  if (user_type == 0) {
    const {
      user_id,
      name,
      email,
      phone,
      country_id,
      state_id,
      city_id,
      user_type,
      current_image,
    } = req.body;

    var cimg = "";
    if (current_image != undefined && current_image != "") {
      cimg = current_image;
    }
    

    if (!user_id) {
      errors = "User id is required.";
    } else if (!name) {
      errors = "Name is required.";
    } else if (!email) {
      errors = "Email is required.";
    } else if (!phone) {
      errors = "Phone is required.";
    } else if (!country_id) {
      errors = "Country id required.";
    } else if (!state_id) {
      errors = "State is required.";
    } else if (!city_id) {
      errors = "City id is required.";
    }

    if (errors.length > 0) {
      return res.send({
        success: "no",
        message: errors,
        data: req.body,
      });
    }

    // if (!req.files || Object.keys(req.files).length === 0) {
    //     return res.send({
    //        error:"yes",
    //        message: 'Profile picture is required.',
    //        data: []
    //     });
    // }

    Users.findPhoneExits(phone, user_id, (err, data) => {
      if (data) {
        return res.send({
          success: "no",
          message: "Phone already exist.",
          data: req.body,
        });
      } else {
        Users.CheckEmail(email, user_id, (err, emailData) => {
          if (emailData) {
            return res.send({
              success: "no",
              message: "Email already exist.",
              data: req.body,
            });
          } else {
            //var date = new Date();
            // console.log(strtotime(date));return false;

            if (!req.files || Object.keys(req.files).length === 0) {
              var filename = cimg;
            } else {
              let profilePic = req.files.profile_picture;
              var filename = profilePic.name;
              var uploadPath = "uploads/profile_pictures/" + filename;
              profilePic.mv(uploadPath, function (err) {});
            }

            const id = user_id;
            Users.updateByIdUser(
              id,
              name,
              email,
              phone,
              country_id,
              state_id,
              city_id,
              filename,
              (err, update) => {
                return res.send({
                  success: "yes",
                  message: "Profile is updated successfully.",
                  data: req.body,
                });
              }
            );
          }
        });
      }
    });
  } else {
    const {
      user_id,
      name,
      email,
      phone,
      country_id,
      state_id,
      city_id,
      user_type,
      current_image,
    } = req.body;

    var cimg = "";
    if (current_image != undefined && current_image != "") {
      cimg = current_image;
    }

    if (!user_id) {
      errors = "User id is required.";
    } else if (!name) {
      errors = "Name is required.";
    } else if (!email) {
      errors = "Email is required.";
    } else if (!phone) {
      errors = "Phone is required.";
    } else if (!country_id) {
      errors = "Country id required.";
    } else if (!state_id) {
      errors = "State is required.";
    } else if (!city_id) {
      errors = "City id is required.";
    }

    if (errors.length > 0) {
      return res.send({
        success: "no",
        message: errors,
        data: req.body,
      });
    }

    Sellers.findPhoneExits(phone, user_id, (err, data) => {
      if (data) {
        return res.send({
          success: "no",
          message: "Phone already exist.",
          data: req.body,
        });
      } else {
        Sellers.CheckEmail(email, user_id, (err, emailData) => {
          if (emailData) {
            return res.send({
              success: "no",
              message: "Email already exist.",
              data: req.body,
            });
          } else {
            if (!req.files || Object.keys(req.files).length === 0) {
              var filename = cimg;
            } else {
              let profilePic = req.files.profile_picture;
              var filename = profilePic.name;
              var uploadPath = "uploads/profile_pictures/" + filename;
              profilePic.mv(uploadPath, function (err) {});
            }

            const id = user_id;
            Sellers.updateByIdUser(
              id,
              name,
              email,
              phone,
              country_id,
              state_id,
              city_id,
              filename,
              (err, update) => {
                return res.send({
                  success: "yes",
                  message: "Profile is updated successfully.",
                  data: req.body,
                });
              }
            );
          }
        });
      }
    });
  }
};

exports.userinfo = (req, res) => {
  const { user_id, user_type } = req.body;
  let errors = "";
  if (!user_id) {
    errors = "User id is required.";
  } else if (!user_type) {
    errors = "User type is required.";
  }

  if (errors.length > 0) {
    return res.send({
      success: "no",
      message: errors,
      data: [],
    });
  }

  if (user_type == 0) {
    Users.findUserDetail(user_id, (err, userField) => {
      userField["current_image"] =
        nodeSiteUrl + "file/users/" + userField.current_image;
      return res.send({
        success: "yes",
        message: "",
        data: userField,
      });
    });
  } else {
    Sellers.findUserDetail(user_id, (err, userField) => {
      userField["current_image"] =
        nodeSiteUrl + "file/users/" + userField.current_image;
      return res.send({
        success: "yes",
        message: "",
        data: userField,
      });
    });
  }
};
exports.logout = (req, res) => {
  const { user_id, user_type } = req.body;  
  let errors = "";
  if (!user_id) {
    errors = "User id is required.";
  } else if (!user_type) {
    errors = "User type is required.";
  }

  if (errors.length > 0) {
    return res.send({
      success: "no",
      message: errors,
      data: [],
    });
  }

  if (user_type == 0) {
    const id = user_id;
    Users.UserLogout(id, (err, update) => {
      return res.send({
        success: "yes",
        message: "User logout successfully.",
        data: [],
      });
    });
  } else {
    const id = user_id;
    Sellers.UserLogout(id, (err, update) => {
      return res.send({
        success: "yes",
        message: "User logout successfully.",
        data: [],
      });
    });
  }
};

exports.add_or_edit_address = (req, res) => {
  const {
    user_id,
    address_one,
    address_two,
    pincode,
    city_id,
    state_id,
    country_id,
    latitude,
    longitude,
    address_id,
  } = req.body;

  let errors = "";
  if (!user_id) {
    errors = "User id is required.";
  } else if (!address_one) {
    errors = "Address one is required.";
  } else if (!pincode) {
    errors = "Pincode is required.";
  } else if (!city_id) {
    errors = "City id is required.";
  } else if (!state_id) {
    errors = "State id is required.";
  } else if (!country_id) {
    errors = "Country id is required.";
  } else if (!latitude) {
    errors = "Latitude is required.";
  } else if (!longitude) {
    errors = "Longitude is required.";
  }

  if (errors.length > 0) {
    return res.send({
      success: "no",
      message: errors,
      data: [],
    });
  }
    
  if (address_id != undefined && address_id != "") {
    Address.updateAddress(
      user_id,
      address_one,
      address_two,
      pincode,
      city_id,
      state_id,
      country_id,
      latitude,
      longitude,
      address_id,
      (err, updata) => {
        var obj = {};
        obj["user_id"] = user_id;
        obj["address_one"] = address_one;
        obj["address_two"] = address_two;
        obj["pincode"] = pincode;
        obj["city_id"] = city_id;
        obj["state_id"] = state_id;
        obj["country_id"] = country_id;
        obj["latitude"] = latitude;
        obj["longitude"] = longitude;
        obj["address_id"] = address_id;

        return res.send({
          success: "yes",
          message: "Address updated successfully.",
          data: obj,
        });
      }
    );
  } else {
    Address.addressExist(user_id, latitude, longitude, (err, address) => {
      if (address) {
        return res.send({
          success: "no",
          message: "Address already exists.",
          data: address,
        });
      } else {
        const addressData = new Address({
          user_id: user_id,
          address_one: address_one,
          address_two: address_two,
          pincode: pincode,
          city: city_id,
          state: state_id,
          country: country_id,
          latitude: latitude,
          longitude: longitude,
        });

        Address.addressAdd(addressData, (err, addAddress) => {
          var obj = {};
          obj["user_id"] = user_id;
          obj["address_one"] = address_one;
          obj["address_two"] = address_two;
          obj["pincode"] = pincode;
          obj["city_id"] = city_id;
          obj["state_id"] = state_id;
          obj["country_id"] = country_id;
          obj["latitude"] = latitude;
          obj["longitude"] = longitude;
          obj["address_id"] = addAddress;

          Users.addressDefaultSet(user_id, (err, UserDetail) => {
            if (UserDetail.address_id == 0) {
              Users.setDefaultAddress(user_id, addAddress, (err, updata) => {});
            }

            return res.send({
              success: "yes",
              message: "Address add successfully.",
              data: obj,
            });
          });
        });
      }
    });
  }
};

exports.getAddressListing = (req, res) => {
  const { user_id } = req.body;

  let errors = "";
  if (!user_id) {
    errors = "User id is required.";
  }

  if (errors.length > 0) {
    return res.send({
      success: "no",
      message: errors,
      data: [],
    });
  }

  Address.get_address(user_id, (err, address) => {
    if (address.length > 0) {
      var newAdd = [];
      var addressData = address;
      addressData.forEach(function (pro) {
        var obj = {};
        obj["id"] = pro.id;
        obj["user_id"] = pro.user_id;
        obj["address_one"] = pro.address_one;
        obj["address_two"] = pro.address_two;
        obj["city"] = pro.city;
        obj["state"] = pro.state;
        obj["country"] = pro.country;
        obj["latitude"] = pro.latitude;
        obj["longitude"] = pro.longitude;
        obj["created_at"] = pro.created_at;
        obj["is_default_address"] = pro.is_default_address;
        obj["pincode"] = pro.pincode;
        newAdd.push(obj);
      });

      return res.send({
        success: "yes",
        message: "",
        data: newAdd,
      });
    } else {
      return res.send({
        success: "no",
        message: "",
        data: [],
      });
    }
  });
};

exports.set_default_address = (req, res) => {
  const { user_id, address_id } = req.body;

  let errors = "";
  if (!user_id) {
    errors = "User id is required.";
  } else if (!address_id) {
    errors = "Address id is required.";
  }

  if (errors.length > 0) {
    return res.send({
      success: "no",
      message: errors,
      data: [],
    });
  }

  Address.userUpdateAddress(user_id, address_id, (err, updata) => {
    var obj = {};
    obj["address_id"] = address_id;
    return res.send({
      success: "yes",
      message: "Address updated successfully.",
      data: obj,
    });
  });
};

exports.delete_address = (req, res) => {
  const { user_id, address_id } = req.body;

  let errors = "";
  if (!user_id) {
    errors = "User id is required.";
  } else if (!address_id) {
    errors = "Address id is required.";
  }

  if (errors.length > 0) {
    return res.send({
      success: "no",
      message: errors,
      data: [],
    });
  }

  Address.remove(address_id, (err, data1) => {
    Address.get_default_address(user_id, (err, address) => {
      if (address) {
        Address.userUpdateAddress(user_id, address.id, (err, updata) => {
          var obj = {};
          obj["user_id"] = user_id;
          obj["address_id"] = address_id;
          return res.send({
            success: "yes",
            message: "Address deleted successfully.",
            data: obj,
          });
        });

      } else {
        Address.userUpdateAddress(user_id, 0, (err, updata) => {
          var obj = {};
          obj["user_id"] = user_id;
          obj["address_id"] = address_id;
          return res.send({
            success: "yes",
            message: "Address deleted successfully.",
            data: obj,
          });
        });
      }
    });
  });
};

exports.post_feedback = (req, res) => {
  const { seller_id, user_id, product_id, seller_feedback } = req.body;
  let errors = "";

  if (!seller_id) {
    errors = "Seller id is required.";
  } else if (!user_id) {
    errors = "User id is required.";
  } else if (!product_id) {
    errors = "Product id is required.";
  } else if (!seller_feedback) {
    errors = "Feedback is required.";
  }

  if (errors.length > 0) {
    return res.send({
      success: "no",
      message: errors,
      data: [],
    });
  }

  const feedData = new Feedback({
    seller_id: seller_id,
    user_id: user_id,
    product_id: product_id,
    seller_feedback: seller_feedback,
  });

  Feedback.create(feedData, (err, data) => {
    return res.send({
      success: "yes",
      message: "Feedback post successfully.",
      data: "",
    });
  });
};

exports.feedback_list = (req, res) => {
  const { user_id } = req.body;

  let errors = "";
  if (!user_id) {
    errors = "User id is required.";
  }

  if (errors.length > 0) {
    return res.send({
      success: "no",
      message: errors,
      data: [],
    });
  }

  Feedback.get_feedback(user_id, (err, feedbackData) => {
    if (feedbackData.length > 0) {
      var newAdd = [];
      fdData = feedbackData;
      fdData.forEach(function (pro) {
        var obj = {};
        obj["id"] = pro.id;
        obj["user_id"] = pro.user_id;
        obj["seller_id"] = pro.seller_id;
        obj["product_id"] = pro.product_id;
        obj["seller_feedback"] = pro.seller_feedback;
        newAdd.push(obj);
      });

      return res.send({
        success: "yes",
        message: "",
        data: newAdd,
      });
    } else {
      return res.send({
        success: "no",
        message: "",
        data: [],
      });
    }
  });
};

exports.dashboard_details = (req, res) => {
  const { user_id } = req.body;

  let errors = "";
  if (!user_id) {
    errors = "User id is required.";
  }

  if (errors.length > 0) {
    return res.send({
      success: "no",
      message: errors,
      data: [],
    });
  }

    Feedback.dashboard_details(user_id, (err, data) => {
      return res.send({
        success: "yes",
        message: "",
        data: data,
      });
    });
};
