all: app-init front-init back-init docker-up done


app-init:
	git submodule update

app-up:
	git submodule foreach "git pull origin master"

front-init:
	cd app/notes-front && npm install && ng build --prod

back-init:
	docker exec -it notes-php sh -c "composer update && php artisan migrate"

docker-up:
	docker-compose up -d web

docker-down:
	docker-compose down

done:
	@echo "Done! Please open browser on address localhost."