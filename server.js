const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const bcrypt = require('bcrypt');
const app = express();
const port = 3000;

app.use(bodyParser.json());

const db = mysql.createConnection({
    host: 'localhost',
    user: 'your_username',
    password: 'your_password',
    database: 'mobilescale'
});

db.connect(err => {
    if (err) throw err;
    console.log('MySQL Connected...');
});

app.post('/register', async (req, res) => {
    const { username, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);
    const sql = 'INSERT INTO users (username, password) VALUES (?, ?)';
    db.query(sql, [username, hashedPassword], (err, result) => {
        if (err) throw err;
        res.send('User registered!');
    });
});

app.post('/login', (req, res) => {
    const { username, password } = req.body;
    const sql = 'SELECT * FROM users WHERE username = ?';
    db.query(sql, [username], async (err, results) => {
        if (err) throw err;
        if (results.length > 0) {
            const user = results[0];
            const isMatch = await bcrypt.compare(password, user.password);
            if (isMatch) {
                res.send('Login successful!');
            } else {
                res.send('Invalid credentials.');
            }
        } else {
            res.send('User not found.');
        }
    });
});

app.get('/items', (req, res) => {
    const sql = 'SELECT items.id, items.name, items.weight, item_categories.name AS category FROM items JOIN item_categories ON items.category_id = item_categories.id';
    db.query(sql, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

app.post('/items', (req, res) => {
    const { name, weight, category_id } = req.body;
    const sql = 'INSERT INTO items (name, weight, category_id) VALUES (?, ?, ?)';
    db.query(sql, [name, weight, category_id], (err, result) => {
        if (err) throw err;
        res.send('Item added!');
    });
});

app.delete('/items/:id', (req, res) => {
    const { id } = req.params;
    const sql = 'DELETE FROM items WHERE id = ?';
    db.query(sql, [id], (err, result) => {
        if (err) throw err;
        res.send('Item deleted!');
    });
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
