const dutoModel = require('../models/dutoModel');

// Função que busca os dados dos dutos e sensores e envia para o front-end
function obterDutos(req, res) {
    dutoModel.obterDutosESensores()
        .then(result => {
            // Retorna os dados em formato JSON para o front-end
            res.json(result); 
        })
        .catch(error => {
            console.error("Erro ao obter dutos e sensores:", error);
            res.status(500).send("Erro no servidor");
        });
}

module.exports = {
    obterDutos
};
