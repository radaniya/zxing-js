FROM python:3.10.4-slim-bullseye

RUN groupadd --gid 1000 pn && useradd --uid 1000 --gid pn --shell /bin/bash --create-home pn
ENV POETRY_HOME=/usr/local
# Install node prereqs, nodejs and yarn
# Ref: https://deb.nodesource.com/setup_10.x
# Ref: https://yarnpkg.com/en/docs/install
RUN \
  apt-get update && apt-get install wget gnupg2 git build-essential -y && \
  echo "deb https://deb.nodesource.com/node_10.x bullseye main" > /etc/apt/sources.list.d/nodesource.list && \
  wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
  wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  apt-get update && \
  apt-get install -yqq nodejs=$(apt-cache show nodejs|grep Version|grep nodesource|cut -c 10-) yarn && \
  apt-mark hold nodejs && \
  pip install -U pip && pip install pipenv && \
  npm i -g npm@^6 && \
  wget -q -O - https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python - && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*

USER root

RUN mkdir /home/pn/app

WORKDIR /home/pn/app

CMD /bin/bash
