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
-- Description:	D-02-Stored-Procedures-LAB part 1 GetClient stored procedure
-- =============================================
CREATE PROCEDURE dbo.usp_GetClient (
	@ClientId	int = null,
	@QueryId	int = 10
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	if (@QueryId = 10) begin goto GET_ITEM end;
	if (@QueryId = 20) begin goto GET_COLLECTION end;

	goto EXIT_SECTION;

----------------------------
-- GET ITEM SECTION
---------------------------- 
GET_ITEM:
	begin
		SELECT 
			 a.ClientId
			,a.ClientName
			,a.CreateDate
		FROM
			 dbo.Client as a
		WHERE
			 a.ClientId = @ClientId

		goto EXIT_SECTION;
	end

----------------------------
-- GET COLLECTION SECTION
---------------------------- 
GET_COLLECTION:
	begin
		SELECT
			 a.ClientId
			,a.ClientName
			,a.CreateDate
		FROM
			dbo.Client as a

		goto EXIT_SECTION;
	end

----------------------------
-- EXIT SECTION
---------------------------- 
EXIT_SECTION:

END
GO
