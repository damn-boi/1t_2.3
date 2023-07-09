-- Определить сколько книг прочитал каждый читатель в текущем году. Вывести рейтинг чита-телей по убыванию.

select count(book_id) as books_readed, reader_id FROM public.book_rental WHERE
book_borrowed_date >= '01-01-2023' and book_returned_date < '01-01-2024' group by reader_id
order by books_readed desc;

-- Определить, сколько книг у читателей на руках на текущую дату.

select count(book_id) as books_not_returned, reader_id from public.book_rental where 
book_returned_date is null group by reader_id;

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

select count(book.book_id) as books_demanded, fk_publisher_id as publisher_id from book
inner join book_rental on book.book_id=book_rental.book_id
group by publisher_id order by books_demanded desc;

-- Определить самого издаваемого автора.

select count(book_author.book_id) as books_published, author_id from book_author inner join 
book_rental on book_rental.book_id=book_author.book_id
group by author_id order by books_published desc;

-- Определить среднее количество прочитанных страниц читателем за день.

select avg(page_volume / minus) as days_for_reading from (select (book_returned_date-book_borrowed_date) as minus,
page_volume
from (select * from book_rental
join book on book.book_id=book_rental.book_id) as g
where book_returned_date is not null) as h;