all: app-init front-init back-init done


app-init:
	git submodule init && git submodule update

app-up:
	git submodule foreach "git pull origin master"

front-init:
	cd app/notes-front && npm install && ng build --prod

back-env:
	cd app/notes-back && cp .env.example .env \
		&& sed -i 's/DB_HOST=127.0.0.1/DB_HOST=mysql/g' .env \
		&& sed -i 's/DB_DATABASE=homestead/DB_DATABASE=notes/g' .env \
		&& sed -i 's/DB_USERNAME=homestead/DB_USERNAME=root/g' .env \
		&& sed -i 's/DB_PASSWORD=secret/DB_PASSWORD=notes/g' .env

back-init: mysql-init back-env docker-up
	docker exec -it notes-php sh -c "composer update && php artisan migrate"

mysql-init:
	cd services/mysql && sudo chmod 0777 data

docker-up:
	docker-compose up -d web

docker-down:
	docker-compose down

done:
	@echo "Done! Please open browser on address localhost."