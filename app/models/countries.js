const sql = require("./db.js");

// constructor
const Countries = function(countries) {
  this.sortname = countries.sortname;
  this.name = countries.name;
  this.phonecode = countries.phonecode;
};


Countries.countries = result => {
  sql.query("SELECT * FROM countries", (err, res) => {
    result(null, res);
  });
};

Countries.states = (id, result) => {
  sql.query(`SELECT * FROM states WHERE country_id = ${id}`, (err, res) => {
  result(null, res);
  return;  
  });
};

Countries.cities = (state_id, result) => {
  sql.query(`SELECT * FROM cities WHERE state_id = ${state_id}`, (err, res) => {
  result(null, res);
  return;  
  });
};
module.exports = Countries;
