require('dotenv').config();
const express = require('express');
const path = require('path');
const cors = require('cors');
const app = express();

const router = require('./routers');

const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/api', router);

app.listen(port, () => {
    console.log(`Sunucu port ${port} üzerinde çalışıyor...`);
});