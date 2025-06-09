function mudarChat(){
    if(chat.style.height == '0px'){
        chat.style.height = '400px';
    } else {
        chat.style.height = '0px';
    }
}

async function gerarResposta() {
    const pergunta = document.getElementById('pergunta').value;

    const response = await fetch('/bobia/perguntar', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ pergunta })
    });

    const data = await response.json();

    msg_content.innerHTML = `
        <div class="msg usuario">
            <h3>Você</h3>
            ${pergunta}
        </div>
        <div class="msg ia">
            <h3>BobIA</h3>
            ${data.resultado}
        </div>
    `
}