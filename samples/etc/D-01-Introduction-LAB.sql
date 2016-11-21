--// D-01-Introduction-LAB //

print '-------------------------------------------------------------------';
print 'Lab Part 1:';


declare @Integer int;
declare @Varchar varchar(50);
declare @DateTime datetime;

set @Integer = 5;
set @Varchar = 'Test';
set @DateTime = getdate();

Print @Integer;
Print @Varchar;
Print @DateTime;

print '-------------------------------------------------------------------';
print 'Lab Part 2:';


declare @CurrentYear varchar(50);
declare @NextLeapYear varchar(50);
declare @Year int;

set @Year = YEAR(getdate());

if ((@Year % 4 = 0 ) AND (@Year % 100 != 0) OR (@Year % 400 = 0))
	begin
		set @CurrentYear = cast(@Year as varchar(4)) + ' is a leap year.';
		set @NextLeapYear = cast(@Year + 4 as varchar(4)) + ' is the next leap year.';
	end
else
	begin
		set @CurrentYear = cast(@Year as varchar(4)) + ' is not a leap year.';
		set @NextLeapYear = cast(@Year + (4 - @Year % 4) as varchar(4)) + ' is the next leap year.';
	end

print @CurrentYear;
print @NextLeapYear;

print '-------------------------------------------------------------------';
print 'Lab Part 3:';


declare @Pay varchar(50),
		@PayType varchar(50),
		@PayHour float = null,
		@PayMonth float = null,
		@PayYear float = null;

set @Pay = '20000';
set @PayType = 'Yearly';

set @Pay = replace(@Pay, ',', '');

if (@PayType NOT IN ('Yearly', 'Monthly', 'Hourly'))
	goto ERROR_PAYTYPE;
else if (ISNUMERIC(@Pay) <> 1)
	goto ERROR_PAY;
else if (@PayType = 'Yearly')
	begin
		set @PayYear = cast(@Pay as float);
		goto CONVERT_TO_HOURLY;
	end
else if (@PayType = 'Monthly')
	begin
		set @PayMonth = cast(@Pay as float);
		goto CONVERT_TO_HOURLY;
	end
else
	begin	
		set @PayHour = cast(@Pay as float);
		goto CONVERT_TO_MONTHLY;
	end

CONVERT_TO_HOURLY:
	begin
		if (@PayType = 'Yearly')
			begin
				set @PayHour = cast(@Pay as float) / 2080;
				goto CONVERT_TO_MONTHLY;
			end
		else
			begin
				set @PayHour = cast(@Pay as float) * 12 / 2080;
				goto CONVERT_TO_YEARLY;
			end
	end

CONVERT_TO_MONTHLY:
	begin
		if (@PayType = 'Hourly')
			begin
				set @PayMonth = cast(@Pay as float) * 2080 / 12;
				goto CONVERT_TO_YEARLY;
			end
		else
			begin
				set @PayMonth = cast(@Pay as float) / 12;
				goto EXIT_SECTION;
			end
	end

CONVERT_TO_YEARLY:
	begin
		if (@PayType = 'Hourly')
			set @PayYear = cast(@Pay as float) * 2080;
		else
			set @PayYear = cast(@Pay as float) * 12;
		goto EXIT_SECTION;
	end

ERROR_PAYTYPE:
	print 'Invalid Pay Type';
	goto EXIT_SECTION;

ERROR_PAY:
	print 'Invalid Pay value';
	goto EXIT_SECTION;

EXIT_SECTION:
	print 'Hourly pay: ' + cast(@PayHour as varchar(50));
	print 'Monthly pay: ' + cast(@PayMonth as varchar(50));
	print 'Yearly pay: ' + cast(@PayYear as varchar(50));
