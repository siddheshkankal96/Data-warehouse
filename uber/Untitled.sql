CREATE TABLE "customer" (
  "customer_id" int,
  "customer_name" varchar,
  "address_id" varchar,
  "phone_number" number,
  "password" varchar,
  "joined_date" date
);

CREATE TABLE "Driver" (
  "driver_id" int,
  "driver_name" varchar,
  "address_id" int,
  "emial" varchar,
  "phone_number" number,
  "joined_date" date,
  "car_id" int,
  "driver_licence_no" varchar
);

CREATE TABLE "car_details" (
  "car_id" int,
  "car_no" int,
  "car_type" varchar,
  "car_colour" varchar,
  "car_company" varchar
);

CREATE TABLE "address_details" (
  "address_id" int,
  "city" varchar,
  "state" varchar,
  "landmark" varchar,
  "area" varchar,
  "pincode" number
);

CREATE TABLE "trip" (
  "trip_id" int,
  "driver_id" int,
  "customer_id" int,
  "device_id" int,
  "trip_requested" timestamp,
  "start_location_id" int,
  "end_location_id" int,
  "wait_time" int,
  "customer_rating" int,
  "payment_id" int,
  "status" int
);

CREATE TABLE "location" (
  "location_id" int,
  "landmark" varchar,
  "state" varchar,
  "city" varchar
);

CREATE TABLE "payments" (
  "payment_id" int,
  "type" varchar,
  "base_rate" int,
  "surge_rate" int,
  "total_amount" int,
  "transaction_id" int
);

ALTER TABLE "trip" ADD FOREIGN KEY ("driver_id") REFERENCES "Driver" ("driver_id");

ALTER TABLE "trip" ADD FOREIGN KEY ("payment_id") REFERENCES "payments" ("payment_id");

ALTER TABLE "trip" ADD FOREIGN KEY ("customer_id") REFERENCES "customer" ("customer_id");

ALTER TABLE "trip" ADD FOREIGN KEY ("start_location_id") REFERENCES "address_details" ("address_id");

ALTER TABLE "trip" ADD FOREIGN KEY ("end_location_id") REFERENCES "address_details" ("address_id");

ALTER TABLE "Driver" ADD FOREIGN KEY ("address_id") REFERENCES "address_details" ("address_id");

ALTER TABLE "Driver" ADD FOREIGN KEY ("car_id") REFERENCES "car_details" ("car_id");

ALTER TABLE "customer" ADD FOREIGN KEY ("address_id") REFERENCES "address_details" ("address_id");

ALTER TABLE "address_details" ADD FOREIGN KEY ("landmark") REFERENCES "location" ("landmark");

ALTER TABLE "address_details" ADD FOREIGN KEY ("address_id") REFERENCES "location" ("location_id");

--1.find the individual customer names and their trips count
select customer_name,count(1) number_of_trips from trip t join customer  c on t.customer_id = c.customer_id
group by customer_name;

--2.maximum visited address 
select max(max_visited_place) max_visited_place from (
select address_id,count(1) max_visited_place from address_details a join trip t on a.address_id 
between t.start_location_id and t.end_location_id group by address_id)a;

--3. number of payments done by each payment type
select type,count(1) number_of_payments from payments p join trip t on p.payment_id = t.payment_id
group by type;

--4. find the method of payment by which max transaction has made
select type from (
select type,count(1) number_of_payments from payments p join trip t on p.payment_id = t.payment_id
group by type  order by number_of_payments desc)a limit 1  ;

--5. find the trips done by each driver 
select driver_name,count(1) number_of_trips from trip t join "Driver"  d on t.driver_id = d."driver_id"
group by driver_name order by number_of_trips desc;

--6. which car type is used how many times for trip
select c.car_type,count(trip_id) from 
trip t join "Driver" d 
on t.driver_id = d.driver_id
join car_details c on
d.car_id = c.car_id
group by car_type;