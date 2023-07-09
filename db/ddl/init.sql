CREATE TABLE IF NOT EXISTS public.reader 
(
    reader_id integer PRIMARY KEY,
    full_name text NOT NULL,
    adress text,
    phone_number text
);

CREATE TABLE IF NOT EXISTS public.publisher
(
    publisher_id integer PRIMARY KEY,
    publisher_name text NOT NULL,
    publisher_city varchar(128) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.book 
(
    book_id integer PRIMARY KEY,
    book_name text NOT NULL,
    publish_year smallint NOT NULL,
    page_volume integer NOT NULL,
    book_price money NOT NULL,
    books_available bigint NOT NULL,
    fk_publisher_id integer REFERENCES public.publisher(publisher_id) 
);

CREATE TABLE IF NOT EXISTS public.author 
(
    author_id integer PRIMARY KEY,
    author_full_name text NOT NULL
);

CREATE TABLE IF NOT EXISTS public.book_rental
(
    reader_id integer REFERENCES public.reader(reader_id) NOT NULL,
    book_id integer REFERENCES public.book(book_id) NOT NULL,
    book_borrowed_date DATE NOT NULL,
    book_returned_date DATE,

    CONSTRAINT book_rental_pkey PRIMARY KEY (reader_id, book_id) -- composite key
);

CREATE TABLE IF NOT EXISTS public.book_author
(
    book_id integer REFERENCES public.book(book_id) NOT NULL,
    author_id integer REFERENCES public.author(author_id) NOT NULL,
    CONSTRAINT book_author_pkey PRIMARY KEY (book_id, author_id) -- composite key
);