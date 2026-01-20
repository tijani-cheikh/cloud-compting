# Dockerfile minimal pour l'app Node
FROM node:18-alpine

WORKDIR /usr/src/app

COPY package.json package.json
RUN npm ci --only=production

COPY . .

ENV PORT=3000
EXPOSE 3000

CMD ["node", "index.js"]
