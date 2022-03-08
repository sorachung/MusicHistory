--Query all of the entries in the Genre table
SELECT * FROM Genre;

--Query all the entries in the Artist table and order by the artist's name. HINT: use the ORDER BY keywords
SELECT *
FROM Artist
ORDER BY ArtistName;

--Write a SELECT query that lists all the songs in the Song table and include the Artist name
SELECT 
	s.*,
	a.ArtistName
FROM Song s
	LEFT JOIN Artist a ON s.ArtistId = a.Id;

SELECT s.*,
		a.ArtistName
FROM Song s
	INNER JOIN Artist a ON s.ArtistId = a.Id;

--Write a SELECT query that lists all the Artists that have a Soul Album
SELECT DISTINCT ArtistName
From Artist a
	JOIN Album al ON al.ArtistId = a.Id
	JOIN Genre g ON g.Id = al.GenreId
	WHERE g.Name = 'Soul';

--Write a SELECT query that lists all the Artists that have a Jazz or Rock Album
SELECT DISTINCT a.*
From Artist a
	JOIN Album al ON al.ArtistId = a.Id
	JOIN Genre g ON g.Id = al.GenreId
	WHERE g.Name = 'Jazz' OR g.Name = 'Rock';

--Write a SELECT statement that lists the Albums with no songs
SELECT *
FROM Album a
	LEFT JOIN Song s on s.AlbumId = a.Id
WHERE s.Id IS NULL;

SELECT a.Title
FROM Album a
	LEFT JOIN Song s on s.AlbumId = a.Id
WHERE s.Id IS NULL;


--Using the INSERT statement, add one of your favorite artists to the Artist table.
--INSERT INTO Artist (ArtistName, YearEstablished)
--VALUES ('Sufjan Stevens', 1995);


--Using the INSERT statement, add one, or more, albums by your artist to the Album table.
--INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId)
--VALUES ('The Age of Adz', 2010, 74, 'Asthmatic Kitty', 28, 14);


--Using the INSERT statement, add some songs that are on that album to the Song table.
--INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId)
--VALUES ('Get Real Get Right', 310, 2010, 14, 28, 23);

--INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId)
--VALUES ('Impossible Soul', 1535, 2010, 14, 28, 23);


--Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in. Use the LEFT JOIN keyword sequence to connect the tables, and the WHERE keyword to filter the results to the album and artist you added.
SELECT s.Title, al.Title, ar.ArtistName
FROM Song s
	LEFT JOIN Album al on al.Id = s.AlbumId
	LEFT JOIN Artist ar on ar.Id = s.ArtistId
WHERE ar.ArtistName = 'Sufjan Stevens'

SELECT s.Title, al.Title, ar.ArtistName
FROM Album al
	LEFT JOIN Song s on al.Id = s.AlbumId
	LEFT JOIN Artist ar on ar.Id = s.ArtistId
WHERE ar.ArtistName = 'Sufjan Stevens'

--NOTE: Direction of join matters. Try the following statements and see the difference in results.

--SELECT a.Title, s.Title FROM Album a LEFT JOIN Song s ON s.AlbumId = a.Id;
--SELECT a.Title, s.Title FROM Song s LEFT JOIN Album a ON s.AlbumId = a.Id;

--Write a SELECT statement to display how many songs exist for each album. You'll need to use the COUNT() function and the GROUP BY keyword sequence.
SELECT al.Title, Count(s.AlbumId) AS NumberOfSongs
FROM Album al
	LEFT JOIN Song s ON s.AlbumId = Al.Id
GROUP BY al.Title;

--Write a SELECT statement to display how many songs exist for each artist. You'll need to use the COUNT() function and the GROUP BY keyword sequence.
SELECT ar.ArtistName, COUNT(s.Id)
FROM Artist ar
	LEFT JOIN Song s ON ar.Id = s.ArtistId
GROUP BY ar.ArtistName;

--Write a SELECT statement to display how many songs exist for each genre. You'll need to use the COUNT() function and the GROUP BY keyword sequence.
SELECT g.Name, COUNT(s.Id)
FROM Genre g
	LEFT JOIN Song s ON s.GenreId = g.Id
GROUP BY g.Name, g.Id;

--Write a SELECT query that lists the Artists that have put out records on more than one record label. Hint: When using GROUP BY instead of using a WHERE clause, use the HAVING keyword
SELECT ar.ArtistName
FROM Album al
	JOIN Artist ar ON al.ArtistId = ar.Id
GROUP BY ar.ArtistName, ar.Id
HAVING COUNT(DISTINCT al.Label) >= 2;

SELECT ar.ArtistName
FROM Artist ar
	JOIN Album al ON al.ArtistId = ar.Id
GROUP BY ar.ArtistName, ar.Id
HAVING COUNT(DISTINCT al.Label) >= 2;

SELECT ArtistId
FROM Album
GROUP BY ArtistId
HAVING COUNT(DISTINCT Label) >= 2;

--Using ORDER BY and TOP 1, write a select statement to find the album with the longest duration. The result should display the album title and the duration.
SELECT TOP 1 Title, AlbumLength
FROM Album
ORDER BY AlbumLength DESC;

--Using ORDER BY and TOP 1, write a select statement to find the song with the longest duration. The result should display the song title and the duration.
SELECT TOP 1 Title, SongLength
FROM Song
ORDER BY SongLength DESC;


--Modify the previous query to also display the title of the album.

SELECT TOP 1 Song.Title, Song.SongLength, Album.Title
FROM Song 
	INNER JOIN Album ON Album.Id = Song.AlbumId
ORDER BY SongLength DESC;
