# N8N con Puppeteer

Imagen customizada de N8N que incluye Puppeteer para convertir HTML a PNG en Code nodes.

## Features

✅ N8N últimas versión
✅ Puppeteer incluido y configurado
✅ Chrome/Chromium preinstalado
✅ Módulos permitidos: puppeteer, cheerio, axios
✅ Optimizado para convertir HTML → PNG

## Deploy en Railway

1. Conecta este repo a Railway
2. Selecciona este Dockerfile
3. Agrega las variables de entorno (igual que tu N8N actual)
4. Deploy

## Uso en N8N

En un Code node, puedes usar:

```javascript
const puppeteer = require('puppeteer');

const browser = await puppeteer.launch({
  headless: true,
  args: ['--no-sandbox']
});

const page = await browser.newPage();
await page.setViewport({ width: 1080, height: 1350 });
await page.setContent(htmlContent);
const screenshot = await page.screenshot({ type: 'png' });
await browser.close();

return { base64: screenshot.toString('base64') };
```

## Autor

Manuel - Abril 2026
