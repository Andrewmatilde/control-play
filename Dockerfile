FROM alpine:3.19

WORKDIR /app

# Add non root user
RUN adduser -D -g '' appuser

# Copy the pre-built binary
COPY k8s-app .

# Use non root user
USER appuser

# Command to run
CMD ["/app/k8s-app"] 