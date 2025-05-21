const database = require('../database/config'); // Assume que você tem a configuração do banco

// Função para obter os dutos e seus sensores
function obterDutosESensores() {
    const query = `
        SELECT D.idDuto, D.diametro, S.idSensor, S.inicioDuto
        FROM Duto D
        JOIN Sensor S ON D.idDuto = S.fkDuto
    `;
    
    return database.executar(query); // Retorna a promessa do banco
}

module.exports = {
    obterDutosESensores
};
