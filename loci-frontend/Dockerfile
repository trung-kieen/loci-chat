FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
# TODO: fix bug on ci
# RUN npm ci
COPY . .
RUN npm run build -- --configuration=production

FROM nginx:alpine
# copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist/loci-frontend /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
