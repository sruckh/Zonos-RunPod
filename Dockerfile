FROM pytorch/pytorch:2.6.0-cuda12.4-cudnn9-devel

RUN apt-get update && \
    apt-get install -y espeak-ng && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN chmod +x startup.sh

CMD ["./startup.sh"]