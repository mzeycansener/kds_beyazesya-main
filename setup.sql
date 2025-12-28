-- 1. Veritabanını Oluştur ve Seç
CREATE DATABASE IF NOT EXISTS beyazesya_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE beyazesya_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS bayi_stok;
DROP TABLE IF EXISTS satis_urunleri;
DROP TABLE IF EXISTS lansman_urunleri;
DROP TABLE IF EXISTS bayiler;
DROP TABLE IF EXISTS urunler;
DROP TABLE IF EXISTS sehirler;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE sehirler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sehir_adi VARCHAR(100) NOT NULL,
    nufus VARCHAR(50),
    yas_ortalamasi DECIMAL(4, 1),
    gelir_duzeyi VARCHAR(50),
    iklim VARCHAR(50),
    lat DECIMAL(10, 6),
    lon DECIMAL(10, 6),
    resim_yolu VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE urunler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    urun_adi VARCHAR(255) NOT NULL,
    tur VARCHAR(50) NOT NULL,
    olusturulma_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE bayiler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bayi_adi VARCHAR(255) NOT NULL,
    sehir_id INT,
    satis_miktari DECIMAL(15, 2),
    kar_miktari DECIMAL(15, 2),
    durum VARCHAR(50),
    olusturulma_tarihi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sehir_id) REFERENCES sehirler(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE satis_urunleri (
    id INT AUTO_INCREMENT PRIMARY KEY,
    urun_id INT,
    marka VARCHAR(100),
    fiyat DECIMAL(10, 2),
    enerji_sinifi VARCHAR(10),
    stok_adedi INT DEFAULT 0,
    teknoloji_puani INT DEFAULT 0,
    pazar_doygunlugu INT DEFAULT 0,
    kategori VARCHAR(50),
    resim_yolu VARCHAR(255),
    FOREIGN KEY (urun_id) REFERENCES urunler(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE lansman_urunleri (
    id INT AUTO_INCREMENT PRIMARY KEY,
    urun_id INT,
    marka VARCHAR(100),
    fiyat DECIMAL(10, 2),
    enerji_sinifi VARCHAR(10),
    stok_adedi INT DEFAULT 0,
    teknoloji_puani INT DEFAULT 0,
    pazar_doygunlugu INT DEFAULT 0,
    kategori VARCHAR(50),
    resim_yolu VARCHAR(255),
    FOREIGN KEY (urun_id) REFERENCES urunler(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE bayi_stok (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bayi_id INT,
    urun_id INT,
    stok_adedi INT,
    FOREIGN KEY (bayi_id) REFERENCES bayiler(id) ON DELETE CASCADE,
    FOREIGN KEY (urun_id) REFERENCES urunler(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO sehirler (sehir_adi, nufus, yas_ortalamasi, gelir_duzeyi, iklim, lat, lon, resim_yolu) VALUES
('İstanbul', '15.8 Milyon', 32.4, 'Yüksek', 'Ilıman', 41.0082, 28.9784, 'img/istanbul.jpg'),
('Ankara', '5.7 Milyon', 34.1, 'Orta-Yüksek', 'Karasal', 39.9334, 32.8597, 'img/ankara.jpg'),
('İzmir', '4.4 Milyon', 36.8, 'Orta', 'Akdeniz', 38.4237, 27.1428, 'img/izmir.jpg'),
('Bursa', '3.1 Milyon', 33.5, 'Orta-Yüksek', 'Ilıman', 40.1885, 29.0610, 'img/bursa.jpg'),
('Antalya', '2.6 Milyon', 35.2, 'Yüksek', 'Akdeniz', 36.8969, 30.7133, 'img/antalya.jpg'),
('Adana', '2.2 Milyon', 29.8, 'Orta', 'Akdeniz', 37.0000, 35.3213, 'img/adana.jpg'),
('Trabzon', '816 Bin', 31.5, 'Orta', 'Karadeniz', 41.0027, 39.7168, 'img/trabzon.jpg'),
('Gaziantep', '2.1 Milyon', 26.4, 'Düşük-Orta', 'Karasal', 37.0662, 37.3833, 'img/gaziantep.jpg'),
('Konya', '2.2 Milyon', 30.1, 'Orta', 'Karasal', 37.8714, 32.4846, 'img/konya.jpg'),
('Diyarbakır', '1.8 Milyon', 24.5, 'Düşük', 'Karasal', 37.9144, 40.2306, 'img/diyarbakir.jpg'),
('Afyon', '730 Bin', 34.5, 'Orta', 'Karasal', 38.7569, 30.5387, 'img/afyon.jpg'),
('Sivas', '630 Bin', 33.0, 'Orta', 'Karasal', 39.7477, 37.0179, 'img/sivas.jpg'),
('Samsun', '1.3 Milyon', 32.0, 'Orta', 'Karadeniz', 41.2867, 36.3300, 'img/samsun.jpg');

INSERT INTO bayiler (bayi_adi, sehir_id, satis_miktari, kar_miktari, durum) VALUES
('İstanbul Merkez Bayi', 1, 5000000.00, 1250000.00, 'iyi'),
('Ankara Bölge Bayi', 2, 2000000.00, 440000.00, 'iyi'),
('İzmir Şube', 3, 1500000.00, 450000.00, 'iyi'),
('Bursa Yetkili Satıcı', 4, 1200000.00, 336000.00, 'orta'),
('Antalya Premium Bayi', 5, 1800000.00, 630000.00, 'iyi'),
('Gaziantep Ticaret', 8, 800000.00, 144000.00, 'kotu'),
('Konya Dağıtım', 9, 950000.00, 190000.00, 'orta'),
('Samsun Şube', 13, 1100000.00, 264000.00, 'orta'),
('Trabzon Merkez', 7, 750000.00, 150000.00, 'orta'),
('Diyarbakır Şube', 10, 600000.00, 100000.00, 'kotu'),
('Afyon Ana Bayi', 11, 500000.00, 90000.00, 'iyi');

INSERT INTO urunler (urun_adi, tur) VALUES 
('Eco-Smart Bulaşık Makinesi', 'Satis'),
('No-Frost XL Buzdolabı', 'Satis'),
('Hibrit Kurutma Makinesi', 'Satis'),
('Inverter Klima 18000 BTU', 'Satis'),
('Air Fryer XXL', 'Satis'),
('4K Ultra HD Smart TV 55"', 'Satis'),
('Buhar Kazanlı Ütü', 'Satis'),
('Dikey Şarjlı Süpürge', 'Satis'),
('Ankastre Fırın Seti', 'Satis'),
('Akıllı Panel Isıtıcı', 'Satis'),
('Hava Nemlendirici', 'Satis'),
('Robot Süpürge S7', 'Satis'),
('QLED TV 65"', 'Satis');

INSERT INTO urunler (urun_adi, tur) VALUES 
('Akıllı Robot Süpürge V2', 'Lansman'),
('Endüstriyel Tipi Klima', 'Lansman');

INSERT INTO satis_urunleri (urun_id, marka, fiyat, enerji_sinifi, stok_adedi, teknoloji_puani, pazar_doygunlugu, kategori, resim_yolu) VALUES
(1, 'Bosch', 12500.00, 'A+++', 320, 9, 40, 'Beyaz Eşya', 'img/bulasik.jpg'),
(2, 'Beko', 18500.00, 'A++', 800, 7, 85, 'Soğutma', 'img/buzdolabi.jpg'),
(3, 'Samsung', 16000.00, 'A++', 150, 8, 20, 'Yıkama/Kurutma', 'img/kurutma.jpg'),
(4, 'Vestel', 22000.00, 'A++', 450, 8, 60, 'İklimlendirme', 'img/klima.jpg'),
(5, 'Philips', 4500.00, 'A', 600, 9, 30, 'Küçük Ev Aletleri', 'img/airfryer.jpg'),
(6, 'Samsung', 28500.00, 'G', 150, 8, 70, 'Elektronik', 'img/tv.jpg'),
(7, 'Philips', 6500.00, 'A', 300, 7, 50, 'Küçük Ev Aletleri', 'img/utu.jpg'),
(8, 'Dyson', 18000.00, 'A++', 120, 9, 40, 'Küçük Ev Aletleri', 'img/supurge.jpg'),
(9, 'Arçelik', 14500.00, 'A', 200, 6, 80, 'Pişirme', 'img/firin.jpg'),
(10, 'Xiaomi', 3200.00, 'A', 150, 7, 30, 'Isıtma', 'img/isitici.jpg'),
(11, 'Philips', 4500.00, 'A+', 80, 8, 20, 'İklimlendirme', 'img/nemlendirici.jpg'),
(12, 'Roborock', 18000.00, 'A+++', 200, 9, 55, 'Küçük Ev Aletleri', 'img/robot.jpg'),
(13, 'Sony', 55000.00, 'G', 100, 10, 75, 'Elektronik', 'img/qled.jpg');

INSERT INTO lansman_urunleri (urun_id, marka, fiyat, enerji_sinifi, stok_adedi, teknoloji_puani, pazar_doygunlugu, kategori, resim_yolu) VALUES
(14, 'Xiaomi', 14000.00, 'A+', 0, 9, 10, 'Küçük Ev Aletleri', 'img/airfryer.jpg'),
(15, 'Mitsubishi', 85000.00, 'A++', 0, 10, 5, 'İklimlendirme', 'img/klima.jpg');

INSERT INTO bayi_stok (bayi_id, urun_id, stok_adedi) VALUES 
(1, 1, 50), (1, 2, 30), (1, 4, 100), 
(2, 3, 40), (2, 4, 20),
(3, 4, 80), (3, 2, 25),
(5, 4, 120), (5, 2, 40),
(6, 3, 50),
(7, 1, 20), (7, 5, 60),
(8, 3, 30),
(1, 6, 45), (1, 7, 60),
(2, 8, 25), (2, 9, 30),
(3, 6, 30),
(5, 7, 40),
(6, 9, 15),
(2, 10, 60), (7, 10, 80), (8, 10, 50),
(1, 11, 40), (3, 11, 35),
(1, 12, 100), (2, 12, 50), (5, 12, 60),
(1, 13, 20), (5, 13, 15), (3, 13, 10),
(1, 14, 5),
(9, 1, 12), (9, 4, 25),
(10, 3, 60), (10, 2, 5),
(11, 5, 15), (11, 1, 10);