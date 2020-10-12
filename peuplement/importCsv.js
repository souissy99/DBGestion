const fs = require("fs");
const mysql = require("mysql");
const fastcsv = require("fast-csv");

module.exports = {
  import: function () {
    let csvImport = [
      "user.csv",
      "scooter.csv",
      "worker.csv",
      "subscription.csv",
      "location2.csv",
      "location.csv",
      "rental.csv",
      "usersubscription.csv",
      "repair.csv"
  ];
  
  csvImport.forEach(e => {
      let stream = fs.createReadStream(e);
      let csvData = [];
      let csvStream = fastcsv
        .parse()
        .on("data", function(data) {
          csvData.push(data);
        })
        .on("end", function() {
          // remove the first line: header
          csvData.shift();
      
          // create a new connection to the database
          const connection = mysql.createConnection({
            host: "localhost",
            user: "root",
            password: "",
            database: "mydb"
          });
      
          // open the connection
          connection.connect(error => {
            if (error) {
              console.error(error);
            } else {
              let query;
              switch (stream.path) {
                  case "user.csv":
                      query = "INSERT INTO user (idUser, firstName, lastName, email, number) VALUES ?";
                  break;
  
                  case "scooter.csv":
                      query = "INSERT INTO scooter (idScooter, needCharge, needRepair) VALUES ?";
                  break;
              
                  case "worker.csv":
                      query = "INSERT INTO worker (idWorker, firstName, lastName, email, number) VALUES ?";
                  break;
  
                  case "subscription.csv":
                      query = "INSERT INTO subcription (idSubcription, title, description, price) VALUES ?";
                  break;
  
                  case "usersubscription.csv":
                      query = "INSERT INTO usersubscribtion (idUserSubscribtion, idUserSub, idSub) VALUES ?";
                  break;
  
                  case "location.csv":
                      query = "INSERT INTO location (idLocation, lat, lng, idUserLocation) VALUES ?";
                  break;
  
                  case "location2.csv":
                    query = "INSERT INTO location (idLocation, lat, lng, idScooterLocation) VALUES ?";
                  break;
              
                  case "rental.csv":
                    query = "INSERT INTO rental (idRental, startAt, idUserRental, idScooterRental) VALUES ?";
                  break;
  
                  case "repair.csv":
                    query = "INSERT INTO repair (idRepair, idScooterRepair, idWorkerRepair) VALUES ?";
                  break;
              }
              connection.query(query, [csvData], (error, response) => {
                if (response)
                  console.log(response);
                  console.log("Data already insert")
                if (error) {
                  if (error.code != "ER_DUP_ENTRY")
                  console.log(error);
                }
              });
            }
          });
        }); 
        stream.pipe(csvStream); 
  });
  }
};
