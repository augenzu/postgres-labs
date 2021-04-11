---------------- Представления для сбора статистики ---------------------

-- Количество проданных билетов + 
-- суммарная выручка за фестиваль
create or replace view fest_info as
select 
    fest_id,
    (n_tickets[1] + n_tickets[2] + n_tickets[3]
        + n_tickets[4] + n_tickets[5] + n_tickets[6]
        + n_tickets[7] + n_tickets[8] + n_tickets[9]
        + n_tickets[10]) total_n_tickets,
    (n_tickets[1] * prices[1] +  n_tickets[2] * prices[2]
        + n_tickets[3] * prices[3] +  n_tickets[4] * prices[4]
        + n_tickets[5] * prices[5] +  n_tickets[6] * prices[6]
        + n_tickets[7] * prices[7] +  n_tickets[8] * prices[8]
        + n_tickets[9] * prices[9] +  n_tickets[10] * prices[10]) total_revenue
from fest;


-- Количество оценок [1, 10] за фестиваль
create or replace view fest_rating as
select 
    fest_id, rating, count(*) rating_cnt
from review
group by fest_id, rating;


-- Средний рейтинг жанра
create or replace view mean_rating_of_genre as
select 
    genre_name,
    round((ratings[1]::numeric * 1 + ratings[2] * 2 + ratings[3] * 3
        + ratings[4] * 4 + ratings[5] * 5 + ratings[6] * 6
        + ratings[7] * 7 + ratings[8] * 8 + ratings[9] * 9
        + ratings[10] * 10) / (ratings[1] + ratings[2] + ratings[3]
        + ratings[4] + ratings[5] + ratings[6] + ratings[7]
        + ratings[8] + ratings[9]+ ratings[10]), 2) mean_rating
from genre;


------------------------- Представления для ограничения доступа -----------------

-- Позволяет изменять цены билетов, скрывая количества проданных билетов
create or replace view prices_of_fest as
select 
    fest_id, prices
from fest;


------------------------- Материализованные представления ------------------------

-- Билеты на фест с id 42
-- (Очень долго создается (ticket содержит 100_000_000+ элементов),
-- но select * выполняется быстро)
create materialized view mtrlzd_fest_42_ticket as
select ticket_id, customer_id, price_id
from ticket
where fest_id = 42;


-- Такое же нематериализованное представление,
-- для сравнения скорости поолучения данных
-- (Быстро создается, но select * выполняется столько же,
-- сколько материализованное представление создается)
create or replace view fest_42_ticket as
select ticket_id, customer_id, price_id
from ticket
where fest_id = 42;