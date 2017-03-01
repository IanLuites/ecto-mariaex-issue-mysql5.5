FROM trenpixster/elixir:1.4.1
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && apt-get install -y \
  mysql-server-5.5 \
  libmysqlclient-dev \
  mysql-client-core-5.5

RUN mkdir /app
WORKDIR /app

RUN MIX_ENV=prod mix local.rebar --force
RUN MIX_ENV=prod mix local.hex --force

COPY . .
RUN MIX_ENV=prod mix deps.get
RUN MIX_ENV=prod mix compile

CMD service mysql start && /app/run-insert.sh
