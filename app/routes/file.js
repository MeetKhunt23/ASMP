// Filename : user.js
const express = require("express");
const path = require("path");
const router = express.Router();

router.get("/category/:filename", (req, res) => {
  res.sendFile(path.join(__dirname, "../../uploads/category/"+req.params.filename));
});

router.get("/users/:filename", (req, res) => {
  res.sendFile(path.join(__dirname, "../../uploads/profile_pictures/"+req.params.filename));
});

router.get("/product/:filename", (req, res) => {
  res.sendFile(path.join(__dirname, "../../uploads/product/"+req.params.filename));
});

module.exports = router;