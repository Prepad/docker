#!/bin/bash
docker compose down
docker compose up -d --build mysql nginx php redis