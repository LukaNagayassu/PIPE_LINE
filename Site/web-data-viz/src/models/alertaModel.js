const database = require("../database/config");

function obterRankingSensoresSemana() {
    const query = `
        SELECT 
            s.idSensor,
            s.fkDuto,
            SUM(CASE WHEN a.tipoAlerta = 'Vazamento' THEN 1 ELSE 0 END) AS alertaVazamento,
            SUM(CASE WHEN a.tipoAlerta = 'Entupimento' THEN 1 ELSE 0 END) AS alertaEntupimento,
            SUM(CASE 
                WHEN a.tipoAlerta = 'Vazamento' THEN 1 
                WHEN a.tipoAlerta = 'Entupimento' THEN 2 
                ELSE 0 
            END) AS peso
        FROM Alerta a
        JOIN DadosSensor ds ON a.fkDadoSensor = ds.idDado
        JOIN Sensor s ON ds.fkSensor = s.idSensor
        WHERE WEEK(ds.dtRegistro, 1) = WEEK(CURDATE(), 1)
          AND YEAR(ds.dtRegistro) = YEAR(CURDATE())
        GROUP BY s.idSensor
        ORDER BY peso DESC
        LIMIT 3;
    `;
    return database.executar(query);
}

function obterHistoricoDiaAtual() {
    const query = `
        SELECT 
            a.idAlerta,
            a.tipoAlerta,
            a.statusAlerta,
            ds.dtRegistro,
            s.idSensor,
            s.fkDuto
        FROM Alerta a
        JOIN DadosSensor ds ON a.fkDadoSensor = ds.idDado
        JOIN Sensor s ON ds.fkSensor = s.idSensor
        WHERE a.statusAlerta = 'Não resolvido'
        AND DATE(ds.dtRegistro) = CURDATE()
        AND YEAR(ds.dtRegistro) = YEAR(CURDATE())
        ORDER BY ds.dtRegistro DESC;
    `;
    return database.executar(query);
}

function marcarComoResolvido(idAlerta) {
    const query = `
        UPDATE Alerta
        SET statusAlerta = 'Resolvido'
        WHERE idAlerta = ${idAlerta};
    `;
    return database.executar(query);
}

function graficoAlertas(idDuto, periodo) {
    let filtroData = "";

    if (periodo === "dia") {
        filtroData = "DATE(ds.dtRegistro) = CURDATE()";
    } else if (periodo === "semana") {
        filtroData = "WEEK(ds.dtRegistro, 1) = WEEK(CURDATE(), 1) AND YEAR(ds.dtRegistro) = YEAR(CURDATE())";
    } else if (periodo === "mes") {
        filtroData = "MONTH(ds.dtRegistro) = MONTH(CURDATE()) AND YEAR(ds.dtRegistro) = YEAR(CURDATE())";
    }

    const query = `
        SELECT 
            s.idSensor,
            COALESCE(SUM(CASE WHEN a.tipoAlerta = 'Vazamento' THEN 1 ELSE 0 END), 0) AS vazamento,
            COALESCE(SUM(CASE WHEN a.tipoAlerta = 'Entupimento' THEN 1 ELSE 0 END), 0) AS entupimento
        FROM Sensor s
        LEFT JOIN DadosSensor ds ON s.idSensor = ds.fkSensor AND ${filtroData}
        LEFT JOIN Alerta a ON a.fkDadoSensor = ds.idDado
        WHERE s.fkDuto = ${idDuto}
        GROUP BY s.idSensor
        ORDER BY s.idSensor;
    `;

    return database.executar(query);
}

function listarDutos() {
    const instrucao = `SELECT idDuto FROM Duto ORDER BY idDuto`;
    return database.executar(instrucao);
}

module.exports = {
    obterRankingSensoresSemana,
    obterHistoricoDiaAtual,
    marcarComoResolvido,
    graficoAlertas,
    listarDutos
};

