# Usar la imagen base de N8N
FROM n8nio/n8n:latest

# Cambiar a root para instalar dependencias
USER root

# Instalar dependencias del sistema para Puppeteer y Chrome
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libcurl4 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libicu67 \
    libjpeg-turbo-progs \
    libjpeg62-turbo \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libpng16-16 \
    libpulse0 \
    libsecret-1-0 \
    libssl3 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    lsb-release \
    xdg-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalar Puppeteer globalmente y configurar para usar Chrome del sistema
RUN npm install -g puppeteer && \
    npm config set unsafe-perm true

# Crear archivo de configuración para permitir Puppeteer en Code nodes
RUN mkdir -p /home/node/.n8n/nodes && \
    echo '{"allowedModules": ["puppeteer", "cheerio", "axios"]}' > /home/node/.n8n/allowlist.json

# Variable de entorno para permitir módulos custom en Code nodes
ENV N8N_CODE_EXECUTE_TIMEOUT=300

# Volver al usuario de n8n
USER node

# Exponer puerto
EXPOSE 5678

# Comando de inicio
CMD ["n8n"]
