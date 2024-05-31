const redis = require("redis");

const client = redis.createClient("redis://redis:6379")

client.on("connect", () => {
  console.log("Connect redis success");
})