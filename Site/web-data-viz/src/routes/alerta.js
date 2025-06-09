const express = require("express");
const router = express.Router();
const alertaController = require("../controllers/alertaController");

router.get("/ranking", alertaController.obterRanking);
router.get("/historico", alertaController.obterHistorico); 
router.put('/resolver/:idAlerta', alertaController.resolverAlerta);
router.get("/grafico/:idDuto/:periodo", alertaController.graficoAlertas);
router.get("/buscarDutos", alertaController.obterDutos);
router.get("/sensores", alertaController.listarSensoresComDuto);
router.get("/ultimos10dias/:idSensor", alertaController.alertasUltimos10Dias);

module.exports = router;
