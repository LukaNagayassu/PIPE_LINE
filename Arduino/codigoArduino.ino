#include "Ultrasonic.h" // Puxando a biblioteca Ultrasonic.h

const int PINO_TRIGGER = 12; // Esta definindo trigger como uma constante (valor fixo)
const int PINO_ECHO = 13; // Recebe o sinal mandado pelo Trigger
float distanciaMax = 200.0;
float distanciaMin = 20.0;

HC_SR04 sensor(PINO_TRIGGER, PINO_ECHO); // Criando a classe HC_SR04 com os pinos de Trigger e Echo

void setup() {
  Serial.begin(9600); // Configuração e inicialização da comunicação serial a 9600 bps
}

void loop() {
  float distancia = sensor.distance(); // Leitura da distância do sensor

  // Envia as variáveis no formato 'nome=valor', necessário para o Serial Plotter
  
  Serial.print(distancia); // Valor da distância
  Serial.println(";");
  delay(1000); // Pausa de 1 segundo antes de uma nova leitura
}