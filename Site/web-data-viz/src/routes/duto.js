const express = require('express');
const router = express.Router();
const dutoController = require('../controllers/dutoController');

// Rota para buscar os dutos e sensores
router.get('/dutos', dutoController.obterDutos);

module.exports = router;
