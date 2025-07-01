FROM ollama/ollama:latest
USER root

# Install wget (or curl)
RUN apt-get update \
 && apt-get install -y wget \
 && rm -rf /var/lib/apt/lists/*

# Copy in our startup script
COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

# Make it the ENTRYPOINT
ENTRYPOINT ["/usr/local/bin/startup.sh"]
