FROM python:3.8.3

WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN python3 -m venv venv
RUN /bin/bash -c "source venv/bin/activate"

COPY requirements.txt requirements.txt
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
RUN pip3 freeze

COPY . .

RUN python3 manage.py migrate

CMD gunicorn locallibrary.wsgi:application --bind 0.0.0.0:8000