const router = require('express').Router();
const { getHomePage, getTestEndpoint, getProducts, getDealers, getCities } = require('../controllers/controller');

router.get('/', getHomePage);
router.get('/test', getTestEndpoint);
router.get('/urunler', getProducts);
router.get('/bayiler', getDealers);
router.get('/sehirler', getCities);

module.exports = router;