FROM python:latest
MAINTAINER jcattard

RUN useradd -ms /bin/bash -G staff user01
USER user01
WORKDIR /home/user01

# requirement for python to use plante.py
COPY requirements.txt /home/user01
RUN pip install --user -r /home/user01/requirements.txt

COPY donneesEnvironnement.txt /home/user01
COPY plante.py /home/user01
COPY run.sh /home/user01
