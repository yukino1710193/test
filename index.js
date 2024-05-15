const http = require("http");

const server = http.createServer((req, res) => {
  res.end("Hello kube 3001\n")
});

server.listen(3001, () => {
  console.log("Server listen on port 3001")
})