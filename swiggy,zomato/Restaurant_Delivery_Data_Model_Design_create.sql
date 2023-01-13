-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-12-21 16:33:18.134

-- tables
-- Table: category
CREATE TABLE category (
    id int  NOT NULL,
    category_name varchar(255)  NOT NULL,
    CONSTRAINT category_ak_1 UNIQUE (category_name) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT category_pk PRIMARY KEY (id)
);

-- Table: city
CREATE TABLE city (
    id int  NOT NULL,
    city_name varchar(255)  NOT NULL,
    zip_code varchar(16)  NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: comment
CREATE TABLE comment (
    id int  NOT NULL,
    placed_order_id int  NOT NULL,
    customer_id int  NOT NULL,
    comment_text text  NOT NULL,
    ts timestamp  NOT NULL,
    is_complaint bool  NOT NULL,
    is_praise bool  NOT NULL,
    CONSTRAINT comment_pk PRIMARY KEY (id)
);

-- Table: customer
CREATE TABLE customer (
    id int  NOT NULL,
    customer_name varchar(255)  NOT NULL,
    city_id int  NOT NULL,
    address varchar(255)  NOT NULL,
    contact_phone varchar(255)  NOT NULL,
    email varchar(255)  NOT NULL,
    confirmation_code varchar(255)  NOT NULL,
    password varchar(255)  NOT NULL,
    time_joined timestamp  NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY (id)
);

-- Table: in_offer
CREATE TABLE in_offer (
    id int  NOT NULL,
    offer_id int  NOT NULL,
    menu_item_id int  NOT NULL,
    CONSTRAINT in_offer_ak_1 UNIQUE (offer_id, menu_item_id) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT in_offer_pk PRIMARY KEY (id)
);

-- Table: in_order
CREATE TABLE in_order (
    id int  NOT NULL,
    placed_order_id int  NOT NULL,
    offer_id int  NULL,
    menu_item_id int  NULL,
    quantity int  NOT NULL,
    item_price decimal(12,2)  NOT NULL,
    price decimal(12,2)  NOT NULL,
    comment text  NULL,
    CONSTRAINT in_order_pk PRIMARY KEY (id)
);

-- Table: menu_item
CREATE TABLE menu_item (
    id int  NOT NULL,
    item_name varchar(255)  NOT NULL,
    category_id int  NOT NULL,
    description text  NOT NULL,
    ingredients text  NOT NULL,
    recipe text  NOT NULL,
    price decimal(12,2)  NOT NULL,
    active bool  NOT NULL,
    CONSTRAINT menu_item_pk PRIMARY KEY (id)
);

-- Table: offer
CREATE TABLE offer (
    id int  NOT NULL,
    date_active_from date  NULL,
    time_active_from time  NULL,
    date_active_to date  NULL,
    time_active_to time  NULL,
    offer_price decimal(12,2)  NOT NULL,
    CONSTRAINT offer_pk PRIMARY KEY (id)
);

-- Table: order_status
CREATE TABLE order_status (
    id int  NOT NULL,
    placed_order_id int  NOT NULL,
    status_catalog_id int  NOT NULL,
    ts timestamp  NOT NULL,
    CONSTRAINT order_status_pk PRIMARY KEY (id)
);

-- Table: placed_order
CREATE TABLE placed_order (
    id int  NOT NULL,
    restaurant_id int  NOT NULL,
    order_time timestamp  NOT NULL,
    estimated_delivery_time timestamp  NOT NULL,
    food_ready timestamp  NULL,
    actual_delivery_time timestamp  NULL,
    delivery_address varchar(255)  NOT NULL,
    customer_id int  NULL,
    price decimal(12,2)  NOT NULL,
    discount decimal(12,2)  NOT NULL,
    final_price decimal(12,2)  NOT NULL,
    comment text  NULL,
    ts timestamp  NOT NULL,
    CONSTRAINT placed_order_pk PRIMARY KEY (id)
);

-- Table: restaurant
CREATE TABLE restaurant (
    id int  NOT NULL,
    address varchar(255)  NOT NULL,
    city_id int  NOT NULL,
    CONSTRAINT restaurant_pk PRIMARY KEY (id)
);

-- Table: status_catalog
CREATE TABLE status_catalog (
    id int  NOT NULL,
    status_name varchar(255)  NOT NULL,
    CONSTRAINT status_catalog_ak_1 UNIQUE (status_name) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT status_catalog_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: comment_customer (table: comment)
ALTER TABLE comment ADD CONSTRAINT comment_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: comment_placed_order (table: comment)
ALTER TABLE comment ADD CONSTRAINT comment_placed_order
    FOREIGN KEY (placed_order_id)
    REFERENCES placed_order (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: customer_city (table: customer)
ALTER TABLE customer ADD CONSTRAINT customer_city
    FOREIGN KEY (city_id)
    REFERENCES city (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: in_offer_menu_item (table: in_offer)
ALTER TABLE in_offer ADD CONSTRAINT in_offer_menu_item
    FOREIGN KEY (menu_item_id)
    REFERENCES menu_item (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: in_offer_offer (table: in_offer)
ALTER TABLE in_offer ADD CONSTRAINT in_offer_offer
    FOREIGN KEY (offer_id)
    REFERENCES offer (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: in_order_menu_item (table: in_order)
ALTER TABLE in_order ADD CONSTRAINT in_order_menu_item
    FOREIGN KEY (menu_item_id)
    REFERENCES menu_item (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: in_order_offer (table: in_order)
ALTER TABLE in_order ADD CONSTRAINT in_order_offer
    FOREIGN KEY (offer_id)
    REFERENCES offer (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: in_order_order (table: in_order)
ALTER TABLE in_order ADD CONSTRAINT in_order_order
    FOREIGN KEY (placed_order_id)
    REFERENCES placed_order (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: menu_item_category (table: menu_item)
ALTER TABLE menu_item ADD CONSTRAINT menu_item_category
    FOREIGN KEY (category_id)
    REFERENCES category (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: order_customer (table: placed_order)
ALTER TABLE placed_order ADD CONSTRAINT order_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: order_restaurant (table: placed_order)
ALTER TABLE placed_order ADD CONSTRAINT order_restaurant
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurant (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: order_status_order (table: order_status)
ALTER TABLE order_status ADD CONSTRAINT order_status_order
    FOREIGN KEY (placed_order_id)
    REFERENCES placed_order (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: order_status_status_catalog (table: order_status)
ALTER TABLE order_status ADD CONSTRAINT order_status_status_catalog
    FOREIGN KEY (status_catalog_id)
    REFERENCES status_catalog (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: restaurant_city (table: restaurant)
ALTER TABLE restaurant ADD CONSTRAINT restaurant_city
    FOREIGN KEY (city_id)
    REFERENCES city (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.
-- final price after offer applied

select price  - offer_price price_after_offer
from menu_item mi  join in_offer io on mi.id = io.menu_item_id  join offer o on io.offer_id  = o.id ;

--which restaurant has max orders
with cte as(
select po.restaurant_id ,count(1) cnt from placed_order po group by po.restaurant_id)
select cte.restaurant_id from cte where cnt = (select max(cnt) from cte);

select po.restaurant_id ,count(1) cnt from placed_order po group by po.restaurant_id order by cnt desc limit 1;

--how many orders till date are deliverd by the restaurant id  101
select sc.status_name  from 
placed_order po  
join order_status os
on 
po.id = os.placed_order_id 
join status_catalog sc
on
os.status_catalog_id  = sc.id 
where restaurant_id =101 and po.order_time  = '2022-12-31 22:43:13'
and sc.status_name  = 'delivered';

--no of restaurants who deliver food on time
select distinct po.restaurant_id  from 
placed_order po  
where po.actual_delivery_time  = po.estimated_delivery_time ;

--customer name and orders till date in complete year

select c.customer_name,count(po.id)  from customer c 
join
placed_order po  on c.id = po.customer_id 
where po.order_time  between date_trunc('year', order_time)::date and order_time::date
group by customer_name;
