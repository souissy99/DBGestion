const fs = require("fs");
const mysql = require("mysql");
const csvImport = require("./importCsv");
const gestion = require("./gestion");

let stream = fs.readFileSync("../createDb.sql").toString();
    const connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    multipleStatements: true
  });

  const sleep = ms => {
    return new Promise(resolve => setTimeout(resolve, ms))
  }

  const promise = new Promise((resolve, reject) => {
    connection.connect(error => {
        if (error) {
          console.error(error);
        } else {
          connection.query(stream, (error, response) => {
            console.log(error || response)
            resolve();
          });
        }
      });
  });

  promise.then(() => {
    for (let i = 1; i < 2; i++) csvImport.import();
  })

  sleep(1000).then(() => {
      gestion.gestion();
  })
