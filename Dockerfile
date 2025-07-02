# Etapa 1: Usar uma imagem base oficial do Python.
# A imagem 'slim' é um bom compromisso entre tamanho e compatibilidade.
# FROM python:3.11-slim
FROM python:3.13.5-alpine3.22

# Etapa 2: Definir o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências primeiro para aproveitar o cache do Docker.
COPY requirements.txt .

# Etapa 4: Instalar as dependências.
# --no-cache-dir: Desabilita o cache do pip para reduzir o tamanho da imagem.
# --upgrade pip: Garante que estamos usando a versão mais recente do pip.
RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação.
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada.
EXPOSE 8000

# Etapa 7: Comando para iniciar a aplicação quando o contêiner for executado.
# O host 0.0.0.0 torna a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]