# Use the official Node.js image based on Alpine
FROM node:20.18.0-alpine3.20

# Set the working directory
WORKDIR /app

# Install Subversion
RUN apk add --no-cache subversion

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

EXPOSE 3000

CMD ["npm", "run", "start"]