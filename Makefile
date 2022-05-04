postgres:
	docker run -p 5432:5432 --name postgres-13 -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=root -d postgres:13-alpine

createdb:
	docker exec -it postgres-13 createdb --username=root --owner=root river-bank

dropdb:
	docker exec -it postgres-13 dropdb river-bank

migrateup:
	migrate --path db/migration --database "postgresql://root:secret@localhost:5432/river-bank?sslmode=disable" -verbose up

migratedown:
	migrate --path db/migration --database "postgresql://root:secret@localhost:5432/river-bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

-PHONY: createdb, dropdb, postgres, migrateup, migratedown, sqlc, test
