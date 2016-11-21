-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Peter Nguyen
-- Create date: 08/31/2016
-- Description:	Initalize US Lottery Database
-- =============================================
ALTER PROCEDURE dbo.usp_InitalizeUSLottery (
	 @All varchar(1) = 'N'
	,@CreateTable varchar(1) = 'N'
	,@PopulateState varchar(1) = 'N'
	,@PopulateLotteryGame varchar(1) = 'N'
	,@PopulateLotteryGameState varchar(1) = 'N'
	,@PopulateGameDescription varchar(1) = 'N'
	,@PopulateGameRule varchar(1) = 'N'
	,@PopulateGameWinCondition varchar(1) = 'N'
	,@PopulateGameCost varchar(1) = 'N'
	,@EmptyTable varchar(50) = null
	,@DropTable varchar(50) = null
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if( @All = 'Y' )
		begin
			SET @CreateTable = 'Y';
			SET @PopulateState = 'Y';
			SET @PopulateLotteryGame = 'Y';
			SET @PopulateLotteryGameState = 'Y';
		end

SETUP:
	begin
		if( @CreateTable = 'Y') begin goto CREATE_TABLES end;
		if( @PopulateState = 'Y') begin goto POPULATE_STATE_TABLE end;
		if( @PopulateLotteryGame = 'Y') begin goto POPULATE_LOTTERY_GAME_TABLE end;
		if (@PopulateLotteryGameState = 'Y') begin goto POPULATE_LOTTERY_GAME_STATE_TABLE end;
		if (@PopulateGameDescription = 'Y') begin goto POPULATE_GAME_DESCRIPTION_TABLE end;
		if (@PopulateGameRule = 'Y') begin goto POPULATE_GAME_RULE_TABLE end;
		if (@PopulateGameWinCondition = 'Y') begin goto POPULATE_GAME_WIN_CONDITION_TABLE end;
		if (@PopulateGameCost = 'Y') begin goto POPULATE_GAME_COST_TABLE end;
		if( @EmptyTable IS NOT NULL) begin goto EMPTY_TABLE end;
		if( @DropTable IS NOT NULL) begin goto DROP_TABLE end;

		goto EXIT_SECTION;
	end

--------------------------------------------
--BEGIN CREATE TABLE SECTION
--------------------------------------------

CREATE_TABLES:
	begin
		if( OBJECT_ID('dbo.LotteryGame')) IS NULL
			begin
				create table dbo.LotteryGame (
					 LotteryGameId int not null identity(1,1) PRIMARY KEY
					,LotteryGameName varchar(50) not null
				);
			end
		
		if( OBJECT_ID('dbo.State')) IS NULL
			begin
				create table dbo.State (
					 StateId int not null identity(1,1) PRIMARY KEY
					,StateName varchar(50) not null
					,PostalAbbreviation varchar(2) not null
				);
			end

		if( OBJECT_ID('dbo.GameDescription')) IS NULL
			begin
				create table dbo.GameDescription (
					 GameDescriptionId int not null identity(1,1) PRIMARY KEY
					,GameDescription varchar(8000) null
				);
			end

		if( OBJECT_ID('dbo.GameRule')) IS NULL
			begin
				create table dbo.GameRule (
					 GameRuleId int not null identity(1,1) PRIMARY KEY
					,GameRule varchar(8000) null
				);
			end

		if( OBJECT_ID('dbo.GameWinCondition')) IS NULL
			begin
				create table dbo.GameWinCondition (
					 GameWinConditionId int not null identity(1,1) PRIMARY KEY
					,GameWinCondition varchar(8000) null
				);
			end

		if( OBJECT_ID('dbo.GameCost')) IS NULL
			begin
				create table dbo.GameCost (
					 GameCostId int not null identity(1,1) PRIMARY KEY
					,GameCost money null
				);
			end

		if( OBJECT_ID('dbo.LotteryGameState')) IS NULL
			begin
				create table dbo.LotteryGameState (
					 LotteryGameStateId int not null identity(1,1) PRIMARY KEY
					,LotteryGameId int FOREIGN KEY REFERENCES dbo.LotteryGame(LotteryGameId)
					,StateId int FOREIGN KEY REFERENCES dbo.State(StateId)
				);
			end

		if( OBJECT_ID('dbo.GameDetail')) IS NULL
			begin
				create table dbo.GameDetail (
					 GameDetailId int not null identity(1,1) PRIMARY KEY
					,LotteryGameStateId int FOREIGN KEY REFERENCES dbo.LotteryGameState(LotteryGameStateId)
					,GameDescriptionId int FOREIGN KEY REFERENCES dbo.GameDescription(GameDescriptionId)
					,GameRuleId int FOREIGN KEY REFERENCES dbo.GameRule(GameRuleId)
					,GameWinConditionId int FOREIGN KEY REFERENCES dbo.GameWinCondition(GameWinConditionId)
					,GameCostId int FOREIGN KEY REFERENCES dbo.GameCost(GameCostId)
				);
			end

		set @CreateTable = 'N';
		goto SETUP;

	end

--------------------------------------------
--POPULATE STATE TABLE SECTION
--------------------------------------------
POPULATE_STATE_TABLE:
	if( OBJECT_ID('dbo.State') IS NOT NULL )
		begin
			exec dbo.usp_ExecuteState 
					 @StateName = 'Minnesota'
					,@PostalAbbreviation = 'MN'
					,@QueryId = 10;


			exec dbo.usp_ExecuteState 
					 @StateName = 'Virgina'
					,@PostalAbbreviation = 'VA'
					,@QueryId = 10;

					
			exec dbo.usp_ExecuteState 
					 @StateName = 'California'
					,@PostalAbbreviation = 'CA'
					,@QueryId = 10;

			set @PopulateState = 'N';
			goto SETUP;

		end

--------------------------------------------
--POPULATE GAME TABLE SECTION
--------------------------------------------
POPULATE_LOTTERY_GAME_TABLE:
	if( OBJECT_ID('dbo.LotteryGame') IS NOT NULL)
		begin
			exec dbo.usp_ExecuteLotteryGame
					 @LotteryGameName = 'Powerball'
					,@QueryId = 10;

			exec dbo.usp_ExecuteLotteryGame
					 @LotteryGameName = 'Mega Millions'
					,@QueryId = 10;

			exec dbo.usp_ExecuteLotteryGame
					 @LotteryGameName = 'Gopher 5'
					,@QueryId = 10;

			exec dbo.usp_ExecuteLotteryGame
					 @LotteryGameName = 'NorthstarCash'
					,@QueryId = 10;

			set @PopulateLotteryGame = 'N';
			goto SETUP;

		end

--------------------------------------------
--POPULATE LOTTERY GAME STATE TABLE SECTION
--------------------------------------------
POPULATE_LOTTERY_GAME_STATE_TABLE:
	if( OBJECT_ID('dbo.LotteryGameState') IS NOT NULL )
		begin
			exec dbo.usp_ExecuteLotteryGameState
					 @LotteryGameId = 1
					,@StateId = 1
					,@QueryId = 10;

			exec dbo.usp_ExecuteLotteryGameState
					 @LotteryGameId = 2
					,@StateId = 1
					,@QueryId = 10;

			exec dbo.usp_ExecuteLotteryGameState
					 @LotteryGameId = 3
					,@StateId = 1
					,@QueryId = 10;

			exec dbo.usp_ExecuteLotteryGameState
					 @LotteryGameId = 4
					,@StateId = 1
					,@QueryId = 10;

			set @PopulateLotteryGameState = 'N';
			goto SETUP;

		end


--------------------------------------------
--POPULATE LOTTERY GAME STATE TABLE SECTION
--------------------------------------------
POPULATE_GAME_DESCRIPTION_TABLE:
	if( OBJECT_ID('dbo.GameDescription') IS NOT NULL )
		begin
			set @PopulateGameDescription = 'N';
			goto SETUP;
		end

--------------------------------------------
--POPULATE LOTTERY GAME STATE TABLE SECTION
--------------------------------------------
POPULATE_GAME_RULE_TABLE:
	if( OBJECT_ID('dbo.GameRule') IS NOT NULL )
		begin
			set @PopulateGameRule = 'N';
			goto SETUP;
		end

--------------------------------------------
--POPULATE LOTTERY GAME STATE TABLE SECTION
--------------------------------------------
POPULATE_GAME_WIN_CONDITION_TABLE:
	if( OBJECT_ID('dbo.GameWinCondition') IS NOT NULL )
		begin
			set @PopulateGameWinCondition = 'N';
			goto SETUP;
		end

--------------------------------------------
--POPULATE LOTTERY GAME STATE TABLE SECTION
--------------------------------------------
POPULATE_GAME_COST_TABLE:
	if( OBJECT_ID('dbo.GameCost') IS NOT NULL )
		begin
			set @PopulateGameCost = 'N';
			goto SETUP;
		end

--------------------------------------------
--EMPTY TABLE SECTION
--------------------------------------------
EMPTY_TABLE:
	begin
		if( @EmptyTable in ('ALL', 'all') )
			begin
				truncate table dbo.LotteryGameState;
				truncate table dbo.GameDetail;	
				truncate table dbo.GameDescription;
				truncate table dbo.GameRule;
				truncate table dbo.GameWinCondition;
				truncate table dbo.GameCost;							
				truncate table dbo.LotteryGame;
				truncate table dbo.State;
			end
		else
			if( OBJECT_ID('dbo.' + @EmptyTable) IS NOT NULL)
				begin
					declare @QueryEmpty varchar(255);
					set @QueryEmpty = 'truncate table dbo.' + @EmptyTable;
					exec (@QueryEmpty);
				end

		set @EmptyTable = NULL;
		goto SETUP;
	end

--------------------------------------------
--DROP TABLE SECTION
--------------------------------------------
DROP_TABLE:
	begin
		if( @DropTable in ('ALL', 'all') )
			begin
				drop table dbo.LotteryGameState;
				drop table dbo.GameDetail;
				drop table dbo.GameDescription;
				drop table dbo.GameRule;
				drop table dbo.GameWinCondition;
				drop table dbo.GameCost;
				drop table dbo.LotteryGame;
				drop table dbo.State;
			end
		else
			if( OBJECT_ID('dbo.' + @DropTable) IS NOT NULL)
				begin
					declare @QueryDrop varchar(255);
					set @QueryDrop = 'drop table dbo.' + @DropTable;
					exec (@QueryDrop);
				end

		set @DropTable = NULL;
		goto SETUP;
	end

--------------------------------------------
--EXIT SECTION
--------------------------------------------
EXIT_SECTION:

END
GO
