const path = require('path');
const db = require('../db/mysql_connect');

const getHomePage = (req, res) => {
    res.sendFile(path.join(__dirname, '../public/index.html'));
};

const getTestEndpoint = (req, res) => {
    res.json({
        message: "Connection successful!",
        status: "Project is working according to the teacher's desired structure."
    });
};

const getProducts = async (req, res) => {
    try {
        const [salesRows] = await db.execute("SELECT *, 'Satis' as status FROM satis_urunleri");
        const [launchRows] = await db.execute("SELECT *, 'Lansman' as status FROM lansman_urunleri");
        
        res.json([...salesRows, ...launchRows]);
    } catch (error) {
        console.error('Database Error:', error);
        res.status(500).json({ message: "A database error occurred." });
    }
};

const getDealers = async (req, res) => {
    try {
        const sql = `
            SELECT d.id, d.bayi_adi, c.sehir_adi as city, d.satis_miktari, d.kar_miktari, d.durum 
            FROM bayiler d
            JOIN sehirler c ON d.sehir_id = c.id
        `;
        const [rows] = await db.execute(sql);
        res.json(rows);
    } catch (error) {
        console.error('Database Error:', error);
        res.status(500).json({ message: "A database error occurred." });
    }
};

const getCities = async (req, res) => {
    try {
        const [rows] = await db.execute('SELECT * FROM sehirler');
        res.json(rows);
    } catch (error) {
        console.error('Database Error:', error);
        res.status(500).json({ message: "A database error occurred." });
    }
};

module.exports = {
    getHomePage,
    getTestEndpoint,
    getProducts,
    getDealers,
    getCities
};