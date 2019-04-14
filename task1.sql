create database if not exists bw2digital
default character set utf8mb4
default collate utf8mb4_general_ci;

use bw2digital;
create table events (
event_type integer not null,
value integer not null,
time timestamp not null,
unique (event_type, time)
)default charset=utf8mb4;

insert into events values
(2,   5, '2015-05-09 12:42:00'),
(4, -42, '2015-05-09 13:19:57'),
(2,   2, '2015-05-09 14:48:30'),
(2,   7, '2015-05-09 12:54:39'),
(3,  16, '2015-05-09 13:19:57'),
(3,  20, '2015-05-09 15:01:09');
/* */
with tudo as(select event_type,value, ROW_NUMBER() OVER (PARTITION BY EVENT_TYPE ORDER BY time) AS numerador, time from events 
group by event_type, time, value),
maisAntigo as (select event_type, MIN(numerador) numerador from tudo group by event_type),
penultimo as (select event_type, MAX(numerador)-1 numerador from tudo group by event_type),
maisAntigocomvalor as (select maisAntigo.event_type, maisAntigo.Numerador,tudo.value
from maisAntigo
inner join tudo on tudo.event_type = maisAntigo.event_type and maisAntigo.Numerador = tudo.Numerador
),
penultimoComValor as (select penultimo.event_type, penultimo.Numerador,tudo.value
from penultimo
inner join tudo on tudo.event_type = penultimo.event_type and penultimo.Numerador = tudo.Numerador)
select maisAntigocomvalor.event_type, SUM(penultimoComValor.value - maisAntigocomvalor.value)
from maisAntigocomvalor
left join penultimoComValor on penultimoComValor.event_type = maisAntigocomvalor.event_type
group by maisAntigocomvalor.event_type




