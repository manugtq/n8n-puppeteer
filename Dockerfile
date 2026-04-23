# Usar la imagen base de N8N
FROM n8nio/n8n:latest

USER root

# Determinar si es Alpine o Debian/Ubuntu e instalar dependencias apropiadas
RUN if [ -f /etc/alpine-release ]; then \
    apk add --no-cache chromium nss freetype harfbuzz ca-certificates ttf-dejavu tini nodejs npm; \
    else \
    apt-get update && apt-get install -y --no-install-recommends \
    chromium-browser \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libpng16-16 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    wget \
    ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*; \
    fi

# Instalar Puppeteer globalmente
RUN npm install -g puppeteer

# Variables de entorno para Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=false

# Permitir módulos en Code nodes
ENV N8N_CODE_EXECUTION_MODE=own

# Volver al usuario de n8n
USER node

# Exponer puerto
EXPOSE 5678

# Comando de inicio
CMD ["n8n"]
