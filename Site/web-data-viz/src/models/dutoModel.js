const database = require('../database/config');

function obterDutosSensoresEAlertas() {
    const query = `
       SELECT 
            s.idSensor,
            s.inicioDuto,
            s.fkDuto AS idDuto,
            d.diametro,
            COALESCE(COUNT(a.idAlerta), 0) AS qtdAlertasSemana
        FROM Sensor s
        JOIN Duto d ON s.fkDuto = d.idDuto
        LEFT JOIN DadosSensor ds 
            ON ds.fkSensor = s.idSensor
        AND WEEK(ds.dtRegistro, 1) = WEEK(CURDATE(), 1) 
        AND YEAR(ds.dtRegistro) = YEAR(CURDATE())
        LEFT JOIN Alerta a 
            ON a.fkDadoSensor = ds.idDado
        GROUP BY s.idSensor;
    `;

    return database.executar(query);
}

module.exports = {
    obterDutosSensoresEAlertas
};
