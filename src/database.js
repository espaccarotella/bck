const mysql = require('mysql');

const mysqlConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'Pipo',
    database: 'todo',
    multipleStatements: 'true'
});

mysqlConnection.connect( (err) => {
    if(err){
        console.log(err);
        return;
    }
    else{console.log('Db is connected');}
});

module.exports = mysqlConnection;