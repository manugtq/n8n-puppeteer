# Usar la imagen base de N8N
FROM n8nio/n8n:latest

USER root

# Instalar dependencias del sistema necesarias para Puppeteer
# La imagen base de N8N usa Alpine Linux, así que usamos apk en lugar de apt-get
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-dejavu \
    tini \
    nodejs \
    npm

# Instalar Puppeteer globalmente
RUN npm install -g puppeteer

# Variables de entorno para Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=false
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Permitir módulos en Code nodes
ENV N8N_CODE_EXECUTION_MODE=own

# Volver al usuario de n8n
USER node

# Exponer puerto
EXPOSE 5678

# Comando de inicio
CMD ["n8n"]
