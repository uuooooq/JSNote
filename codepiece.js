this.ws = new WebSocket('ws://127.0.0.1:3000?t=test');
    this.wss = new WebSocketServer({
      port:3000
    })

    this.wss.on('connection',function(ws){
      // wss.broadcast('sdfdsfksdfsfs');
      // ws.send('sdfjskfsfdsfds');
      ws.on('message',function(msg,flags){
        console.log('---------'+msg);
      })

    })

  this.ws.onopen = () => {
    // connection opened
    var str = "{name:'" + 'sdfsd' + "',msg:'" + 'sdfjkdf' + "',key:'" + 'skdflkdf' + "'}"; 
    this.ws.send(str); // send a message
  };
  
  this.ws.onmessage = (e) => {
    // a message was received
    console.log(e.data);
  };
  
  this.ws.onerror = (e) => {
    // an error occurred
    console.log(e.message);
  };
  
  this.ws.onclose = (e) => {
    // connection closed
    console.log(e.code, e.reason);
  };