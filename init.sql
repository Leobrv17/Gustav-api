CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS "restaurant" (
	"id" uuid NOT NULL UNIQUE,
	"user_id" uuid NOT NULL,
	"name" varchar(255) NOT NULL,
	"h_size_map" bigint NOT NULL DEFAULT '10',
	"w_size_map" bigint NOT NULL DEFAULT '10',
	"password_viewer" varchar(255) NOT NULL,
	"credential_viewer" varchar(255) NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "user" (
	"id" uuid NOT NULL UNIQUE,
	"firebase_uid" uuid NOT NULL UNIQUE,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "element_map" (
	"id" uuid NOT NULL UNIQUE,
	"restaurent_id" uuid NOT NULL,
	"coordinate" geometry NOT NULL,
	"element" bigint NOT NULL,
	"table_id" uuid NOT NULL UNIQUE,
	PRIMARY KEY ("id", "table_id")
);

CREATE TABLE IF NOT EXISTS "product" (
	"id" uuid NOT NULL UNIQUE,
	"role_id" uuid NOT NULL,
	"restaurent_id" uuid NOT NULL,
	"name" varchar(255) NOT NULL UNIQUE,
	"price" numeric(10,2) NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "role" (
	"id" uuid NOT NULL UNIQUE,
	"restaurent_id" uuid NOT NULL,
	"name" varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "commands" (
	"id" uuid NOT NULL UNIQUE,
	"table_id" uuid NOT NULL,
	"restaurent_id" uuid NOT NULL,
	"product_id" uuid NOT NULL,
	PRIMARY KEY ("id")
);

ALTER TABLE "restaurant" ADD CONSTRAINT "restaurant_fk1" FOREIGN KEY ("user_id") REFERENCES "user"("id");

ALTER TABLE "element_map" ADD CONSTRAINT "element_map_fk1" FOREIGN KEY ("restaurent_id") REFERENCES "restaurant"("id");
ALTER TABLE "product" ADD CONSTRAINT "product_fk1" FOREIGN KEY ("role_id") REFERENCES "role"("id");

ALTER TABLE "product" ADD CONSTRAINT "product_fk2" FOREIGN KEY ("restaurent_id") REFERENCES "restaurant"("id");
ALTER TABLE "role" ADD CONSTRAINT "role_fk1" FOREIGN KEY ("restaurent_id") REFERENCES "restaurant"("id");
ALTER TABLE "commands" ADD CONSTRAINT "commands_fk1" FOREIGN KEY ("table_id") REFERENCES "element_map"("table_id");

ALTER TABLE "commands" ADD CONSTRAINT "commands_fk2" FOREIGN KEY ("restaurent_id") REFERENCES "restaurant"("id");

ALTER TABLE "commands" ADD CONSTRAINT "commands_fk3" FOREIGN KEY ("product_id") REFERENCES "product"("id");