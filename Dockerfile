FROM python:3.7.3-alpine3.10

RUN adduser -D revoltblog

WORKDIR /home/revoltblog

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn pymysql

COPY app/ app/
COPY migrations/ migrations/
COPY revoltblog.py config.py boot.sh ./
RUN apk add --no-cache bash
RUN chmod +x boot.sh

ENV FLASK_APP revoltblog.py

RUN chown -R revoltblog:revoltblog ./
USER revoltblog

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]
