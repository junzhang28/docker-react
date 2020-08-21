FROM node:alpine

WORKDIR '/app'

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx

EXPOSE 80

# Copy /app/build (where all built files stored after "npm run build")
# from previous phase "builder" to nginx's default folder
COPY --from=0 /app/build /usr/share/nginx/html

# nginx will start automatically