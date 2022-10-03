
#Using longterm support latest node alpine image
FROM node:18-alpine
# Create app directory
WORKDIR /usr/src/app
# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available
COPY package*.json ./
# If you are building your code for production otherwise RUN npm install
RUN npm install
#RUN npm ci --only=production
# Bundle app source
COPY . .
#Since the app runs on port 3000 exposing it
EXPOSE 3000
CMD [ "node", "server.js" ]