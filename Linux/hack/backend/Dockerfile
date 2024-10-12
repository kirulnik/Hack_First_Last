FROM python:3.12

RUN python3 -m venv /opt/venv

RUN mkdir /backend

COPY requirements.txt .

RUN . /opt/venv/bin/activate && pip install -r requirements.txt

COPY main.py .

EXPOSE 8000

CMD . /opt/venv/bin/activate && exec uvicorn main:app --host 0.0.0.0
