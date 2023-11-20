postgres:
	docker run -p 5432:5432 --name postgres-13 -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=root -d postgres:13-alpine

createdb:
	docker exec -it postgres-13 createdb --username=root --owner=root river-bank

dropdb:
	docker exec -it postgres-13 dropdb river-bank

migrateup:
	migrate --path db/migration --database "postgresql://root:secret@localhost:5432/river-bank?sslmode=disable" -verbose up

migrateup1:
	migrate --path db/migration --database "postgresql://root:secret@localhost:5432/river-bank?sslmode=disable" -verbose up 1

migratedown:
	migrate --path db/migration --database "postgresql://root:secret@localhost:5432/river-bank?sslmode=disable" -verbose down

migratedown1:
	migrate --path db/migration --database "postgresql://root:secret@localhost:5432/river-bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/cooperqmarshall/river-bank/db/sqlc Store

-PHONY: createdb, dropdb, postgres, migrateup, migratedown, sqlc, test, server, mock, migratedown1, migrateup1
