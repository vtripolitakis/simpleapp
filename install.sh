#!/bin/bash
sudo -u postgres psql -f ./company_database.sql
sudo -u postgres /usr/local/bin/postgres &
cd src
npm install
npm run dev &
