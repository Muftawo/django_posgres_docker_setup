FROM python:3.9 as base

RUN mkdir /code/
WORKDIR /code/

COPY requirements.txt /code/
RUN pip install -r requirements.txt

COPY ./src/ /code/
ENV PYTHONUNBUFFERED=1


###########START NEW IMAGE : DEBUGGER ###################
FROM base as debug
RUN pip install ptvsd

WORKDIR /work/
CMD python -m ptvsd --host 0.0.0.0 --port 8000 --wait --multiprocess -m manage.py runserver -h 0.0.0 -p 8000


###########START NEW IMAGE: PRODUCTION ###################
FROM base as prod

CMD python manage.py runserver 