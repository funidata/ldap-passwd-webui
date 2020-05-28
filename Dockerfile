FROM alpine:3.11

RUN apk add --no-cache \
  coreutils curl \
  python3 uwsgi-python3


WORKDIR /opt/ldap-passwd-webui
COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY . .

ENV UWSGI_HTTP_SOCKET=:8000
USER nobody
CMD uwsgi --http-socket $UWSGI_HTTP_SOCKET --plugins python3 --wsgi-file app.py
