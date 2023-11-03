start:
	docker-compose up -d --build

start-local:
	docker-compose -f docker-compose.local.yaml up -d --build

down:
	docker-compose down