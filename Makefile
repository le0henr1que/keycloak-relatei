.PONY: build-front
build-front:
	cd themes ; npm run build ; npm run build:jar

.PHONY: start-development
start-development:
	cd themes ; npm run build ; npm run build:jar ; docker-compose up --build