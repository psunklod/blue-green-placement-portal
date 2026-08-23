FROM nginx:alpine

# Copy default Blue routing configuration
COPY nginx-blue.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
