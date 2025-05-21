const database = require("../database/config");

function buscarSensoresDoDuto(dutoId) {
    const query = `SELECT idSensor FROM Sensor WHERE fkDuto = ${dutoId};`;
    return database.executar(query);
}

function buscarUltimoDadoTempoReal(sensor1, sensor2) {
    const query = `
        SELECT *
        FROM (
            SELECT 
                dtRegistro, 
                fkSensor, 
                distancia AS valor
            FROM DadosSensor
            WHERE fkSensor = ${sensor1}
            ORDER BY dtRegistro DESC
            LIMIT 1
        ) AS dado1
        UNION
        SELECT *
        FROM (
            SELECT 
                dtRegistro, 
                fkSensor, 
                distancia AS valor
            FROM DadosSensor
            WHERE fkSensor = ${sensor2}
            ORDER BY dtRegistro DESC
            LIMIT 1
        ) AS dado2;
    `;
    return database.executar(query);
}

function buscarMetricas(sensor1, sensor2, tempo) {
    let query = "";

    if (tempo === "Horas do Dia") {
        query = `
            SELECT 
                HOUR(dtRegistro) AS label,
                fkSensor,
                ROUND(AVG(distancia), 2) AS media
            FROM DadosSensor
            WHERE fkSensor IN (${sensor1}, ${sensor2})
              AND DATE(dtRegistro) = CURDATE()
            GROUP BY label, fkSensor
            ORDER BY label;
        `;
    } else if (tempo === "Dias da Semana") {
        query = `
            SELECT 
                DAYNAME(dtRegistro) AS label,
                fkSensor,
                ROUND(AVG(distancia), 2) AS media
            FROM DadosSensor
            WHERE fkSensor IN (${sensor1}, ${sensor2})
            GROUP BY label, fkSensor
            ORDER BY FIELD(label, 'Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
        `;
    }

    return database.executar(query);
}

module.exports = {
    buscarSensoresDoDuto,
    buscarUltimoDadoTempoReal,
    buscarMetricas
};
