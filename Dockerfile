FROM node:14-alpine
WORKDIR /app
COPY index.js .
ENTRYPOINT [ "node", "index" ]