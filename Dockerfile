FROM ghcr.io/danny-avila/librechat-dev:latest

# Copia as configurações da AIDA para dentro da imagem oficial
COPY aida-config.yaml /app/librechat.yaml

# Substitui as logos do LibreChat e branding pela AIDA
COPY aida-logo.svg /app/client/public/assets/logo.svg
COPY aida-logo.svg /app/client/dist/assets/logo.svg
COPY client/public/assets/aida-og.png /app/client/dist/assets/aida-og.png
COPY client/public/assets/aida-og.png /app/client/public/assets/aida-og.png

# Injeta o branding no index.html PRÉ-COMPILADO e recria o PWA Manifest
RUN node -e "\
const fs = require('fs');\
const path = '/app/client/dist/index.html';\
let html = fs.readFileSync(path, 'utf8');\
html = html.replace(/<title>.*<\/title>/, '<title>AIDA — Aprenda Inglês por Imersão Ativa</title>');\
html = html.replace(/<meta name=\"description\".*?>/, '<meta name=\"description\" content=\"AIDA — Aprenda inglês por imersão ativa com tutores de IA. Sem aulas chatas, sem gramática decorada. Conversação real desde o primeiro dia.\" />');\
html = html.replace(/assets\/favicon-32x32\.png/g, 'assets/logo.svg');\
html = html.replace(/assets\/favicon-16x16\.png/g, 'assets/logo.svg');\
html = html.replace(/assets\/apple-touch-icon-180x180\.png/g, 'assets/logo.svg');\
const ogTags = \`<meta property=\"og:title\" content=\"AIDA — Aprenda Inglês por Imersão Ativa\" />\n    <meta property=\"og:image\" content=\"https://aida.experiasolutions.com.br/assets/aida-og.png\" />\n    <meta property=\"og:description\" content=\"Converse com tutores de IA especializados e aprenda inglês do jeito que o cérebro foi feito para aprender — por imersão.\" />\n    <meta name=\"twitter:card\" content=\"summary_large_image\" />\n    <meta name=\"twitter:image\" content=\"https://aida.experiasolutions.com.br/assets/aida-og.png\" />\n\`;\
html = html.replace('</head>', ogTags + '</head>');\
fs.writeFileSync(path, html);\
\
const manifestPath = '/app/client/dist/manifest.webmanifest';\
const manifest = {\
  name: 'AIDA',\
  short_name: 'AIDA',\
  description: 'Aprenda Inglês por Imersão Ativa',\
  start_url: './',\
  display: 'standalone',\
  background_color: '#0d0d0d',\
  theme_color: '#8b5cf6',\
  lang: 'pt-BR',\
  scope: './',\
  icons: [\
    { src: 'assets/logo.svg', sizes: '192x192', type: 'image/svg+xml' },\
    { src: 'assets/logo.svg', sizes: '512x512', type: 'image/svg+xml', purpose: 'maskable' }\
  ]\
};\
fs.writeFileSync(manifestPath, JSON.stringify(manifest));\
"

# Variáveis padrão
ENV HOST=0.0.0.0
ENV PORT=8080
EXPOSE 8080

CMD ["npm", "run", "backend"]
