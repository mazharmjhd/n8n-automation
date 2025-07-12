FROM n8nio/n8n

USER root

RUN apk add --no-cache python3 py3-pip gcc python3-dev musl-dev curl ffmpeg aria2

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

