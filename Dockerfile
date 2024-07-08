FROM node:20.15.0 as builder
WORKDIR /frontend
COPY ./frontend/package*.json /frontend/
COPY ./frontend/run.sh /frontend/
RUN npm install
COPY /frontend/. /frontend/
RUN npm run build
WORKDIR /
COPY run.sh run.sh
#CMD ["/run.sh"]