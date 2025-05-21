const dashModel = require("../models/dashModel");

async function buscarMetricas(req, res) {
    const dutoId = req.query.duto;
    const tempo = req.query.tempo;

    try {
        const sensores = await dashModel.buscarSensoresDoDuto(dutoId);

        if (sensores.length < 2) {
            return res.status(400).json({ erro: "Menos de dois sensores encontrados" });
        }

        const sensor1 = sensores[0].idSensor;
        const sensor2 = sensores[1].idSensor;

        const dados = await dashModel.buscarMetricas(sensor1, sensor2, tempo);

        res.json({
            sensor1,
            sensor2,
            dados
        });

    } catch (erro) {
        console.error("Erro ao buscar métricas:", erro);
        res.status(500).send("Erro interno ao buscar métricas.");
    }
}

async function buscarDadoTempoReal(req, res) {
    const dutoId = req.query.duto;

    try {
        const sensores = await dashModel.buscarSensoresDoDuto(dutoId);
        if (sensores.length < 2) {
            return res.status(400).json({ erro: "Menos de dois sensores encontrados" });
        }

        const sensor1 = sensores[0].idSensor;
        const sensor2 = sensores[1].idSensor;

        const dados = await dashModel.buscarUltimoDadoTempoReal(sensor1, sensor2);

        res.json(dados);
    } catch (erro) {
        console.error("Erro ao buscar dados em tempo real:", erro);
        res.status(500).send("Erro interno ao buscar tempo real.");
    }
}

async function buscarSensoresDoDuto(req, res) {
    const dutoId = req.query.duto;
    try {
        const sensores = await dashModel.buscarSensoresDoDuto(dutoId);
        if (sensores.length < 2) {
            return res.status(400).json({ erro: "Menos de dois sensores encontrados" });
        }

        const sensor1 = sensores[0].idSensor;
        const sensor2 = sensores[1].idSensor;

        res.json({ sensor1, sensor2 });
    } catch (erro) {
        console.error("Erro ao buscar sensores:", erro);
        res.status(500).send("Erro interno ao buscar sensores.");
    }
}

module.exports = {
    buscarMetricas,
    buscarDadoTempoReal,
    buscarSensoresDoDuto
};
