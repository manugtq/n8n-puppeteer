# Usar Debian como base
FROM debian:bookworm-slim

# Instalar Node.js, npm y dependencias de Puppeteer/Chromium
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    ca-certificates \
    wget \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends \
    nodejs \
    chromium-browser \
    chromium-driver \
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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalar Puppeteer globalmente
RUN npm install -g puppeteer

# Instalar N8N globalmente
RUN npm install -g n8n

# Crear usuario para N8N
RUN useradd -m -u 1000 n8n

# Crear directorio de datos
RUN mkdir -p /home/n8n/.n8n && \
    chown -R n8n:n8n /home/n8n

# Cambiar a usuario n8n
USER n8n
WORKDIR /home/n8n

# Variables de entorno
ENV NODE_ENV=production
ENV N8N_PERSISTENCE_POSTGRESDB_HOST=postgres
ENV N8N_PERSISTENCE_POSTGRESDB_PORT=5432
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=false
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Exponer puerto
EXPOSE 5678

# Comando de inicio
CMD ["n8n", "start"]
