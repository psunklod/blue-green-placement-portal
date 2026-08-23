FROM nginx:alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy Blue v1.0 web application
COPY index.html /usr/share/nginx/html/index.html

# Expose HTTP port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
