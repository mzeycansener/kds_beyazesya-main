const mysql = require('mysql2/promise');
require('dotenv').config();
const fs = require('fs');
const path = require('path');

async function veritabaniKur() {
    try {
        const connection = await mysql.createConnection({
            host: process.env.DB_HOST,
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            multipleStatements: true
        });

        console.log("MySQL'e bağlanıldı...");

        const sqlDosyasi = path.join(__dirname, 'setup.sql');
        const sqlKomutlari = fs.readFileSync(sqlDosyasi, 'utf8');

        await connection.query(sqlKomutlari);

        console.log("✅ Veritabanı ve tablolar başarıyla oluşturuldu!");
        console.log("Artık 'node app.js' diyerek siteni başlatabilirsin.");

        await connection.end();
    } catch (error) {
        console.error("❌ Kurulum sırasında hata oluştu:", error);
    }
}

veritabaniKur();