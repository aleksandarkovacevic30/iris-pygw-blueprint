FROM store/intersystems/iris-community:2020.3.0.221.0 AS libs

FROM python:3.8-buster AS builder
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY --from=libs /usr/irissys/dev/python/intersystems_irispython-3.2.0-py3-none-any.whl /tmp/.

COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt
RUN pip install --upgrade /tmp/intersystems_irispython-3.2.0-py3-none-any.whl

FROM python:3.8-slim-buster

RUN useradd --create-home appuser
WORKDIR /home/appuser/
USER appuser

COPY --from=builder /opt/venv /home/appuser/venv
RUN echo $(ls -1 /home/appuser/venv)
ENV PATH="/home/appuser/venv/bin:$PATH"

COPY src/ py/

CMD ["python", "-m", "iris","PythonGateway","57575","","","pogs",""]
