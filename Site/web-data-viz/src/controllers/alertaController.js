const alertaModel = require("../models/alertaModel");

function obterRanking(req, res) {
    alertaModel.obterRankingSensoresSemana()
        .then(resultado => res.json(resultado))
        .catch(erro => {
            console.error("Erro ao obter ranking de alertas:", erro);
            res.status(500).send("Erro ao obter ranking");
        });
}

function obterHistorico(req, res) {
    alertaModel.obterHistoricoDiaAtual()
        .then(resultado => res.json(resultado))
        .catch(erro => {
            console.error("Erro ao obter histórico de alertas:", erro);
            res.status(500).send("Erro ao obter histórico");
        });
}

function resolverAlerta(req, res) {
    const { idAlerta } = req.params;
    
    alertaModel.marcarComoResolvido(idAlerta)
        .then(() => res.send("Alerta resolvido com sucesso"))
        .catch(error => {
            console.error("Erro ao resolver alerta:", error);
            res.status(500).send("Erro ao resolver alerta");
        });
}

function graficoAlertas(req, res){
    const { idDuto, periodo } = req.params;

    alertaModel.graficoAlertas(idDuto, periodo)
        .then(resultado => res.json(resultado))
        .catch(erro => {
            console.error("Erro no controller de gráfico:", erro);
            res.status(500).json({ erro: "Erro ao buscar dados de alerta para gráfico" });
        });

}


async function obterDutos(req, res) {
    try {
        const resultado = await alertaModel.listarDutos();
        res.json(resultado);
    } catch (erro) {
        console.error('Erro ao obter dutos:', erro);
        res.status(500).json({ erro: 'Erro ao buscar dutos' });
    }
}


module.exports = {
    obterRanking,
    obterHistorico,
    resolverAlerta,
    graficoAlertas,
    obterDutos
};

