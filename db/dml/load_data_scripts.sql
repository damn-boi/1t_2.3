INSERT INTO public.reader (reader_id, full_name)
    VALUES(1, 'Абобус Трошкин'),
          (2, 'Джозеф Джостар'),
          (3, 'Джотаро Джостар'),
		  (4, 'Сергей'),
		  (5, 'Николай')
          ON CONFLICT (reader_id) DO NOTHING;

INSERT INTO public.publisher
	VALUES (1, 'Мохнатик', 'Омск'),
		   (2, 'АБДУРОЗИК-КНИГИ', 'Москва'),
		   (3, 'Papyrus', 'Казань')
		   ON CONFLICT (publisher_id) DO NOTHING;

INSERT INTO public.author
	VALUES (1, 'Денисов'),
		   (2, 'Артемов'),
		   (3, 'Магниткин')
		   ON CONFLICT (author_id) DO NOTHING;

INSERT INTO public.book
    VALUES(1, 'Капитал', 1867, 300, 0, 10000000,
		  (select publisher_id from public.publisher where publisher_name = 'Мохнатик')),
    	  (2, 'Гарри Поттер', 1980, 956, 100, 10000000,
		  (select publisher_id from public.publisher where publisher_name = 'АБДУРОЗИК-КНИГИ')),
          (3, 'Машина Времени', 1810, 16, 100, 1000000,
		  (select publisher_id from public.publisher where publisher_name = 'Papyrus')),
          (4, 'Маленький мук', 1900, 89, 100, 1000000,
		  (select publisher_id from public.publisher where publisher_name = 'Мохнатик')),
          (5, 'Великий Гэтсби', 1900, 34, 100, 1000000,
		  (select publisher_id from public.publisher where publisher_name = 'Papyrus')),
		  (6, 'Властелин колец', 1960, 590, 100, 1000000,
		  (select publisher_id from public.publisher where publisher_name = 'АБДУРОЗИК-КНИГИ'))
          ON CONFLICT (book_id) DO NOTHING;

INSERT INTO public.book_author
	VALUES((select book_id from public.book where book_name='Капитал'),
		   (select author_id from public.author where author_full_name = 'Денисов')),
		  ((select book_id from public.book where book_name='Гарри Поттер'),
		   (select author_id from public.author where author_full_name = 'Артемов')),
		  ((select book_id from public.book where book_name='Машина Времени'),
		   (select author_id from public.author where author_full_name = 'Магниткин')),
		  ((select book_id from public.book where book_name='Маленький мук'),
		   (select author_id from public.author where author_full_name = 'Денисов')),
		  ((select book_id from public.book where book_name='Великий Гэтсби'),
		   (select author_id from public.author where author_full_name = 'Магниткин')),
		  ((select book_id from public.book where book_name='Властелин колец'),
		   (select author_id from public.author where author_full_name = 'Магниткин'))
		  ON CONFLICT (author_id, book_id) DO NOTHING;

insert into public.book_rental
	VALUES((select reader_id from public.reader where full_name = 'Абобус Трошкин'),
		  (select book_id from public.book where book_name = 'Гарри Поттер'),
	      '11-11-2002', '12-11-2002'),
		  ((select reader_id from public.reader where full_name = 'Абобус Трошкин'),
		  (select book_id from public.book where book_name = 'Капитал'),
		  '05-07-2023', '06-02-2023'),
		  ((select reader_id from public.reader where full_name = 'Абобус Трошкин'),
		  (select book_id from public.book where book_name = 'Машина Времени'),
		  '01-11-2012', '02-11-2012'),
		  ((select reader_id from public.reader where full_name = 'Джозеф Джостар'),
		  (select book_id from public.book where book_name = 'Гарри Поттер'),
		  '03-11-2023', '03-20-2023'),
		  ((select reader_id from public.reader where full_name = 'Джозеф Джостар'),
		  (select book_id from public.book where book_name = 'Капитал'),
		  '05-25-2010', '05-28-2010'),
		  ((select reader_id from public.reader where full_name = 'Джозеф Джостар'),
		  (select book_id from public.book where book_name = 'Машина Времени'),
		  '05-11-2023', '07-01-2023'),
		  ((select reader_id from public.reader where full_name = 'Джотаро Джостар'),
		  (select book_id from public.book where book_name = 'Машина Времени'),
		  '02-01-2023', '03-12-2023'),
		  ((select reader_id from public.reader where full_name = 'Джотаро Джостар'),
		  (select book_id from public.book where book_name = 'Гарри Поттер'),
		  '04-03-2023', '04-07-2023'),
		  ((select reader_id from public.reader where full_name = 'Джотаро Джостар'),
		  (select book_id from public.book where book_name = 'Капитал'),
		  '01-13-2023', '01-20-2023'),
		  ((select reader_id from public.reader where full_name = 'Абобус Трошкин'),
		  (select book_id from public.book where book_name = 'Маленький мук'),
		  '06-25-2023', null),
		  ((select reader_id from public.reader where full_name = 'Джотаро Джостар'),
		  (select book_id from public.book where book_name = 'Великий Гэтсби'),
		  '04-20-2023', null),
		  ((select reader_id from public.reader where full_name = 'Джозеф Джостар'),
		  (select book_id from public.book where book_name = 'Маленький мук'),
		  '02-25-2023', null),
		  ((select reader_id from public.reader where full_name = 'Сергей'),
		  (select book_id from public.book where book_name = 'Маленький мук'),
		  '05-02-2023', null),
		  ((select reader_id from public.reader where full_name = 'Николай'),
		  (select book_id from public.book where book_name = 'Великий Гэтсби'),
		  '12-11-2019', null),
		  ((select reader_id from public.reader where full_name = 'Николай'),
		  (select book_id from public.book where book_name = 'Маленький мук'),
		  '01-10-2020', null),
		  ((select reader_id from public.reader where full_name = 'Сергей'),
		  (select book_id from public.book where book_name = 'Властелин колец'),
		  '03-10-2023', null),
		  ((select reader_id from public.reader where full_name = 'Сергей'),
		  (select book_id from public.book where book_name = 'Гарри Поттер'),
		  '07-01-2023', null)
		  ON CONFLICT (reader_id, book_id) DO NOTHING;
		
