# Use official Nginx base image for serving static content
FROM nginx:alpine

# Clean the default html directory
RUN rm -rf /usr/share/nginx/html/*

# Copy the React production build into Nginx html directory
COPY build/ /usr/share/nginx/html/

# Expose port 80 to allow web traffic
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
