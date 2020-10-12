const fs = require("fs");
const mysql = require("mysql");

let streamGestion = fs.readFileSync("../gestion.sql").toString();

module.exports = {
    gestion: function () {
    const connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    multipleStatements: true
  });
    connection.connect(error => {
        if (error) {
          console.error(error);
        } else {
          connection.query(streamGestion, (error, response) => {
            console.log(error || response)
        });
        }
      });
 }
};