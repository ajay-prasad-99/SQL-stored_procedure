-- FUNCTIONS
--reusability, within function only select, error handling not possible, 
   -- only input parameter - no output parameter , return is mandatory , function will return always
   -- only one result set, we have to return the result set
   -- almost act as table , on execution
   -- function can be used in JOIN query also, call a function from SP, but can't call SP from function


-- SCALAR FUNCTION

CREATE FUNCTION	east_or_west (@long decimal (9,6))
RETURNS CHAR (4)
AS 
BEGIN
	DECLARE @return_value CHAR(4);
	SET @return_value = 'same';
	IF (@long > 0.00) SET @return_value = 'EAST';
	IF (@long < 0.00) SET @return_value = 'WEST';

	RETURN @return_value
END;

GO

SELECT dbo.east_or_west(0) as arg_0,
		dbo.east_or_west(1) as arg_1,
		dbo.east_or_west(-1) as arg_minus1;

;
-- 
CREATE FUNCTION sales.udfNetSale(
		@quantity INT,
		@list_price DEC (10,2),
		@discount DEC (4,2)
)
RETURNS DEC(10,2)
AS
BEGIN
	RETURN @quantity * @list_price * (1-@discount);
END;

GO
 
SELECT sales.udfNetSale (10,100,0.1) as net_sale;

-- APPLYING FUNCTION ON SELECT QUERY

select 
	order_id,
	SUM (sales.udfNetSale(quantity, list_price, discount)) net_amount
FROM
	sales.order_items
GROUP BY
	order_id
ORDER BY 
	net_amount DESC;

-- CREATING FUNCTIONS

--Highest salary from the table

CREATE FUNCTION gethighsal()
RETURNS DECIMAL(9,2)
AS
BEGIN
	DECLARE @sal DECIMAL(9,2)
	SELECT @sal = max(salary) from employees
	return @sal;
END;

select dbo.gethighsal();


-- LOWEST SALARY

CREATE FUNCTION lowSal()
RETURNS DECIMAL (7,2)
AS
BEGIN
	DECLARE @SAL DECIMAL (9,2)
	SELECT @SAL = min (salary) from employees
	RETURN @SAL;
END;

select dbo.lowSal();

-- AVERAGE SALARY

CREATE FUNCTION AvgSal()
RETURNS DECIMAL (7,2)
AS
BEGIN
	DECLARE @SAL DECIMAL (9,2)
	SELECT @SAL = avg (salary) from employees
	RETURN @SAL;
END;


select dbo.AvgSal();

-- RETURN STUDENT NAME BASED ON ID


alter FUNCTION getstudname (@stid int) 
RETURNS CHAR (20)
AS
BEGIN

	declare @stname char (20)
	select @stname = first_name from employees where employee_id = @stid;
	return @stname;
END;


select dbo.getstudname(110) as studname;
							--alias when calling

-- category name 

CREATE FUNCTION getCategoryname1 (@product_id INT)
RETURNS VARCHAR (50)
AS
BEGIN
		DECLARE	@category_name VARCHAR (50)

		SELECT @category_name =  category_name
		FROM production.products prp
		inner join production.categories pc on pc.category_id = prp.category_id
		WHERE product_id = @product_id

		RETURN @category_name
END


SELECT dbo.getCategoryname1(15)


--      TABLE VALUES FUNCTIONS   ----


ALTER FUNCTION udfProductInyear (@model_year int)
RETURNS TABLE
AS
RETURN
	SELECT product_name , product_id, list_price from 
	production.products where model_year = @model_year;

SELECT * from dbo.udfProductInyear(2016);

-- Multi statement table valued function

CREATE FUNCTION udfContacts()
	RETURNS @contacts TABLE ( 
		first_name VARCHAR(50),
		last_name VARCHAR(50),
		email VARCHAR(255),
		phone VARCHAR(25),
		contact_type VARCHAR(20)
		)
AS
BEGIN
	INSERT INTO @contacts
	SELECT
		first_name,
		last_name,
		email,
		phone,
		'Staff'
	FROM
		sales.staffs;

	INSERT INTO @contacts
	SELECT
		first_name,
		last_name,
		email,
		phone,
		 'Customer'
	FROM
		sales.customers;
	RETURN;
END;

select * from dbo.udfcontacts()

-- FUNCTION TO RETURN ORDER DETAILS BASED ON CUSTOMER_ID

ALTER FUNCTION udf_getorderinfo(@customerId INT)
RETURNS TABLE
AS
	RETURN 
		SELECT C.first_name + ' ' + C.last_name AS CustomerName, O.*
		FROM sales.customers C
		INNER JOIN SALES.orders O ON C.customer_id = O.customer_id
		WHERE C.customer_id = @customerId

SELECT * FROM dbo.udf_getorderinfo(16)

select * from sales.customers;

select * from sales.orders;
