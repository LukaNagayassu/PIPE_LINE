var database = require("../database/config");


function listar() {
  var instrucaoSql = `SELECT idEmpresa, razaoSocial, cnpj, codigo_ativacao FROM Empresa`;

  return database.executar(instrucaoSql);
}


module.exports = { listar };
