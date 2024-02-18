.PONY: build-front
build-front:
	cd themes ; npm run build ; npm run build:jar

.PHONY: build-development
build-development:
	docker build --no-cache -t zaphodbrox/keycloak-relatei -f docker/development/Dockerfile .

.PHONY: start-development
start-development:
	cd themes ; npm run build ; npm run build:jar ; docker-compose up --build