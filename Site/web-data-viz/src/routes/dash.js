const express = require("express");
const router = express.Router();
const dashController = require("../controllers/dashController");

router.get("/", dashController.buscarMetricas);
router.get("/sensores", dashController.buscarMetricas);
router.get("/sensor", dashController.buscarSensoresDoDuto);
router.get("/tempo-real", dashController.buscarDadoTempoReal);

module.exports = router;
