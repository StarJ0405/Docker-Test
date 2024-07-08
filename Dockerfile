FROM node:20.15.0 as builder
WORKDIR /frontend
COPY ./frontend/package*.json /frontend/
RUN npm install
COPY /frontend/. /frontend/
RUN npm run build
CMD ["npm", "run", "start"]
