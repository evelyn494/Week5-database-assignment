
-- QUESTION 0NE
DROP INDEX IdxPhone ON customers;

-- QUESTION TWO
CREATE USER 'bob'@'localhost' IDENTIFIED BY 'S$cu3r3!';

--QUESTION THREE
GRANT INSERT ON salesDB.* TO 'bob'@'localhost';

--QUESTION FOUR
ALTER USER 'bob'@'localhost' IDENTIFIED BY 'P$55!23';
