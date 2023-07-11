-- Определить сколько книг прочитал каждый читатель в текущем году. Вывести рейтинг чита-телей по убыванию.

SELECT reader.reader_id as "id Читателя", full_name as "Читатель", count(book_id) as "Книг прочитано"
FROM reader
inner JOIN book_rental on book_rental.reader_id=reader.reader_id
where book_returned_date is not null
and date_part('year', book_borrowed_date) = date_part('year', current_date) 
group by "Читатель" , "id Читателя" order by "Книг прочитано" desc;


-- Определить, сколько книг у читателей на руках на текущую дату.

select count(book_id) as books_not_returned
from book_rental
where book_returned_date is null;

-- Определить читателей, у которых на руках определенная книга.

select full_name, reader_id from reader where reader_id in 
(select reader_id from book_rental where book_id in
(select book_id from book where book_name='--INSERT BOOK NAME HERE')
and book_returned_date is null) order by reader_id

-- Определите, какие книги на руках читателей

select book_name from public.book where book_id in(
select book_id from public.book_rental where 
book_returned_date is null);

-- Вывести количество должников на текущую дату.

select count(distinct reader_id) from book_rental where
current_date - book_borrowed_date > 14
and book_returned_date is null;

-- Книги какого издательства были самыми востребованными у читателей? Отсортируйте издательства по убыванию востребованности книг.

select count(book.book_id) as books_demanded, publisher_id, publisher_name 
from book
inner join book_rental using(book_id)
inner join publisher on publisher.publisher_id = fk_publisher_id
group by publisher_id, publisher_name order by books_demanded desc;

-- Определить самого издаваемого автора.

select count(book_id) as "выпущено книг", author_full_name from book_author
inner join author using(author_id)
group by author_full_name
order by count(book_id) desc limit 1;

-- Определить среднее количество прочитанных страниц читателем за день.

select full_name, (sum(page_volume) / sum(book_returned_date - book_borrowed_date)) average_pages
from book_rental
inner join reader using (reader_id)
inner join book using (book_id)
where book_returned_date is not null
group by full_name order by average_pages desc;