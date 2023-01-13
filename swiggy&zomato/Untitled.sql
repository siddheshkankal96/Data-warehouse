CREATE TABLE "category" (
  "id" int,
  "category_name" varchar
);

CREATE TABLE "city" (
  "id" int,
  "city_name" varchar,
  "zip_code" varchar
);

CREATE TABLE "comment" (
  "id" int,
  "placed_order_id" int,
  "customer_id" int,
  "comment_text" text,
  "ts" timestamp,
  "is_complaint" bool,
  "is_praise" bool
);

CREATE TABLE "customer" (
  "id" int,
  "customer_name" varchar,
  "city_id" int,
  "address" varchar,
  "contact_phone" varchar,
  "email" varchar,
  "confirmation_code" varchar,
  "password" varchar,
  "time_joined" timestamp
);

CREATE TABLE "in_offer" (
  "id" int,
  "offer_id" int,
  "menu_item_id" int
);

CREATE TABLE "in_order" (
  "id" int,
  "placed_order_id" int,
  "offer_id" int,
  "menu_item_id" int,
  "quantity" int,
  "item_price" decimal,
  "price" decimal,
  "comment" text
);

CREATE TABLE "menu_item" (
  "id" int,
  "item_name" varchar,
  "category_id" int,
  "description" text,
  "ingredients" text,
  "recipe" text,
  "price" decimal,
  "active" bool
);

CREATE TABLE "offer" (
  "id" int,
  "date_active_from" date,
  "time_active_from" time,
  "date_active_to" date,
  "time_active_to" time,
  "offer_price" decimal
);

CREATE TABLE "order_status" (
  "id" int,
  "placed_order_id" int,
  "status_catalog_id" int,
  "ts" timestamp
);

CREATE TABLE "placed_order" (
  "id" int,
  "restaurant_id" int,
  "order_time" timestamp,
  "estimated_delivery_time" timestamp,
  "food_ready" timestamp,
  "actual_delivery_time" timestamp,
  "delivery_address" varchar,
  "customer_id" int,
  "price" decimal,
  "discount" decimal,
  "final_price" decimal,
  "comment" text,
  "ts" timestamp
);

CREATE TABLE "restaurant" (
  "id" int,
  "address" varchar,
  "city_id" int
);

CREATE TABLE "status_catalog" (
  "id" int,
  "status_name" varchar
);

ALTER TABLE "in_order" ADD FOREIGN KEY ("placed_order_id") REFERENCES "placed_order" ("id");

ALTER TABLE "in_offer" ADD FOREIGN KEY ("offer_id") REFERENCES "offer" ("id");

ALTER TABLE "in_offer" ADD FOREIGN KEY ("menu_item_id") REFERENCES "menu_item" ("id");

ALTER TABLE "menu_item" ADD FOREIGN KEY ("category_id") REFERENCES "category" ("id");

ALTER TABLE "restaurant" ADD FOREIGN KEY ("city_id") REFERENCES "city" ("id");

ALTER TABLE "customer" ADD FOREIGN KEY ("city_id") REFERENCES "city" ("id");

ALTER TABLE "placed_order" ADD FOREIGN KEY ("customer_id") REFERENCES "customer" ("id");

CREATE TABLE "placed_order_comment" (
  "placed_order_id" int,
  "comment_placed_order_id" int,
  PRIMARY KEY ("placed_order_id", "comment_placed_order_id")
);

ALTER TABLE "placed_order_comment" ADD FOREIGN KEY ("placed_order_id") REFERENCES "placed_order" ("id");

ALTER TABLE "placed_order_comment" ADD FOREIGN KEY ("comment_placed_order_id") REFERENCES "comment" ("placed_order_id");


ALTER TABLE "order_status" ADD FOREIGN KEY ("placed_order_id") REFERENCES "comment" ("placed_order_id");

ALTER TABLE "order_status" ADD FOREIGN KEY ("status_catalog_id") REFERENCES "status_catalog" ("id");

ALTER TABLE "in_order" ADD FOREIGN KEY ("menu_item_id") REFERENCES "menu_item" ("id");



--1. find the customer names and their order status from the time between '2022-12-31 12:00:00' and '2022-12-31 17:05:12'

select c.customer_name,s.status_name from customer c join placed_order p on c.id = p.customer_id
join order_status o on p.id = o.placed_order_id
join status_catalog s on o.status_catalog_id = o.id
where p.order_time between '2022-12-31 12:00:00' and '2022-12-31 17:05:12';

--2.find the number of orders per order status

select count(p.id)count_of_orders,s.status_name from customer c join placed_order p on c.id = p.customer_id
join order_status o on p.id = o.placed_order_id
join status_catalog s on o.status_catalog_id = o.id
where s.status_name = 'Delivered' and p.order_time between '2022-12-31 12:00:00' and '2022-12-31 17:05:12'
group by status_name;

--3. find the number of orders deliverd 

select count(p.id)count_of_orders,s.status_name from customer c join placed_order p on c.id = p.customer_id
join order_status o on p.id = o.placed_order_id
join status_catalog s on o.status_catalog_id = o.id
where s.status_name = 'Delivered' and p.order_time between '2022-12-31 12:00:00' and '2022-12-31 17:05:12'
group by status_name;
