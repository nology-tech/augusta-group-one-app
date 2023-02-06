const http = require('http');
const PORT = process.env.PORT || 5550;

const app = require('./app');

const server = http.createServer(app);

server.listen(PORT);
