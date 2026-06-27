FROM ghcr.io/danny-avila/librechat-dev:latest

# Copia as configurações personalizadas do LibreChat
COPY librechat.yaml /app/librechat.yaml

# Variáveis padrão
ENV HOST=0.0.0.0
ENV PORT=8080
EXPOSE 8080

CMD ["npm", "run", "backend"]
