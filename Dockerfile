TEST FROM node:alpine3.18 as build

# Build app
WORKDIR /app
COPY package.json ./
RUN npm install 
COPY . .
RUN npm run build

# Serve stage
FROM nginx:1.23-alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
