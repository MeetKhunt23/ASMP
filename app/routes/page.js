module.exports = app => {
  const page = require("../controllers/page.js");
  app.get("/page/termsandcondition", page.termsandcondition);
  app.get("/page/privacypolicy", page.privacypolicy);
};
