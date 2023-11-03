start:
	docker-compose up -d --build

restart:
	make down
	make start

start-local:
	docker-compose -f docker-compose.local.yaml up -d --build

restart-local:
	make down
	make start-local

down:
	docker-compose down