FROM node as builder

WORKDIR /app

COPY package.json /app/package.json

RUN npm install --only=prod

COPY . /app

RUN npm run build

FROM nginx:alpine

COPY ./nginx.config /etc/nginx/nginx.template

CMD ["nginx", "-g", "daemon off;"]

COPY --from=builder /app/build /usr/share/nginx/html