const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database');

router.get('/tasks', (req, res) => {
    mysqlConnection.query('SELECT * FROM tasks ORDER by folder', (err, rows, fields) => {
        if(!err){
            res.json(rows);
        }
        else{console.log(err);}
    });
});

router.get('/tasks/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM tasks WHERE id = ?', [id], (err, rows, fields) => {
        if(!err){
            res.json(rows);
        }
        else{console.log(err);}
    });
});

router.post('/tasks', (req, res) => {
    const { id, description, folder, complete } = req.body;
    const query = `
        SET @id = ?;
        SET @description = ?;
        SET @folder = ?;
        SET @complete = ?;
        CALL tasksAddOrEdit(@id, @description, @folder, @complete);
    `;
    mysqlConnection.query(query, [id, description, folder, complete], (err, rows, fields) => {
        if(!err){
            res.json({status: true});
        }
        else{console.log(err);}
    });
});

router.put('/tasks/:id', (req, res) => {
    const { description, folder, complete } = req.body;
    const { id } = req.params;
    const query = `
        SET @id = ?;
        SET @description = ?;
        SET @folder = ?;
        SET @complete = ?;
        CALL tasksAddOrEdit(@id, @description, @folder, @complete);
    `;
    mysqlConnection.query(query, [id, description, folder, complete], (err, rows, fields) =>{
        if(!err){
            res.json({status: 'Task updated'});
        }
        else{console.log(err);}
    });
});

router.delete('/tasks/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('DELETE FROM tasks WHERE id = ?', [id], (err, rows, fields) =>{
        if(!err){
            res.json({status: 'Task deleted'});
        }
        else{console.log(err);}
    });
});

module.exports = router;