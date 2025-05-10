use class4Homework;

drop table if exists letters;

create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');


--Task 4 first part
Select letter
from letters
order by
	case when letter = 'b' then 0 else 1 end,
	letter;


--Task4 second part
Select letter
from letters
order by
	case when letter = 'a' then 0
		when letter = 'c' then 0 else 1 end,
	letter;
