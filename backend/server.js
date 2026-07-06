const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

const JWT_SECRET = process.env.JWT_SECRET || 'scretecode';

// DB CONNECTION 
const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 3306,
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'itboomi',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

const db = pool.promise();

// REGISTER 
app.post('/api/auth/register', async (req, res) => {
  try {
    const { firstName, email, password, city } = req.body;

    if (!firstName || !email || !password || !city) {
      return res.status(400).json({ message: 'All fields are required' });
    }

    const normalizedEmail = email.trim().toLowerCase();

    const [existing] = await db.query(
      'SELECT id FROM users WHERE email = ?',
      [normalizedEmail]
    );

    if (existing.length > 0) {
      return res.status(409).json({ message: 'Email already registered' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const [result] = await db.query(
      'INSERT INTO users (first_name, email, password, city) VALUES (?, ?, ?, ?)',
      [firstName.trim(), normalizedEmail, hashedPassword, city.trim()]
    );

    const token = jwt.sign({ id: result.insertId }, JWT_SECRET, {
      expiresIn: '7d',
    });

    return res.status(201).json({
      message: 'Registered successfully',
      token,
      user: {
        id: result.insertId,
        firstName: firstName.trim(),
        email: normalizedEmail,
        city: city.trim(),
      },
    });
  } catch (err) {
    console.error('Register error:', err);
    return res.status(500).json({ message: 'Server error during registration' });
  }
});

// LOGIN 
app.post('/api/auth/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ message: 'Email and password are required' });
    }

    const normalizedEmail = email.trim().toLowerCase();

    const [rows] = await db.query(
      'SELECT * FROM users WHERE email = ?',
      [normalizedEmail]
    );

    if (rows.length === 0) {
      return res.status(401).json({ message: 'Invalid email or password' });
    }

    const user = rows[0];
    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      return res.status(401).json({ message: 'Invalid email or password' });
    }

    const token = jwt.sign({ id: user.id }, JWT_SECRET, { expiresIn: '7d' });

    return res.status(200).json({
      message: 'Login successful',
      token,
      user: {
        id: user.id,
        firstName: user.first_name,
        email: user.email,
        city: user.city,
      },
    });
  } catch (err) {
    console.error('Login error:', err);
    return res.status(500).json({ message: 'Server error during login' });
  }
});

// ---------- GET ALL PROFILES ----------
app.get('/api/auth/profiles', async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT id, first_name, email, city FROM users ORDER BY created_at DESC'
    );

    const profiles = rows.map((row) => ({
      id: row.id,
      firstName: row.first_name,
      email: row.email,
      city: row.city,
    }));

    return res.status(200).json({ profiles });
  } catch (err) {
    console.error('Fetch profiles error:', err);
    return res.status(500).json({ message: 'Server error fetching profiles' });
  }
});

app.get('/', (req, res) => {
  res.send('API is running');
});

const PORT = process.env.PORT || 5000;


app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on http://0.0.0.0:${PORT}`);
});