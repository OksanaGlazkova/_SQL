Функция:

create function payment_amount(data1 date, data2 date, out total numeric) as $$
begin
	select sum(amount)
	from payment
	where payment_date::date between data1 and data2 into total;
	end;
$$
language plpgsql;

Вызов функции:

select payment_amount (data1, data2)

Пример:

select payment_amount ('2007-02-15 00:00:00', '2007-02-16 23:59:59')


Таблица:

CREATE TABLE not_active_customer (
	id serial PRIMARY key NOT NULL,
	customer_id int2 NOT null REFERENCES public.customer(customer_id),
	not_active_date date NOT NULL DEFAULT now()
);


select *
from customer
where last_name = 'Smith'


create function not_active() returns trigger as $$
	begin
		if (new.active = 0) then
		insert into not_active_customer (customer_id,not_active_date) values (new.customer_id,now());
		end if;
		return null;
	end; $$
	language plpgsql;

Объявление триггера

create trigger not_active
after update on customer
	for each row execute function not_active();

drop function not_active() cascade


update customer
set active = 0
where last_name = 'Smith'
