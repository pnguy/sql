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
-- Description:	Procedure to insert, update and delete Lottery Games in the LotteryGame table
-- =============================================
CREATE PROCEDURE dbo.usp_ExecuteLotteryGameState(
	 @LotteryGameStateId	int = null
	,@LotteryGameId			int = null
	,@StateId				int = null
	,@QueryId				int = 10
	,@ReturnValue			int = null output
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    if(@QueryId = 10) begin goto INSERT_ITEM end;
	if(@QueryId = 20) begin goto UPDATE_ITEM end;
	if(@QueryId = 30) begin goto DELETE_ITEM end;

	goto EXIT_SECTION;

----------------------------------
--BEGIN INSERT SECTION
----------------------------------
INSERT_ITEM:
	begin
		insert into dbo.LotteryGameState(	 LotteryGameId
											,StateId)
		values(	 @LotteryGameId
				,@StateId);

		set @ReturnValue = SCOPE_IDENTITY();

		goto EXIT_SECTION;
	end

----------------------------------
--BEGIN UPDATE SECTION
----------------------------------
UPDATE_ITEM:
	begin
		update	 dbo.LotteryGameState
		set		 LotteryGameId = ISNULL( @LotteryGameId, LotteryGameId)
				,StateId = ISNULL( @StateId, StateId)
		where	 LotteryGameStateId = @LotteryGameStateId;

		set @ReturnValue = @LotteryGameStateId;

		goto EXIT_SECTION;
	end

----------------------------------
--BEGIN DELETE SECTION
----------------------------------
DELETE_ITEM:
	begin
		delete
		from		dbo.LotteryGameState
		where		LotteryGameStateId = @LotteryGameStateId;

		set @ReturnValue = @LotteryGameStateId;

		goto EXIT_SECTION;
	end

----------------------------------
--EXIT SECTION
----------------------------------
EXIT_SECTION:

END
GO
