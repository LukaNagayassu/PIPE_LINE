const dutoModel = require('../models/dutoModel');

function obterDutos(req, res) {
    dutoModel.obterDutosSensoresEAlertas()
        .then(result => res.json(result))
        .catch(error => {
            console.error("Erro ao obter dados:", error);
            res.status(500).send("Erro no servidor");
        });
}

function obterMaxMin(req, res) {
    const idDuto = req.params.idDuto
    dutoModel.obterMaxMin(idDuto)
        .then(result => res.json(result))
        .catch(error => {
            console.error("Erro ao obter dados:", error);
            res.status(500).send("Erro no servidor");
        });
}

module.exports = { obterDutos, obterMaxMin };
