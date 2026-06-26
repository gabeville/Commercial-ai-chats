FROM ghcr.io/danny-avila/librechat-dev:latest

# Copia as configurações da AIDA para dentro da imagem oficial
COPY aida-config.yaml /app/librechat.yaml

# Substitui as logos do LibreChat pela logo da AIDA
COPY aida-logo.svg /app/client/public/assets/logo.svg
COPY aida-logo.svg /app/client/dist/assets/logo.svg

# Variáveis padrão
ENV HOST=0.0.0.0
ENV PORT=8080
EXPOSE 8080

CMD ["npm", "run", "backend"]
