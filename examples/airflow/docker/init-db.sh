#!/bin/bash
#
# SPDX-License-Identifier: Apache-2.0
#
# Usage: $ ./init-db.sh

set -eu

psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" > /dev/null <<-EOSQL
  CREATE USER ${AIRFLOW_USER};
  ALTER USER ${AIRFLOW_USER} WITH PASSWORD '${AIRFLOW_PASSWORD}';
  CREATE DATABASE ${AIRFLOW_DB};
  GRANT ALL PRIVILEGES ON DATABASE ${AIRFLOW_DB} TO ${AIRFLOW_USER};
  CREATE USER ${MARQUEZ_USER};
  ALTER USER ${MARQUEZ_USER} WITH PASSWORD '${MARQUEZ_PASSWORD}';
  CREATE DATABASE ${MARQUEZ_DB};
  GRANT ALL PRIVILEGES ON DATABASE ${MARQUEZ_DB} TO ${MARQUEZ_USER};
  CREATE USER ${EXAMPLE_USER};
  ALTER USER ${EXAMPLE_USER} WITH PASSWORD '${EXAMPLE_PASSWORD}';
  CREATE DATABASE ${EXAMPLE_DB};
  GRANT ALL PRIVILEGES ON DATABASE ${EXAMPLE_DB} TO ${EXAMPLE_USER};
EOSQL

# Copyright 2018-2022 contributors to the Marquez project