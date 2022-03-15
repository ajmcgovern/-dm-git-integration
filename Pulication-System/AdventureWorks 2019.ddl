
CREATE TYPE [AccountNbr]
	FROM NVARCHAR(15) NULL
go

CREATE TYPE [Flag]
	FROM BIT NOT NULL
go

CREATE TYPE [NamStyle]
	FROM BIT NOT NULL
go

CREATE TYPE [Nam]
	FROM NVARCHAR(50) NULL
go

CREATE TYPE [OrdrNbr]
	FROM NVARCHAR(25) NULL
go

CREATE TYPE [Phn]
	FROM NVARCHAR(25) NULL
go

CREATE TABLE [Addr]
( 
	[AddrID]             int  IDENTITY ( 1,1 ) NOT FOR REPLICATION  NOT NULL ,
	[AddrLine1]          nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[AddrLine2]          nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[Cty]                nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[StProvinceID]       int  NOT NULL ,
	[PostalCd]           nvarchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[SpatialLocation]    geography  NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_Address_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Address_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [AddrTyp]
( 
	[AddrTypID]          int  IDENTITY ( 1,1 )  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_AddressType_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_AddressType_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [AWBuildVersion]
( 
	[SystemInfID]        tinyint  IDENTITY ( 1,1 )  NOT NULL ,
	[Database Version]   nvarchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[VersionDt]          datetime  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_AWBuildVersion_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [BillOfMaterials]
( 
	[BillOfMaterialsID]  int  IDENTITY ( 1,1 )  NOT NULL ,
	[ProductAssemblyID]  int  NULL ,
	[ComponentID]        int  NOT NULL ,
	[StartDt]            datetime  NOT NULL 
	CONSTRAINT [DF_BillOfMaterials_StartDate]
		 DEFAULT  getdate(),
	[EndDt]              datetime  NULL ,
	[UnitMeasureCd]      nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[BOMLevel]           smallint  NOT NULL ,
	[PerAssemblyQty]     decimal(8,2)  NOT NULL 
	CONSTRAINT [DF_BillOfMaterials_PerAssemblyQty]
		 DEFAULT  1.00,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_BillOfMaterials_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [BillOfMaterials]
	 WITH CHECK ADD CONSTRAINT [CK_BillOfMaterials_PerAssembly] CHECK  ( PerAssemblyQty >= 1.00 )
go

CREATE TABLE [BusinessEntity]
( 
	[BusinessEntityID]   int  IDENTITY ( 1,1 ) NOT FOR REPLICATION  NOT NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_BusinessEntity_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_BusinessEntity_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [BusinessEntityAddr]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[AddrID]             int  NOT NULL ,
	[AddrTypID]          int  NOT NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_BusinessEntityAddress_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_BusinessEntityAddress_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [BusinessEntityContact]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[PersonID]           int  NOT NULL ,
	[ContactTypID]       int  NOT NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_BusinessEntityContact_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_BusinessEntityContact_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [ContactTyp]
( 
	[ContactTypID]       int  IDENTITY ( 1,1 )  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ContactType_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [CountryRgn]
( 
	[CountryRgnCd]       nvarchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_CountryRegion_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [CountryRgnCurrency]
( 
	[CountryRgnCd]       nvarchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[CurrencyCd]         nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_CountryRegionCurrency_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [CrdCard]
( 
	[CrdCardID]          int  IDENTITY ( 1,1 )  NOT NULL ,
	[CardTyp]            nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[CardNbr]            nvarchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[ExpMonth]           tinyint  NOT NULL ,
	[ExpYr]              smallint  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_CreditCard_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [Culture]
( 
	[CultureID]          nchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Culture_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [Currency]
( 
	[CurrencyCd]         nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Currency_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [CurrencyRate]
( 
	[CurrencyRateID]     int  IDENTITY ( 1,1 )  NOT NULL ,
	[CurrencyRateDt]     datetime  NOT NULL ,
	[FromCurrencyCd]     nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[ToCurrencyCd]       nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[AverageRate]        money  NOT NULL ,
	[EndOfDayRate]       money  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_CurrencyRate_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [Cust]
( 
	[CustID]             int  IDENTITY ( 1,1 ) NOT FOR REPLICATION  NOT NULL ,
	[PersonID]           int  NULL ,
	[StorID]             int  NULL ,
	[TerritoryID]        int  NULL ,
	[AccountNbr]         AS (isnull('AW'+[dbo].[ufnLeadingZeros]([CustomerID]),'')) COLLATE SQL_Latin1_General_CP1_CI_AS ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_Customer_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Customer_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [DatabaseLog]
( 
	[DatabaseLogID]      int  IDENTITY ( 1,1 )  NOT NULL ,
	[PostTime]           datetime  NOT NULL ,
	[DatabaseUser]       sysname  NOT NULL ,
	[Event]              sysname  NOT NULL ,
	[Schema]             sysname  NULL ,
	[Object]             sysname  NULL ,
	[TSQL]               nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[XmlEvent]           xml  NOT NULL 
)
go

CREATE TABLE [Department]
( 
	[DepartmentID]       smallint  IDENTITY ( 1,1 )  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[GroupNam]           [Nam]  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Department_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [Document]
( 
	[DocumentNode]       hierarchyid  NOT NULL ,
	[DocumentLevel]      AS ([DocumentNode].[GetLevel]()) ,
	[Title]              nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Owner]              int  NOT NULL ,
	[FolderFlag]         bit  NOT NULL 
	CONSTRAINT [DF_Document_FolderFlag]
		 DEFAULT  0,
	[FileNam]            nvarchar(400) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[FileExtension]      nvarchar(8) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Revision]           nchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[ChangeNbr]          int  NOT NULL 
	CONSTRAINT [DF_Document_ChangeNumber]
		 DEFAULT  0,
	[Stat]               tinyint  NOT NULL ,
	[DocumentSummary]    nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[Document]           varbinary(max)  NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_Document_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Document_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [Document]
	 WITH CHECK ADD CONSTRAINT [CK_Document_Status] CHECK  ( Stat BETWEEN 1 AND 3 )
go

CREATE TABLE [EmailAddr]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[EmailAddrID]        int  IDENTITY ( 1,1 )  NOT NULL ,
	[EmailAddr]          nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_EmailAddress_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_EmailAddress_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [Emp]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[NationalIDNbr]      nvarchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[LoginID]            nvarchar(256) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[OrganizationNode]   hierarchyid  NULL ,
	[OrganizationLevel]  AS ([OrganizationNode].[GetLevel]()) ,
	[JobTitle]           nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[BirthDt]            date  NOT NULL ,
	[MaritalStat]        nchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Gender]             nchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[HireDt]             date  NOT NULL ,
	[SalariedFlag]       [Flag]  NOT NULL 
	CONSTRAINT [DF_Employee_SalariedFlag]
		 DEFAULT  1,
	[VacationHours]      smallint  NOT NULL 
	CONSTRAINT [DF_Employee_VacationHours]
		 DEFAULT  0,
	[SickLeaveHours]     smallint  NOT NULL 
	CONSTRAINT [DF_Employee_SickLeaveHours]
		 DEFAULT  0,
	[CurrentFlag]        [Flag]  NOT NULL 
	CONSTRAINT [DF_Employee_CurrentFlag]
		 DEFAULT  1,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_Employee_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Employee_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [Emp]
	 WITH CHECK ADD CONSTRAINT [CK_Employee_BirthDate] CHECK  ( BirthDt BETWEEN '1930-01-01' AND 'dateadd(year,(-18),getdate' )
go

ALTER TABLE [Emp]
	 WITH CHECK ADD CONSTRAINT [CK_Employee_MaritalStatus] CHECK  ( [MaritalStat]='S' OR [MaritalStat]='M' )
go

ALTER TABLE [Emp]
	 WITH CHECK ADD CONSTRAINT [CK_Employee_Gender] CHECK  ( [Gender]='F' OR [Gender]='M' )
go

ALTER TABLE [Emp]
	 WITH CHECK ADD CONSTRAINT [CK_Employee_HireDate] CHECK  ( HireDt BETWEEN '1996-07-01' AND 'dateadd(day,(1),getdate' )
go

ALTER TABLE [Emp]
	 WITH CHECK ADD CONSTRAINT [CK_Employee_VacationHours] CHECK  ( VacationHours BETWEEN -40 AND 240 )
go

ALTER TABLE [Emp]
	 WITH CHECK ADD CONSTRAINT [CK_Employee_SickLeaveHours] CHECK  ( SickLeaveHours BETWEEN 0 AND 120 )
go

CREATE TABLE [EmpDepartmentHist]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[DepartmentID]       smallint  NOT NULL ,
	[ShiftID]            tinyint  NOT NULL ,
	[StartDt]            date  NOT NULL ,
	[EndDt]              date  NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_EmployeeDepartmentHistory_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [EmpPayHist]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[RateChangeDt]       datetime  NOT NULL ,
	[Rate]               money  NOT NULL ,
	[PayFrequency]       tinyint  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_EmployeePayHistory_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [EmpPayHist]
	 WITH CHECK ADD CONSTRAINT [CK_EmployeePayHistory_Rate] CHECK  ( Rate BETWEEN 6.50 AND 200.00 )
go

ALTER TABLE [EmpPayHist]
	 WITH CHECK ADD CONSTRAINT [CK_EmployeePayHistory_PayFrequ] CHECK  ( [PayFrequency]=2 OR [PayFrequency]=1 )
go

CREATE TABLE [ErrorLog]
( 
	[ErrorLogID]         int  IDENTITY ( 1,1 )  NOT NULL ,
	[ErrorTime]          datetime  NOT NULL 
	CONSTRAINT [DF_ErrorLog_ErrorTime]
		 DEFAULT  getdate(),
	[UserNam]            sysname  NOT NULL ,
	[ErrorNbr]           int  NOT NULL ,
	[ErrorSeverity]      int  NULL ,
	[ErrorSt]            int  NULL ,
	[ErrorProcedure]     nvarchar(126) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[ErrorLine]          int  NULL ,
	[ErrorMessage]       nvarchar(4000) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL 
)
go

CREATE TABLE [Illustration]
( 
	[IllustrationID]     int  IDENTITY ( 1,1 )  NOT NULL ,
	[Diagram]            xml  NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Illustration_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [JobCandiDt]
( 
	[JobCandiDtID]       int  IDENTITY ( 1,1 )  NOT NULL ,
	[BusinessEntityID]   int  NULL ,
	[Resume]             xml ( CONTENT [HRResumeSchemaCollection] ) NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_JobCandidate_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [Location]
( 
	[LocationID]         smallint  IDENTITY ( 1,1 )  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[CostRate]           smallmoney  NOT NULL 
	CONSTRAINT [DF_Location_CostRate]
		 DEFAULT  0.00,
	[Availability]       decimal(8,2)  NOT NULL 
	CONSTRAINT [DF_Location_Availability]
		 DEFAULT  0.00,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Location_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [Location]
	 WITH CHECK ADD CONSTRAINT [CK_Location_CostRate] CHECK  ( CostRate >= 0.00 )
go

ALTER TABLE [Location]
	 WITH CHECK ADD CONSTRAINT [CK_Location_Availability] CHECK  ( Availability >= 0.00 )
go

CREATE TABLE [Password]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[PasswordHash]       varchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[PasswordSalt]       varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_Password_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Password_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [Person]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[PersonTyp]          nchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[NamStyle]           [NamStyle]  NOT NULL 
	CONSTRAINT [DF_Person_NameStyle]
		 DEFAULT  0,
	[Title]              nvarchar(8) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[FrstNam]            [Nam]  NOT NULL ,
	[MiddleNam]          [Nam]  NULL ,
	[LstNam]             [Nam]  NOT NULL ,
	[Suffix]             nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[EmailPromotion]     int  NOT NULL 
	CONSTRAINT [DF_Person_EmailPromotion]
		 DEFAULT  0,
	[AdditionalContactInfo] xml ( CONTENT [AdditionalContactInfoSchemaCollection] ) NULL ,
	[Demographics]       xml ( CONTENT [IndividualSurveySchemaCollection] ) NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_Person_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Person_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [Person]
	 WITH CHECK ADD CONSTRAINT [CK_Person_PersonType] CHECK  ( [PersonType] IS NULL OR (upper([PersonType])='GC' OR upper([PersonType])='SP' OR upper([PersonType])='EM' OR upper([PersonType])='IN' OR upper([PersonType])='VC' OR upper([PersonType])='SC') )
go

ALTER TABLE [Person]
	 WITH CHECK ADD CONSTRAINT [CK_Person_EmailPromotion] CHECK  ( EmailPromotion BETWEEN 0 AND 2 )
go

CREATE TABLE [PersonCrdCard]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[CrdCardID]          int  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_PersonCreditCard_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [PersonPhn]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[PhnNbr]             [Phn]  NOT NULL ,
	[PhnNbrTypID]        int  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_PersonPhone_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [PhnNbrTyp]
( 
	[PhnNbrTypID]        int  IDENTITY ( 1,1 )  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_PhoneNumberType_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [Product]
( 
	[ProductID]          int  IDENTITY ( 1,1 )  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[ProductNbr]         nvarchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[MakeFlag]           [Flag]  NOT NULL 
	CONSTRAINT [DF_Product_MakeFlag]
		 DEFAULT  1,
	[FinishedGoodsFlag]  [Flag]  NOT NULL 
	CONSTRAINT [DF_Product_FinishedGoodsFlag]
		 DEFAULT  1,
	[Color]              nvarchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[SafetyStockLevel]   smallint  NOT NULL ,
	[ReOrdrPoint]        smallint  NOT NULL ,
	[StandardCost]       money  NOT NULL ,
	[ListPrice]          money  NOT NULL ,
	[Size]               nvarchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[SizeUnitMeasureCd]  nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[WeightUnitMeasureCd] nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[Weight]             decimal(8,2)  NULL ,
	[DaysToManufacture]  int  NOT NULL ,
	[ProductLine]        nchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[Class]              nchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[Style]              nchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[ProductSubcategoryID] int  NULL ,
	[ProductModelID]     int  NULL ,
	[SellStartDt]        datetime  NOT NULL ,
	[SellEndDt]          datetime  NULL ,
	[DiscontinuedDt]     datetime  NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_Product_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Product_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [Product]
	 WITH CHECK ADD CONSTRAINT [CK_Product_SafetyStockLevel] CHECK  ( [SafetyStockLevel]>(0) )
go

ALTER TABLE [Product]
	 WITH CHECK ADD CONSTRAINT [CK_Product_ReorderPoint] CHECK  ( [ReorderPoint]>(0) )
go

ALTER TABLE [Product]
	 WITH CHECK ADD CONSTRAINT [CK_Product_StandardCost] CHECK  ( StandardCost >= 0.00 )
go

ALTER TABLE [Product]
	 WITH CHECK ADD CONSTRAINT [CK_Product_ListPrice] CHECK  ( ListPrice >= 0.00 )
go

ALTER TABLE [Product]
	 WITH CHECK ADD CONSTRAINT [CK_Product_Weight] CHECK  ( [Weight]>(0.00) )
go

ALTER TABLE [Product]
	 WITH CHECK ADD CONSTRAINT [CK_Product_DaysToManufacture] CHECK  ( DaysToManufacture >= 0 )
go

ALTER TABLE [Product]
	 WITH CHECK ADD CONSTRAINT [CK_Product_ProductLine] CHECK  ( upper([ProductLine])='R' OR upper([ProductLine])='M' OR upper([ProductLine])='T' OR upper([ProductLine])='S' OR [ProductLine] IS NULL )
go

ALTER TABLE [Product]
	 WITH CHECK ADD CONSTRAINT [CK_Product_Class] CHECK  ( upper([Class])='H' OR upper([Class])='M' OR upper([Class])='L' OR [Class] IS NULL )
go

ALTER TABLE [Product]
	 WITH CHECK ADD CONSTRAINT [CK_Product_Style] CHECK  ( upper([Style])='U' OR upper([Style])='M' OR upper([Style])='W' OR [Style] IS NULL )
go

CREATE TABLE [ProductCategory]
( 
	[ProductCategoryID]  int  IDENTITY ( 1,1 )  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_ProductCategory_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ProductCategory_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [ProductCostHist]
( 
	[ProductID]          int  NOT NULL ,
	[StartDt]            datetime  NOT NULL ,
	[EndDt]              datetime  NULL ,
	[StandardCost]       money  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ProductCostHistory_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [ProductCostHist]
	 WITH CHECK ADD CONSTRAINT [CK_ProductCostHistory_Standard] CHECK  ( StandardCost >= 0.00 )
go

CREATE TABLE [ProductDesc]
( 
	[ProductDescID]      int  IDENTITY ( 1,1 )  NOT NULL ,
	[Desc]               nvarchar(400) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_ProductDescription_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ProductDescription_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [ProductDocument]
( 
	[ProductID]          int  NOT NULL ,
	[DocumentNode]       hierarchyid  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ProductDocument_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [ProductInventory]
( 
	[ProductID]          int  NOT NULL ,
	[LocationID]         smallint  NOT NULL ,
	[Shelf]              nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Bin]                tinyint  NOT NULL ,
	[Qty]                smallint  NOT NULL 
	CONSTRAINT [DF_ProductInventory_Quantity]
		 DEFAULT  0,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_ProductInventory_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ProductInventory_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [ProductInventory]
	 WITH CHECK ADD CONSTRAINT [CK_ProductInventory_Shelf] CHECK  ( [Shelf] like '[A-Za-z]' OR [Shelf]='N/A' )
go

ALTER TABLE [ProductInventory]
	 WITH CHECK ADD CONSTRAINT [CK_ProductInventory_Bin] CHECK  ( Bin BETWEEN 0 AND 100 )
go

CREATE TABLE [ProductListPriceHist]
( 
	[ProductID]          int  NOT NULL ,
	[StartDt]            datetime  NOT NULL ,
	[EndDt]              datetime  NULL ,
	[ListPrice]          money  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ProductListPriceHistory_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [ProductListPriceHist]
	 WITH CHECK ADD CONSTRAINT [CK_ProductListPriceHistory_Lis] CHECK  ( [ListPrice]>(0.00) )
go

CREATE TABLE [ProductModel]
( 
	[ProductModelID]     int  IDENTITY ( 1,1 )  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[CatalogDesc]        xml ( CONTENT [ProductDescriptionSchemaCollection] ) NULL ,
	[Instructions]       xml ( CONTENT [ManuInstructionsSchemaCollection] ) NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_ProductModel_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ProductModel_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [ProductModelIllustration]
( 
	[ProductModelID]     int  NOT NULL ,
	[IllustrationID]     int  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ProductModelIllustration_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [ProductModelProductDescCulture]
( 
	[ProductModelID]     int  NOT NULL ,
	[ProductDescID]      int  NOT NULL ,
	[CultureID]          nchar(6) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ProductModelProductDescriptionCulture_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [ProductPhoto]
( 
	[ProductPhotoID]     int  IDENTITY ( 1,1 )  NOT NULL ,
	[ThumbNailPhoto]     varbinary(max)  NULL ,
	[ThumbnailPhotoFileNam] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[LargePhoto]         varbinary(max)  NULL ,
	[LargePhotoFileNam]  nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ProductPhoto_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [ProductProductPhoto]
( 
	[ProductID]          int  NOT NULL ,
	[ProductPhotoID]     int  NOT NULL ,
	[Primary]            [Flag]  NOT NULL 
	CONSTRAINT [DF_ProductProductPhoto_Primary]
		 DEFAULT  0,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ProductProductPhoto_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [ProductReview]
( 
	[ProductReviewID]    int  IDENTITY ( 1,1 )  NOT NULL ,
	[ProductID]          int  NOT NULL ,
	[ReviewerNam]        [Nam]  NOT NULL ,
	[ReviewDt]           datetime  NOT NULL 
	CONSTRAINT [DF_ProductReview_ReviewDate]
		 DEFAULT  getdate(),
	[EmailAddr]          nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Rating]             int  NOT NULL ,
	[Comments]           nvarchar(3850) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ProductReview_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [ProductReview]
	 WITH CHECK ADD CONSTRAINT [CK_ProductReview_Rating] CHECK  ( Rating BETWEEN 1 AND 5 )
go

CREATE TABLE [ProductSubcategory]
( 
	[ProductSubcategoryID] int  IDENTITY ( 1,1 )  NOT NULL ,
	[ProductCategoryID]  int  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_ProductSubcategory_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ProductSubcategory_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [ProductVendor]
( 
	[ProductID]          int  NOT NULL ,
	[BusinessEntityID]   int  NOT NULL ,
	[AverageLeadTime]    int  NOT NULL ,
	[StandardPrice]      money  NOT NULL ,
	[LstReceiptCost]     money  NULL ,
	[LstReceiptDt]       datetime  NULL ,
	[MinOrdrQty]         int  NOT NULL ,
	[MaxOrdrQty]         int  NOT NULL ,
	[OnOrdrQty]          int  NULL ,
	[UnitMeasureCd]      nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ProductVendor_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [ProductVendor]
	 WITH CHECK ADD CONSTRAINT [CK_ProductVendor_AverageLeadTi] CHECK  ( AverageLeadTime >= 1 )
go

ALTER TABLE [ProductVendor]
	 WITH CHECK ADD CONSTRAINT [CK_ProductVendor_StandardPrice] CHECK  ( [StandardPrice]>(0.00) )
go

ALTER TABLE [ProductVendor]
	 WITH CHECK ADD CONSTRAINT [CK_ProductVendor_LastReceiptCo] CHECK  ( [LastReceiptCost]>(0.00) )
go

ALTER TABLE [ProductVendor]
	 WITH CHECK ADD CONSTRAINT [CK_ProductVendor_MinOrderQty] CHECK  ( MinOrdrQty >= 1 )
go

ALTER TABLE [ProductVendor]
	 WITH CHECK ADD CONSTRAINT [CK_ProductVendor_MaxOrderQty] CHECK  ( MaxOrdrQty >= 1 )
go

ALTER TABLE [ProductVendor]
	 WITH CHECK ADD CONSTRAINT [CK_ProductVendor_OnOrderQty] CHECK  ( OnOrdrQty >= 0 )
go

CREATE TABLE [PurchaseOrdrDetail]
( 
	[PurchaseOrdrID]     int  NOT NULL ,
	[PurchaseOrdrDetailID] int  IDENTITY ( 1,1 )  NOT NULL ,
	[DueDt]              datetime  NOT NULL ,
	[OrdrQty]            smallint  NOT NULL ,
	[ProductID]          int  NOT NULL ,
	[UnitPrice]          money  NOT NULL ,
	[LineTotal]          AS (isnull([OrderQty]*[UnitPrice],(0.00))) ,
	[ReceivedQty]        decimal(8,2)  NOT NULL ,
	[RejectedQty]        decimal(8,2)  NOT NULL ,
	[StockedQty]         AS (isnull([ReceivedQty]-[RejectedQty],(0.00))) ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_PurchaseOrderDetail_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [PurchaseOrdrDetail]
	 WITH CHECK ADD CONSTRAINT [CK_PurchaseOrderDetail_OrderQt] CHECK  ( [OrderQty]>(0) )
go

ALTER TABLE [PurchaseOrdrDetail]
	 WITH CHECK ADD CONSTRAINT [CK_PurchaseOrderDetail_UnitPri] CHECK  ( UnitPrice >= 0.00 )
go

ALTER TABLE [PurchaseOrdrDetail]
	 WITH CHECK ADD CONSTRAINT [CK_PurchaseOrderDetail_Receive] CHECK  ( ReceivedQty >= 0.00 )
go

ALTER TABLE [PurchaseOrdrDetail]
	 WITH CHECK ADD CONSTRAINT [CK_PurchaseOrderDetail_Rejecte] CHECK  ( RejectedQty >= 0.00 )
go

CREATE TABLE [PurchaseOrdrHeader]
( 
	[PurchaseOrdrID]     int  IDENTITY ( 1,1 )  NOT NULL ,
	[RevisionNbr]        tinyint  NOT NULL 
	CONSTRAINT [DF_PurchaseOrderHeader_RevisionNumber]
		 DEFAULT  0,
	[Stat]               tinyint  NOT NULL 
	CONSTRAINT [DF_PurchaseOrderHeader_Status]
		 DEFAULT  1,
	[EmpID]              int  NOT NULL ,
	[VendorID]           int  NOT NULL ,
	[ShipMethodID]       int  NOT NULL ,
	[OrdrDt]             datetime  NOT NULL 
	CONSTRAINT [DF_PurchaseOrderHeader_OrderDate]
		 DEFAULT  getdate(),
	[ShipDt]             datetime  NULL ,
	[SubTotal]           money  NOT NULL 
	CONSTRAINT [DF_PurchaseOrderHeader_SubTotal]
		 DEFAULT  0.00,
	[TaxAmt]             money  NOT NULL 
	CONSTRAINT [DF_PurchaseOrderHeader_TaxAmt]
		 DEFAULT  0.00,
	[Freight]            money  NOT NULL 
	CONSTRAINT [DF_PurchaseOrderHeader_Freight]
		 DEFAULT  0.00,
	[TotalDue]           AS (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))) PERSISTED NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_PurchaseOrderHeader_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [PurchaseOrdrHeader]
	 WITH CHECK ADD CONSTRAINT [CK_PurchaseOrderHeader_Status] CHECK  ( Stat BETWEEN 1 AND 4 )
go

ALTER TABLE [PurchaseOrdrHeader]
	 WITH CHECK ADD CONSTRAINT [CK_PurchaseOrderHeader_SubTota] CHECK  ( SubTotal >= 0.00 )
go

ALTER TABLE [PurchaseOrdrHeader]
	 WITH CHECK ADD CONSTRAINT [CK_PurchaseOrderHeader_TaxAmt] CHECK  ( TaxAmt >= 0.00 )
go

ALTER TABLE [PurchaseOrdrHeader]
	 WITH CHECK ADD CONSTRAINT [CK_PurchaseOrderHeader_Freight] CHECK  ( Freight >= 0.00 )
go

CREATE TABLE [ScrapReason]
( 
	[ScrapReasonID]      smallint  IDENTITY ( 1,1 )  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ScrapReason_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [Shift]
( 
	[ShiftID]            tinyint  IDENTITY ( 1,1 )  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[StartTime]          time(7)  NOT NULL ,
	[EndTime]            time(7)  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Shift_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [ShipMethod]
( 
	[ShipMethodID]       int  IDENTITY ( 1,1 )  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[ShipBase]           money  NOT NULL 
	CONSTRAINT [DF_ShipMethod_ShipBase]
		 DEFAULT  0.00,
	[ShipRate]           money  NOT NULL 
	CONSTRAINT [DF_ShipMethod_ShipRate]
		 DEFAULT  0.00,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_ShipMethod_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ShipMethod_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [ShipMethod]
	 WITH CHECK ADD CONSTRAINT [CK_ShipMethod_ShipBase] CHECK  ( [ShipBase]>(0.00) )
go

ALTER TABLE [ShipMethod]
	 WITH CHECK ADD CONSTRAINT [CK_ShipMethod_ShipRate] CHECK  ( [ShipRate]>(0.00) )
go

CREATE TABLE [ShoppingCartitm]
( 
	[ShoppingCartitmID]  int  IDENTITY ( 1,1 )  NOT NULL ,
	[ShoppingCartID]     nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Qty]                int  NOT NULL 
	CONSTRAINT [DF_ShoppingCartItem_Quantity]
		 DEFAULT  1,
	[ProductID]          int  NOT NULL ,
	[DtCreated]          datetime  NOT NULL 
	CONSTRAINT [DF_ShoppingCartItem_DateCreated]
		 DEFAULT  getdate(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_ShoppingCartItem_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [ShoppingCartitm]
	 WITH CHECK ADD CONSTRAINT [CK_ShoppingCartItem_Quantity] CHECK  ( Qty >= 1 )
go

CREATE TABLE [SlsOrdrDetail]
( 
	[SlsOrdrID]          int  NOT NULL ,
	[SlsOrdrDetailID]    int  IDENTITY ( 1,1 )  NOT NULL ,
	[CarrierTrackingNbr] nvarchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[OrdrQty]            smallint  NOT NULL ,
	[ProductID]          int  NOT NULL ,
	[SpecialOfferID]     int  NOT NULL ,
	[UnitPrice]          money  NOT NULL ,
	[UnitPriceDisc]      money  NOT NULL 
	CONSTRAINT [DF_SalesOrderDetail_UnitPriceDiscount]
		 DEFAULT  0.0,
	[LineTotal]          AS (isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[OrderQty],(0.0))) ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_SalesOrderDetail_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_SalesOrderDetail_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [SlsOrdrDetail]
	 WITH CHECK ADD CONSTRAINT [CK_SalesOrderDetail_OrderQty] CHECK  ( [OrderQty]>(0) )
go

ALTER TABLE [SlsOrdrDetail]
	 WITH CHECK ADD CONSTRAINT [CK_SalesOrderDetail_UnitPrice] CHECK  ( UnitPrice >= 0.00 )
go

ALTER TABLE [SlsOrdrDetail]
	 WITH CHECK ADD CONSTRAINT [CK_SalesOrderDetail_UnitPriceD] CHECK  ( UnitPriceDisc >= 0.00 )
go

CREATE TABLE [SlsOrdrHeader]
( 
	[SlsOrdrID]          int  IDENTITY ( 1,1 ) NOT FOR REPLICATION  NOT NULL ,
	[RevisionNbr]        tinyint  NOT NULL 
	CONSTRAINT [DF_SalesOrderHeader_RevisionNumber]
		 DEFAULT  0,
	[OrdrDt]             datetime  NOT NULL 
	CONSTRAINT [DF_SalesOrderHeader_OrderDate]
		 DEFAULT  getdate(),
	[DueDt]              datetime  NOT NULL ,
	[ShipDt]             datetime  NULL ,
	[Stat]               tinyint  NOT NULL 
	CONSTRAINT [DF_SalesOrderHeader_Status]
		 DEFAULT  1,
	[OnlineOrdrFlag]     [Flag]  NOT NULL 
	CONSTRAINT [DF_SalesOrderHeader_OnlineOrderFlag]
		 DEFAULT  1,
	[SlsOrdrNbr]         AS (isnull(N'SO'+CONVERT([nvarchar](23),[SalesOrderID]),N'*** ERROR ***')) COLLATE SQL_Latin1_General_CP1_CI_AS ,
	[PurchaseOrdrNbr]    [OrdrNbr]  NULL ,
	[AccountNbr]         [AccountNbr]  NULL ,
	[CustID]             int  NOT NULL ,
	[SlsPersonID]        int  NULL ,
	[TerritoryID]        int  NULL ,
	[BillToAddrID]       int  NOT NULL ,
	[ShipToAddrID]       int  NOT NULL ,
	[ShipMethodID]       int  NOT NULL ,
	[CrdCardID]          int  NULL ,
	[CrdCardApprovalCd]  varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[CurrencyRateID]     int  NULL ,
	[SubTotal]           money  NOT NULL 
	CONSTRAINT [DF_SalesOrderHeader_SubTotal]
		 DEFAULT  0.00,
	[TaxAmt]             money  NOT NULL 
	CONSTRAINT [DF_SalesOrderHeader_TaxAmt]
		 DEFAULT  0.00,
	[Freight]            money  NOT NULL 
	CONSTRAINT [DF_SalesOrderHeader_Freight]
		 DEFAULT  0.00,
	[TotalDue]           AS (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))) ,
	[Comment]            nvarchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_SalesOrderHeader_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_SalesOrderHeader_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [SlsOrdrHeader]
	 WITH CHECK ADD CONSTRAINT [CK_SalesOrderHeader_Status] CHECK  ( Stat BETWEEN 0 AND 8 )
go

ALTER TABLE [SlsOrdrHeader]
	 WITH CHECK ADD CONSTRAINT [CK_SalesOrderHeader_SubTotal] CHECK  ( SubTotal >= 0.00 )
go

ALTER TABLE [SlsOrdrHeader]
	 WITH CHECK ADD CONSTRAINT [CK_SalesOrderHeader_TaxAmt] CHECK  ( TaxAmt >= 0.00 )
go

ALTER TABLE [SlsOrdrHeader]
	 WITH CHECK ADD CONSTRAINT [CK_SalesOrderHeader_Freight] CHECK  ( Freight >= 0.00 )
go

CREATE TABLE [SlsOrdrHeaderSlsReason]
( 
	[SlsOrdrID]          int  NOT NULL ,
	[SlsReasonID]        int  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_SalesOrderHeaderSalesReason_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [SlsPerson]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[TerritoryID]        int  NULL ,
	[SlsQuota]           money  NULL ,
	[Bonus]              money  NOT NULL 
	CONSTRAINT [DF_SalesPerson_Bonus]
		 DEFAULT  0.00,
	[CommissionPct]      smallmoney  NOT NULL 
	CONSTRAINT [DF_SalesPerson_CommissionPct]
		 DEFAULT  0.00,
	[SlsYTD]             money  NOT NULL 
	CONSTRAINT [DF_SalesPerson_SalesYTD]
		 DEFAULT  0.00,
	[SlsLstYr]           money  NOT NULL 
	CONSTRAINT [DF_SalesPerson_SalesLastYear]
		 DEFAULT  0.00,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_SalesPerson_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_SalesPerson_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [SlsPerson]
	 WITH CHECK ADD CONSTRAINT [CK_SalesPerson_SalesQuota] CHECK  ( [SalesQuota]>(0.00) )
go

ALTER TABLE [SlsPerson]
	 WITH CHECK ADD CONSTRAINT [CK_SalesPerson_Bonus] CHECK  ( Bonus >= 0.00 )
go

ALTER TABLE [SlsPerson]
	 WITH CHECK ADD CONSTRAINT [CK_SalesPerson_CommissionPct] CHECK  ( CommissionPct >= 0.00 )
go

ALTER TABLE [SlsPerson]
	 WITH CHECK ADD CONSTRAINT [CK_SalesPerson_SalesYTD] CHECK  ( SlsYTD >= 0.00 )
go

ALTER TABLE [SlsPerson]
	 WITH CHECK ADD CONSTRAINT [CK_SalesPerson_SalesLastYear] CHECK  ( SlsLstYr >= 0.00 )
go

CREATE TABLE [SlsPersonQuotaHist]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[QuotaDt]            datetime  NOT NULL ,
	[SlsQuota]           money  NOT NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_SalesPersonQuotaHistory_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_SalesPersonQuotaHistory_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [SlsPersonQuotaHist]
	 WITH CHECK ADD CONSTRAINT [CK_SalesPersonQuotaHistory_Sal] CHECK  ( [SalesQuota]>(0.00) )
go

CREATE TABLE [SlsReason]
( 
	[SlsReasonID]        int  IDENTITY ( 1,1 )  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[ReasonTyp]          [Nam]  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_SalesReason_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [SlsTaxRate]
( 
	[SlsTaxRateID]       int  IDENTITY ( 1,1 )  NOT NULL ,
	[StProvinceID]       int  NOT NULL ,
	[TaxTyp]             tinyint  NOT NULL ,
	[TaxRate]            smallmoney  NOT NULL 
	CONSTRAINT [DF_SalesTaxRate_TaxRate]
		 DEFAULT  0.00,
	[Nam]                [Nam]  NOT NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_SalesTaxRate_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_SalesTaxRate_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [SlsTaxRate]
	 WITH CHECK ADD CONSTRAINT [CK_SalesTaxRate_TaxType] CHECK  ( TaxTyp BETWEEN 1 AND 3 )
go

CREATE TABLE [SlsTerritory]
( 
	[TerritoryID]        int  IDENTITY ( 1,1 )  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[CountryRgnCd]       nvarchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Group]              nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[SlsYTD]             money  NOT NULL 
	CONSTRAINT [DF_SalesTerritory_SalesYTD]
		 DEFAULT  0.00,
	[SlsLstYr]           money  NOT NULL 
	CONSTRAINT [DF_SalesTerritory_SalesLastYear]
		 DEFAULT  0.00,
	[CostYTD]            money  NOT NULL 
	CONSTRAINT [DF_SalesTerritory_CostYTD]
		 DEFAULT  0.00,
	[CostLstYr]          money  NOT NULL 
	CONSTRAINT [DF_SalesTerritory_CostLastYear]
		 DEFAULT  0.00,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_SalesTerritory_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_SalesTerritory_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [SlsTerritory]
	 WITH CHECK ADD CONSTRAINT [CK_SalesTerritory_SalesYTD] CHECK  ( SlsYTD >= 0.00 )
go

ALTER TABLE [SlsTerritory]
	 WITH CHECK ADD CONSTRAINT [CK_SalesTerritory_SalesLastYea] CHECK  ( SlsLstYr >= 0.00 )
go

ALTER TABLE [SlsTerritory]
	 WITH CHECK ADD CONSTRAINT [CK_SalesTerritory_CostYTD] CHECK  ( CostYTD >= 0.00 )
go

ALTER TABLE [SlsTerritory]
	 WITH CHECK ADD CONSTRAINT [CK_SalesTerritory_CostLastYear] CHECK  ( CostLstYr >= 0.00 )
go

CREATE TABLE [SlsTerritoryHist]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[TerritoryID]        int  NOT NULL ,
	[StartDt]            datetime  NOT NULL ,
	[EndDt]              datetime  NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_SalesTerritoryHistory_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_SalesTerritoryHistory_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [SpecialOffer]
( 
	[SpecialOfferID]     int  IDENTITY ( 1,1 )  NOT NULL ,
	[Desc]               nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[DiscPct]            smallmoney  NOT NULL 
	CONSTRAINT [DF_SpecialOffer_DiscountPct]
		 DEFAULT  0.00,
	[Typ]                nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Category]           nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[StartDt]            datetime  NOT NULL ,
	[EndDt]              datetime  NOT NULL ,
	[MinQty]             int  NOT NULL 
	CONSTRAINT [DF_SpecialOffer_MinQty]
		 DEFAULT  0,
	[MaxQty]             int  NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_SpecialOffer_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_SpecialOffer_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [SpecialOffer]
	 WITH CHECK ADD CONSTRAINT [CK_SpecialOffer_DiscountPct] CHECK  ( DiscPct >= 0.00 )
go

ALTER TABLE [SpecialOffer]
	 WITH CHECK ADD CONSTRAINT [CK_SpecialOffer_MinQty] CHECK  ( MinQty >= 0 )
go

ALTER TABLE [SpecialOffer]
	 WITH CHECK ADD CONSTRAINT [CK_SpecialOffer_MaxQty] CHECK  ( MaxQty >= 0 )
go

CREATE TABLE [SpecialOfferProduct]
( 
	[SpecialOfferID]     int  NOT NULL ,
	[ProductID]          int  NOT NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_SpecialOfferProduct_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_SpecialOfferProduct_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [Stor]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[SlsPersonID]        int  NULL ,
	[Demographics]       xml ( CONTENT [StoreSurveySchemaCollection] ) NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_Store_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Store_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [StProvince]
( 
	[StProvinceID]       int  IDENTITY ( 1,1 )  NOT NULL ,
	[StProvinceCd]       nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[CountryRgnCd]       nvarchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[IsOnlyStProvinceFlag] [Flag]  NOT NULL 
	CONSTRAINT [DF_StateProvince_IsOnlyStateProvinceFlag]
		 DEFAULT  1,
	[Nam]                [Nam]  NOT NULL ,
	[TerritoryID]        int  NOT NULL ,
	[rowguid]            uniqueidentifier  ROWGUIDCOL  NOT NULL 
	CONSTRAINT [DF_StateProvince_rowguid]
		 DEFAULT  newid(),
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_StateProvince_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [TransactionHist]
( 
	[TransactionID]      int  IDENTITY ( 100000,1 )  NOT NULL ,
	[ProductID]          int  NOT NULL ,
	[ReferenceOrdrID]    int  NOT NULL ,
	[ReferenceOrdrLineID] int  NOT NULL 
	CONSTRAINT [DF_TransactionHistory_ReferenceOrderLineID]
		 DEFAULT  0,
	[TransactionDt]      datetime  NOT NULL 
	CONSTRAINT [DF_TransactionHistory_TransactionDate]
		 DEFAULT  getdate(),
	[TransactionTyp]     nchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Qty]                int  NOT NULL ,
	[ActualCost]         money  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_TransactionHistory_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [TransactionHist]
	 WITH CHECK ADD CONSTRAINT [CK_TransactionHistory_Transact] CHECK  ( [TransactionTyp]='P' OR [TransactionTyp]='S' OR [TransactionTyp]='W' )
go

CREATE TABLE [TransactionHistArchive]
( 
	[TransactionID]      int  NOT NULL ,
	[ProductID]          int  NOT NULL ,
	[ReferenceOrdrID]    int  NOT NULL ,
	[ReferenceOrdrLineID] int  NOT NULL 
	CONSTRAINT [DF_TransactionHistoryArchive_ReferenceOrderLineID]
		 DEFAULT  0,
	[TransactionDt]      datetime  NOT NULL 
	CONSTRAINT [DF_TransactionHistoryArchive_TransactionDate]
		 DEFAULT  getdate(),
	[TransactionTyp]     nchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Qty]                int  NOT NULL ,
	[ActualCost]         money  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_TransactionHistoryArchive_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [TransactionHistArchive]
	 WITH CHECK ADD CONSTRAINT [CK_TransactionHistoryArchive_T] CHECK  ( [TransactionTyp]='P' OR [TransactionTyp]='S' OR [TransactionTyp]='W' )
go

CREATE TABLE [UnitMeasure]
( 
	[UnitMeasureCd]      nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_UnitMeasure_ModifiedDate]
		 DEFAULT  getdate()
)
go

CREATE TABLE [Vendor]
( 
	[BusinessEntityID]   int  NOT NULL ,
	[AccountNbr]         [AccountNbr]  NOT NULL ,
	[Nam]                [Nam]  NOT NULL ,
	[CrdRating]          tinyint  NOT NULL ,
	[PreferredVendorStat] [Flag]  NOT NULL 
	CONSTRAINT [DF_Vendor_PreferredVendorStatus]
		 DEFAULT  1,
	[ActiveFlag]         [Flag]  NOT NULL 
	CONSTRAINT [DF_Vendor_ActiveFlag]
		 DEFAULT  1,
	[PurchasingWebServiceURL] nvarchar(1024) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_Vendor_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [Vendor]
	 WITH CHECK ADD CONSTRAINT [CK_Vendor_CreditRating] CHECK  ( CrdRating BETWEEN 1 AND 5 )
go

CREATE TABLE [WorkOrdr]
( 
	[WorkOrdrID]         int  IDENTITY ( 1,1 )  NOT NULL ,
	[ProductID]          int  NOT NULL ,
	[OrdrQty]            int  NOT NULL ,
	[StockedQty]         AS (isnull([OrderQty]-[ScrappedQty],(0))) ,
	[ScrappedQty]        smallint  NOT NULL ,
	[StartDt]            datetime  NOT NULL ,
	[EndDt]              datetime  NULL ,
	[DueDt]              datetime  NOT NULL ,
	[ScrapReasonID]      smallint  NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_WorkOrder_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [WorkOrdr]
	 WITH CHECK ADD CONSTRAINT [CK_WorkOrder_OrderQty] CHECK  ( [OrderQty]>(0) )
go

ALTER TABLE [WorkOrdr]
	 WITH CHECK ADD CONSTRAINT [CK_WorkOrder_ScrappedQty] CHECK  ( ScrappedQty >= 0 )
go

CREATE TABLE [WorkOrdrRouting]
( 
	[WorkOrdrID]         int  NOT NULL ,
	[ProductID]          int  NOT NULL ,
	[OperationSeq]       smallint  NOT NULL ,
	[LocationID]         smallint  NOT NULL ,
	[ShedStartDt]        datetime  NOT NULL ,
	[ShedEndDt]          datetime  NOT NULL ,
	[ActualStartDt]      datetime  NULL ,
	[ActualEndDt]        datetime  NULL ,
	[ActualResourceHrs]  decimal(9,4)  NULL ,
	[PlannedCost]        money  NOT NULL ,
	[ActualCost]         money  NULL ,
	[ModifiedDt]         datetime  NOT NULL 
	CONSTRAINT [DF_WorkOrderRouting_ModifiedDate]
		 DEFAULT  getdate()
)
go

ALTER TABLE [WorkOrdrRouting]
	 WITH CHECK ADD CONSTRAINT [CK_WorkOrderRouting_ActualReso] CHECK  ( ActualResourceHrs >= 0.0000 )
go

ALTER TABLE [WorkOrdrRouting]
	 WITH CHECK ADD CONSTRAINT [CK_WorkOrderRouting_PlannedCos] CHECK  ( [PlannedCost]>(0.00) )
go

ALTER TABLE [WorkOrdrRouting]
	 WITH CHECK ADD CONSTRAINT [CK_WorkOrderRouting_ActualCost] CHECK  ( [ActualCost]>(0.00) )
go

ALTER TABLE [Addr]
	ADD CONSTRAINT [PK_Address_AddressID] PRIMARY KEY  CLUSTERED ([AddrID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Address_rowguid] ON [Addr]
( 
	[rowguid]             ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [IX_Address_AddressLine1_Addres] ON [Addr]
( 
	[AddrLine1]           ASC,
	[AddrLine2]           ASC,
	[Cty]                 ASC,
	[StProvinceID]        ASC,
	[PostalCd]            ASC
)
go

ALTER TABLE [AddrTyp]
	ADD CONSTRAINT [PK_AddressType_AddressTypeID] PRIMARY KEY  CLUSTERED ([AddrTypID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_AddressType_rowguid] ON [AddrTyp]
( 
	[rowguid]             ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_AddressType_Name] ON [AddrTyp]
( 
	[Nam]                 ASC
)
go

ALTER TABLE [AWBuildVersion]
	ADD CONSTRAINT [PK_AWBuildVersion_SystemInform] PRIMARY KEY  CLUSTERED ([SystemInfID] ASC)
go

ALTER TABLE [BillOfMaterials]
	ADD CONSTRAINT [PK_BillOfMaterials_BillOfMater] PRIMARY KEY  NONCLUSTERED ([BillOfMaterialsID] ASC)
go

CREATE UNIQUE CLUSTERED INDEX [AK_BillOfMaterials_ProductAsse] ON [BillOfMaterials]
( 
	[ProductAssemblyID]   ASC,
	[ComponentID]         ASC,
	[StartDt]             ASC
)
go

ALTER TABLE [BusinessEntity]
	ADD CONSTRAINT [PK_BusinessEntity_BusinessEnti] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_BusinessEntity_rowguid] ON [BusinessEntity]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [BusinessEntityAddr]
	ADD CONSTRAINT [PK_BusinessEntityAddress_Busin] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC,[AddrID] ASC,[AddrTypID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_BusinessEntityAddress_rowgu] ON [BusinessEntityAddr]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [BusinessEntityContact]
	ADD CONSTRAINT [PK_BusinessEntityContact_Busin] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC,[PersonID] ASC,[ContactTypID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_BusinessEntityContact_rowgu] ON [BusinessEntityContact]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [ContactTyp]
	ADD CONSTRAINT [PK_ContactType_ContactTypeID] PRIMARY KEY  CLUSTERED ([ContactTypID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_ContactType_Name] ON [ContactTyp]
( 
	[Nam]                 ASC
)
go

ALTER TABLE [CountryRgn]
	ADD CONSTRAINT [PK_CountryRegion_CountryRegion] PRIMARY KEY  CLUSTERED ([CountryRgnCd] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_CountryRegion_Name] ON [CountryRgn]
( 
	[Nam]                 ASC
)
go

ALTER TABLE [CountryRgnCurrency]
	ADD CONSTRAINT [PK_CountryRegionCurrency_Count] PRIMARY KEY  CLUSTERED ([CountryRgnCd] ASC,[CurrencyCd] ASC)
go

ALTER TABLE [CrdCard]
	ADD CONSTRAINT [PK_CreditCard_CreditCardID] PRIMARY KEY  CLUSTERED ([CrdCardID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_CreditCard_CardNumber] ON [CrdCard]
( 
	[CardNbr]             ASC
)
go

ALTER TABLE [Culture]
	ADD CONSTRAINT [PK_Culture_CultureID] PRIMARY KEY  CLUSTERED ([CultureID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Culture_Name] ON [Culture]
( 
	[Nam]                 ASC
)
go

ALTER TABLE [Currency]
	ADD CONSTRAINT [PK_Currency_CurrencyCode] PRIMARY KEY  CLUSTERED ([CurrencyCd] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Currency_Name] ON [Currency]
( 
	[Nam]                 ASC
)
go

ALTER TABLE [CurrencyRate]
	ADD CONSTRAINT [PK_CurrencyRate_CurrencyRateID] PRIMARY KEY  CLUSTERED ([CurrencyRateID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_CurrencyRate_CurrencyRateDa] ON [CurrencyRate]
( 
	[CurrencyRateDt]      ASC,
	[FromCurrencyCd]      ASC,
	[ToCurrencyCd]        ASC
)
go

ALTER TABLE [Cust]
	ADD CONSTRAINT [PK_Customer_CustomerID] PRIMARY KEY  CLUSTERED ([CustID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Customer_rowguid] ON [Cust]
( 
	[rowguid]             ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Customer_AccountNumber] ON [Cust]
( 
	[AccountNbr]          ASC
)
go

ALTER TABLE [DatabaseLog]
	ADD CONSTRAINT [PK_DatabaseLog_DatabaseLogID] PRIMARY KEY  NONCLUSTERED ([DatabaseLogID] ASC)
go

ALTER TABLE [Department]
	ADD CONSTRAINT [PK_Department_DepartmentID] PRIMARY KEY  CLUSTERED ([DepartmentID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Department_Name] ON [Department]
( 
	[Nam]                 ASC
)
go

ALTER TABLE [Document]
	ADD CONSTRAINT [PK_Document_DocumentNode] PRIMARY KEY  CLUSTERED ([DocumentNode] ASC)
go

ALTER TABLE [Document]
	ADD CONSTRAINT [UQ__Document__F73921F7C5112C2E] UNIQUE ([rowguid]  ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Document_DocumentLevel_Docu] ON [Document]
( 
	[DocumentLevel]       ASC,
	[DocumentNode]        ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Document_rowguid] ON [Document]
( 
	[rowguid]             ASC
)
go

CREATE NONCLUSTERED INDEX [IX_Document_FileName_Revision] ON [Document]
( 
	[FileNam]             ASC,
	[Revision]            ASC
)
go

ALTER TABLE [EmailAddr]
	ADD CONSTRAINT [PK_EmailAddress_BusinessEntity] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC,[EmailAddrID] ASC)
go

CREATE NONCLUSTERED INDEX [IX_EmailAddress_EmailAddress] ON [EmailAddr]
( 
	[EmailAddr]           ASC
)
go

ALTER TABLE [Emp]
	ADD CONSTRAINT [PK_Employee_BusinessEntityID] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Employee_LoginID] ON [Emp]
( 
	[LoginID]             ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Employee_NationalIDNumber] ON [Emp]
( 
	[NationalIDNbr]       ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Employee_rowguid] ON [Emp]
( 
	[rowguid]             ASC
)
go

CREATE NONCLUSTERED INDEX [IX_Employee_OrganizationNode] ON [Emp]
( 
	[OrganizationNode]    ASC
)
go

CREATE NONCLUSTERED INDEX [IX_Employee_OrganizationLevel_] ON [Emp]
( 
	[OrganizationLevel]   ASC,
	[OrganizationNode]    ASC
)
go

ALTER TABLE [EmpDepartmentHist]
	ADD CONSTRAINT [PK_EmployeeDepartmentHistory_B] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC,[StartDt] ASC,[DepartmentID] ASC,[ShiftID] ASC)
go

ALTER TABLE [EmpPayHist]
	ADD CONSTRAINT [PK_EmployeePayHistory_Business] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC,[RateChangeDt] ASC)
go

ALTER TABLE [ErrorLog]
	ADD CONSTRAINT [PK_ErrorLog_ErrorLogID] PRIMARY KEY  CLUSTERED ([ErrorLogID] ASC)
go

ALTER TABLE [Illustration]
	ADD CONSTRAINT [PK_Illustration_IllustrationID] PRIMARY KEY  CLUSTERED ([IllustrationID] ASC)
go

ALTER TABLE [JobCandiDt]
	ADD CONSTRAINT [PK_JobCandidate_JobCandidateID] PRIMARY KEY  CLUSTERED ([JobCandiDtID] ASC)
go

ALTER TABLE [Location]
	ADD CONSTRAINT [PK_Location_LocationID] PRIMARY KEY  CLUSTERED ([LocationID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Location_Name] ON [Location]
( 
	[Nam]                 ASC
)
go

ALTER TABLE [Password]
	ADD CONSTRAINT [PK_Password_BusinessEntityID] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC)
go

ALTER TABLE [Person]
	ADD CONSTRAINT [PK_Person_BusinessEntityID] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Person_rowguid] ON [Person]
( 
	[rowguid]             ASC
)
go

CREATE NONCLUSTERED INDEX [IX_Person_LastName_FirstName_M] ON [Person]
( 
	[LstNam]              ASC,
	[FrstNam]             ASC,
	[MiddleNam]           ASC
)
go

ALTER TABLE [PersonCrdCard]
	ADD CONSTRAINT [PK_PersonCreditCard_BusinessEn] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC,[CrdCardID] ASC)
go

ALTER TABLE [PersonPhn]
	ADD CONSTRAINT [PK_PersonPhone_BusinessEntityI] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC,[PhnNbr] ASC,[PhnNbrTypID] ASC)
go

CREATE NONCLUSTERED INDEX [IX_PersonPhone_PhoneNumber] ON [PersonPhn]
( 
	[PhnNbr]              ASC
)
go

ALTER TABLE [PhnNbrTyp]
	ADD CONSTRAINT [PK_PhoneNumberType_PhoneNumber] PRIMARY KEY  CLUSTERED ([PhnNbrTypID] ASC)
go

ALTER TABLE [Product]
	ADD CONSTRAINT [PK_Product_ProductID] PRIMARY KEY  CLUSTERED ([ProductID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Product_ProductNumber] ON [Product]
( 
	[ProductNbr]          ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Product_Name] ON [Product]
( 
	[Nam]                 ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Product_rowguid] ON [Product]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [ProductCategory]
	ADD CONSTRAINT [PK_ProductCategory_ProductCate] PRIMARY KEY  CLUSTERED ([ProductCategoryID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_ProductCategory_Name] ON [ProductCategory]
( 
	[Nam]                 ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_ProductCategory_rowguid] ON [ProductCategory]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [ProductCostHist]
	ADD CONSTRAINT [PK_ProductCostHistory_ProductI] PRIMARY KEY  CLUSTERED ([ProductID] ASC,[StartDt] ASC)
go

ALTER TABLE [ProductDesc]
	ADD CONSTRAINT [PK_ProductDescription_ProductD] PRIMARY KEY  CLUSTERED ([ProductDescID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_ProductDescription_rowguid] ON [ProductDesc]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [ProductDocument]
	ADD CONSTRAINT [PK_ProductDocument_ProductID_D] PRIMARY KEY  CLUSTERED ([ProductID] ASC,[DocumentNode] ASC)
go

ALTER TABLE [ProductInventory]
	ADD CONSTRAINT [PK_ProductInventory_ProductID_] PRIMARY KEY  CLUSTERED ([ProductID] ASC,[LocationID] ASC)
go

ALTER TABLE [ProductListPriceHist]
	ADD CONSTRAINT [PK_ProductListPriceHistory_Pro] PRIMARY KEY  CLUSTERED ([ProductID] ASC,[StartDt] ASC)
go

ALTER TABLE [ProductModel]
	ADD CONSTRAINT [PK_ProductModel_ProductModelID] PRIMARY KEY  CLUSTERED ([ProductModelID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_ProductModel_Name] ON [ProductModel]
( 
	[Nam]                 ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_ProductModel_rowguid] ON [ProductModel]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [ProductModelIllustration]
	ADD CONSTRAINT [PK_ProductModelIllustration_Pr] PRIMARY KEY  CLUSTERED ([ProductModelID] ASC,[IllustrationID] ASC)
go

ALTER TABLE [ProductModelProductDescCulture]
	ADD CONSTRAINT [PK_ProductModelProductDescript] PRIMARY KEY  CLUSTERED ([ProductModelID] ASC,[ProductDescID] ASC,[CultureID] ASC)
go

ALTER TABLE [ProductPhoto]
	ADD CONSTRAINT [PK_ProductPhoto_ProductPhotoID] PRIMARY KEY  CLUSTERED ([ProductPhotoID] ASC)
go

ALTER TABLE [ProductProductPhoto]
	ADD CONSTRAINT [PK_ProductProductPhoto_Product] PRIMARY KEY  NONCLUSTERED ([ProductID] ASC,[ProductPhotoID] ASC)
go

ALTER TABLE [ProductReview]
	ADD CONSTRAINT [PK_ProductReview_ProductReview] PRIMARY KEY  CLUSTERED ([ProductReviewID] ASC)
go

CREATE NONCLUSTERED INDEX [IX_ProductReview_ProductID_Nam] ON [ProductReview]
( 
	[ProductID]           ASC,
	[ReviewerNam]         ASC
)
INCLUDE( [Comments] )
go

ALTER TABLE [ProductSubcategory]
	ADD CONSTRAINT [PK_ProductSubcategory_ProductS] PRIMARY KEY  CLUSTERED ([ProductSubcategoryID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_ProductSubcategory_Name] ON [ProductSubcategory]
( 
	[Nam]                 ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_ProductSubcategory_rowguid] ON [ProductSubcategory]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [ProductVendor]
	ADD CONSTRAINT [PK_ProductVendor_ProductID_Bus] PRIMARY KEY  CLUSTERED ([ProductID] ASC,[BusinessEntityID] ASC)
go

ALTER TABLE [PurchaseOrdrDetail]
	ADD CONSTRAINT [PK_PurchaseOrderDetail_Purchas] PRIMARY KEY  CLUSTERED ([PurchaseOrdrID] ASC,[PurchaseOrdrDetailID] ASC)
go

ALTER TABLE [PurchaseOrdrHeader]
	ADD CONSTRAINT [PK_PurchaseOrderHeader_Purchas] PRIMARY KEY  CLUSTERED ([PurchaseOrdrID] ASC)
go

ALTER TABLE [ScrapReason]
	ADD CONSTRAINT [PK_ScrapReason_ScrapReasonID] PRIMARY KEY  CLUSTERED ([ScrapReasonID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_ScrapReason_Name] ON [ScrapReason]
( 
	[Nam]                 ASC
)
go

ALTER TABLE [Shift]
	ADD CONSTRAINT [PK_Shift_ShiftID] PRIMARY KEY  CLUSTERED ([ShiftID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Shift_Name] ON [Shift]
( 
	[Nam]                 ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Shift_StartTime_EndTime] ON [Shift]
( 
	[StartTime]           ASC,
	[EndTime]             ASC
)
go

ALTER TABLE [ShipMethod]
	ADD CONSTRAINT [PK_ShipMethod_ShipMethodID] PRIMARY KEY  CLUSTERED ([ShipMethodID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_ShipMethod_Name] ON [ShipMethod]
( 
	[Nam]                 ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_ShipMethod_rowguid] ON [ShipMethod]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [ShoppingCartitm]
	ADD CONSTRAINT [PK_ShoppingCartItem_ShoppingCa] PRIMARY KEY  CLUSTERED ([ShoppingCartitmID] ASC)
go

CREATE NONCLUSTERED INDEX [IX_ShoppingCartItem_ShoppingCa] ON [ShoppingCartitm]
( 
	[ShoppingCartID]      ASC,
	[ProductID]           ASC
)
go

ALTER TABLE [SlsOrdrDetail]
	ADD CONSTRAINT [PK_SalesOrderDetail_SalesOrder] PRIMARY KEY  CLUSTERED ([SlsOrdrID] ASC,[SlsOrdrDetailID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesOrderDetail_rowguid] ON [SlsOrdrDetail]
( 
	[rowguid]             ASC
)
go

CREATE NONCLUSTERED INDEX [IX_SalesOrderDetail_ProductID] ON [SlsOrdrDetail]
( 
	[ProductID]           ASC
)
go

ALTER TABLE [SlsOrdrHeader]
	ADD CONSTRAINT [PK_SalesOrderHeader_SalesOrder] PRIMARY KEY  CLUSTERED ([SlsOrdrID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesOrderHeader_rowguid] ON [SlsOrdrHeader]
( 
	[rowguid]             ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesOrderHeader_SalesOrder] ON [SlsOrdrHeader]
( 
	[SlsOrdrNbr]          ASC
)
go

ALTER TABLE [SlsOrdrHeaderSlsReason]
	ADD CONSTRAINT [PK_SalesOrderHeaderSalesReason] PRIMARY KEY  CLUSTERED ([SlsOrdrID] ASC,[SlsReasonID] ASC)
go

ALTER TABLE [SlsPerson]
	ADD CONSTRAINT [PK_SalesPerson_BusinessEntityI] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesPerson_rowguid] ON [SlsPerson]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [SlsPersonQuotaHist]
	ADD CONSTRAINT [PK_SalesPersonQuotaHistory_Bus] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC,[QuotaDt] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesPersonQuotaHistory_row] ON [SlsPersonQuotaHist]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [SlsReason]
	ADD CONSTRAINT [PK_SalesReason_SalesReasonID] PRIMARY KEY  CLUSTERED ([SlsReasonID] ASC)
go

ALTER TABLE [SlsTaxRate]
	ADD CONSTRAINT [PK_SalesTaxRate_SalesTaxRateID] PRIMARY KEY  CLUSTERED ([SlsTaxRateID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesTaxRate_StateProvinceI] ON [SlsTaxRate]
( 
	[StProvinceID]        ASC,
	[TaxTyp]              ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesTaxRate_rowguid] ON [SlsTaxRate]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [SlsTerritory]
	ADD CONSTRAINT [PK_SalesTerritory_TerritoryID] PRIMARY KEY  CLUSTERED ([TerritoryID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesTerritory_Name] ON [SlsTerritory]
( 
	[Nam]                 ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesTerritory_rowguid] ON [SlsTerritory]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [SlsTerritoryHist]
	ADD CONSTRAINT [PK_SalesTerritoryHistory_Busin] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC,[StartDt] ASC,[TerritoryID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesTerritoryHistory_rowgu] ON [SlsTerritoryHist]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [SpecialOffer]
	ADD CONSTRAINT [PK_SpecialOffer_SpecialOfferID] PRIMARY KEY  CLUSTERED ([SpecialOfferID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_SpecialOffer_rowguid] ON [SpecialOffer]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [SpecialOfferProduct]
	ADD CONSTRAINT [PK_SpecialOfferProduct_Special] PRIMARY KEY  CLUSTERED ([SpecialOfferID] ASC,[ProductID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_SpecialOfferProduct_rowguid] ON [SpecialOfferProduct]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [Stor]
	ADD CONSTRAINT [PK_Store_BusinessEntityID] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Store_rowguid] ON [Stor]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [StProvince]
	ADD CONSTRAINT [PK_StateProvince_StateProvince] PRIMARY KEY  CLUSTERED ([StProvinceID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_StateProvince_Name] ON [StProvince]
( 
	[Nam]                 ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_StateProvince_StateProvince] ON [StProvince]
( 
	[StProvinceCd]        ASC,
	[CountryRgnCd]        ASC
)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_StateProvince_rowguid] ON [StProvince]
( 
	[rowguid]             ASC
)
go

ALTER TABLE [TransactionHist]
	ADD CONSTRAINT [PK_TransactionHistory_Transact] PRIMARY KEY  CLUSTERED ([TransactionID] ASC)
go

CREATE NONCLUSTERED INDEX [IX_TransactionHistory_Referenc] ON [TransactionHist]
( 
	[ReferenceOrdrID]     ASC,
	[ReferenceOrdrLineID]  ASC
)
go

ALTER TABLE [TransactionHistArchive]
	ADD CONSTRAINT [PK_TransactionHistoryArchive_T] PRIMARY KEY  CLUSTERED ([TransactionID] ASC)
go

CREATE NONCLUSTERED INDEX [IX_TransactionHistoryArchive_P] ON [TransactionHistArchive]
( 
	[ProductID]           ASC
)
go

CREATE NONCLUSTERED INDEX [IX_TransactionHistoryArchive_R] ON [TransactionHistArchive]
( 
	[ReferenceOrdrID]     ASC,
	[ReferenceOrdrLineID]  ASC
)
go

ALTER TABLE [UnitMeasure]
	ADD CONSTRAINT [PK_UnitMeasure_UnitMeasureCode] PRIMARY KEY  CLUSTERED ([UnitMeasureCd] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_UnitMeasure_Name] ON [UnitMeasure]
( 
	[Nam]                 ASC
)
go

ALTER TABLE [Vendor]
	ADD CONSTRAINT [PK_Vendor_BusinessEntityID] PRIMARY KEY  CLUSTERED ([BusinessEntityID] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [AK_Vendor_AccountNumber] ON [Vendor]
( 
	[AccountNbr]          ASC
)
go

ALTER TABLE [WorkOrdr]
	ADD CONSTRAINT [PK_WorkOrder_WorkOrderID] PRIMARY KEY  CLUSTERED ([WorkOrdrID] ASC)
go

ALTER TABLE [WorkOrdrRouting]
	ADD CONSTRAINT [PK_WorkOrderRouting_WorkOrderI] PRIMARY KEY  CLUSTERED ([WorkOrdrID] ASC,[ProductID] ASC,[OperationSeq] ASC)
go

CREATE NONCLUSTERED INDEX [IX_WorkOrderRouting_ProductID] ON [WorkOrdrRouting]
( 
	[ProductID]           ASC
)
go

CREATE VIEW [Person].[vAdditionalContactInfo] AS  SELECT [BusinessEntityID], [FirstName], [MiddleName], [LastName],  [ContactInfo].ref.value( N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:telephoneNumber)[1]/act:number' , 'nvarchar(50)' )  AS [TelephoneNumber],  ltrim( rtrim( [ContactInfo].ref.value( N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:telephoneNumber/act:SpecialInstructions/text())[1]' , 'nvarchar(max)' ) ) )  AS [TelephoneSpecialInstructions],  [ContactInfo].ref.value( N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes";
        (act:homePostalAddress/act:Street)[1]' , 'nvarchar(50)' )  AS [Street],  [ContactInfo].ref.value( N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:City)[1]' , 'nvarchar(50)' )  AS [City],  [ContactInfo].ref.value( N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:StateProvince)[1]' , 'nvarchar(50)' )  AS [StateProvince],  [ContactInfo].ref.value( N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:PostalCode)[1]' , 'nvarchar(50)' )  AS [PostalCode],  [ContactInfo].ref.value( N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:CountryRegion)[1]' , 'nvarchar(50)' )  AS [CountryRegion],  [ContactInfo].ref.value( N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:SpecialInstructions/text())[1]' , 'nvarchar(max)' )  AS [HomeAddressSpecialInstructions],  [ContactInfo].ref.value( N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:eMail/act:eMailAddress)[1]' , 'nvarchar(128)' )  AS [EMailAddress],  ltrim( rtrim( [ContactInfo].ref.value( N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:eMail/act:SpecialInstructions/text())[1]' , 'nvarchar(max)' ) ) )  AS [EMailSpecialInstructions],  [ContactInfo].ref.value( N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:eMail/act:SpecialInstructions/act:telephoneNumber/act:number)[1]' , 'nvarchar(50)' )  AS [EMailTelephoneNumber], [rowguid], [ModifiedDate] FROM Person.Person   OUTER APPLY   AdditionalContactInfo.nodes( 'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
    /ci:AdditionalContactInfo' ) AS ContactInfo (ref) WHERE [AdditionalContactInfo] IS NOT NULL
go

CREATE VIEW [HumanResources].[vEmployee] AS  SELECT e.[BusinessEntityID], p.[Title], p.[FirstName], p.[MiddleName], p.[LastName], p.[Suffix], e.[JobTitle], pp.[PhoneNumber], pnt.[Name] AS [PhoneNumberType], ea.[EmailAddress], p.[EmailPromotion], a.[AddressLine1], a.[AddressLine2], a.[City], sp.[Name] AS [StateProvinceName], a.[PostalCode], cr.[Name] AS [CountryRegionName], p.[AdditionalContactInfo] FROM HumanResources.Employee AS e   INNER JOIN   Person.Person AS p ON p.[BusinessEntityID] = e.[BusinessEntityID]   INNER JOIN   Person.BusinessEntityAddress AS bea ON bea.[BusinessEntityID] = e.[BusinessEntityID]   INNER JOIN   Person.Address AS a ON a.[AddressID] = bea.[AddressID]   INNER JOIN   Person.StateProvince AS sp ON sp.[StateProvinceID] = a.[StateProvinceID]   INNER JOIN   Person.CountryRegion AS cr ON cr.[CountryRegionCode] = sp.[CountryRegionCode]   LEFT OUTER JOIN   Person.PersonPhone AS pp ON pp.BusinessEntityID = p.[BusinessEntityID]   LEFT OUTER JOIN   Person.PhoneNumberType AS pnt ON pp.[PhoneNumberTypeID] = pnt.[PhoneNumberTypeID]   LEFT OUTER JOIN   Person.EmailAddress AS ea ON p.[BusinessEntityID] = ea.[BusinessEntityID]
go

CREATE VIEW [HumanResources].[vEmployeeDepartment] AS  SELECT e.[BusinessEntityID], p.[Title], p.[FirstName], p.[MiddleName], p.[LastName], p.[Suffix], e.[JobTitle], d.[Name] AS [Department], d.[GroupName], edh.[StartDate] FROM HumanResources.Employee AS e   INNER JOIN   Person.Person AS p ON p.[BusinessEntityID] = e.[BusinessEntityID]   INNER JOIN   HumanResources.EmployeeDepartmentHistory AS edh ON e.[BusinessEntityID] = edh.[BusinessEntityID]   INNER JOIN   HumanResources.Department AS d ON edh.[DepartmentID] = d.[DepartmentID] WHERE edh.EndDate IS NULL
go

CREATE VIEW [HumanResources].[vEmployeeDepartmentHistory] AS  SELECT e.[BusinessEntityID], p.[Title], p.[FirstName], p.[MiddleName], p.[LastName], p.[Suffix], s.[Name] AS [Shift], d.[Name] AS [Department], d.[GroupName], edh.[StartDate], edh.[EndDate] FROM HumanResources.Employee AS e   INNER JOIN   Person.Person AS p ON p.[BusinessEntityID] = e.[BusinessEntityID]   INNER JOIN   HumanResources.EmployeeDepartmentHistory AS edh ON e.[BusinessEntityID] = edh.[BusinessEntityID]   INNER JOIN   HumanResources.Department AS d ON edh.[DepartmentID] = d.[DepartmentID]   INNER JOIN   HumanResources.Shift AS s ON s.[ShiftID] = edh.[ShiftID]
go

CREATE VIEW [Sales].[vIndividualCustomer] AS  SELECT p.[BusinessEntityID], p.[Title], p.[FirstName], p.[MiddleName], p.[LastName], p.[Suffix], pp.[PhoneNumber], pnt.[Name] AS [PhoneNumberType], ea.[EmailAddress], p.[EmailPromotion], at.[Name] AS [AddressType], a.[AddressLine1], a.[AddressLine2], a.[City], sp.Name AS StateProvinceName, a.[PostalCode], cr.Name AS CountryRegionName, p.[Demographics] FROM Person.Person AS p   INNER JOIN   Person.BusinessEntityAddress AS bea ON bea.[BusinessEntityID] = p.[BusinessEntityID]   INNER JOIN   Person.Address AS a ON a.[AddressID] = bea.[AddressID]   INNER JOIN   Person.StateProvince AS sp ON sp.[StateProvinceID] = a.[StateProvinceID]   INNER JOIN   Person.CountryRegion AS cr ON cr.[CountryRegionCode] = sp.[CountryRegionCode]   INNER JOIN   Person.AddressType AS at ON at.[AddressTypeID] = bea.[AddressTypeID]   INNER JOIN   Sales.Customer AS c ON c.[PersonID] = p.[BusinessEntityID]   LEFT OUTER JOIN   Person.EmailAddress AS ea ON ea.[BusinessEntityID] = p.[BusinessEntityID]   LEFT OUTER JOIN   Person.PersonPhone AS pp ON pp.[BusinessEntityID] = p.[BusinessEntityID]   LEFT OUTER JOIN   Person.PhoneNumberType AS pnt ON pnt.[PhoneNumberTypeID] = pp.[PhoneNumberTypeID] WHERE c.StoreID IS NULL
go

CREATE VIEW [Sales].[vPersonDemographics] AS  SELECT p.[BusinessEntityID],  [IndividualSurvey].[ref].[value]( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        TotalPurchaseYTD[1]' , 'money' )  AS [TotalPurchaseYTD],  CONVERT(datetime,  REPLACE(  [IndividualSurvey].[ref].[value]( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        DateFirstPurchase[1]' , 'nvarchar(20)' )  , 'Z' , '' ) , 101) AS [DateFirstPurchase],  CONVERT(datetime,  REPLACE(  [IndividualSurvey].[ref].[value]( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        BirthDate[1]' , 'nvarchar(20)' )  , 'Z' , '' ) , 101) AS [BirthDate],  [IndividualSurvey].[ref].[value]( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        MaritalStatus[1]' , 'nvarchar(1)' )  AS [MaritalStatus],  [IndividualSurvey].[ref].[value]( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        YearlyIncome[1]' , 'nvarchar(30)' )  AS [YearlyIncome],  [IndividualSurvey].[ref].[value]( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Gender[1]' , 'nvarchar(1)' )  AS [Gender],  [IndividualSurvey].[ref].[value]( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        TotalChildren[1]' , 'integer' )  AS [TotalChildren],  [IndividualSurvey].[ref].[value]( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        NumberChildrenAtHome[1]' , 'integer' )  AS [NumberChildrenAtHome],  [IndividualSurvey].[ref].[value]( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Education[1]' , 'nvarchar(30)' )  AS [Education],  [IndividualSurvey].[ref].[value]( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Occupation[1]' , 'nvarchar(30)' )  AS [Occupation],  [IndividualSurvey].[ref].[value]( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        HomeOwnerFlag[1]' , 'bit' )  AS [HomeOwnerFlag],  [IndividualSurvey].[ref].[value]( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        NumberCarsOwned[1]' , 'integer' )  AS [NumberCarsOwned] FROM Person.Person AS p   CROSS APPLY   p.Demographics.nodes( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
    /IndividualSurvey' ) AS [IndividualSurvey] (ref) WHERE [Demographics] IS NOT NULL
go

CREATE VIEW [HumanResources].[vJobCandidate] AS  SELECT jc.[JobCandidateID], jc.[BusinessEntityID],  [Resume].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Name/Name.Prefix)[1]' , 'nvarchar(30)' )  AS [Name.Prefix],  [Resume].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume";
        (/Resume/Name/Name.First)[1]' , 'nvarchar(30)' )  AS [Name.First],  [Resume].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Name/Name.Middle)[1]' , 'nvarchar(30)' )  AS [Name.Middle],  [Resume].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Name/Name.Last)[1]' , 'nvarchar(30)' )  AS [Name.Last],  [Resume].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Name/Name.Suffix)[1]' , 'nvarchar(30)' )  AS [Name.Suffix],  [Resume].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Skills)[1]' , 'nvarchar(max)' )  AS [Skills],  [Resume].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.Type)[1]' , 'nvarchar(30)' )  AS [Addr.Type],  [Resume].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.Location/Location/Loc.CountryRegion)[1]' , 'nvarchar(100)' )  AS [Addr.Loc.CountryRegion],  [Resume].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.Location/Location/Loc.State)[1]' , 'nvarchar(100)' )  AS [Addr.Loc.State],  [Resume].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.Location/Location/Loc.City)[1]' , 'nvarchar(100)' )  AS [Addr.Loc.City],  [Resume].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.PostalCode)[1]' , 'nvarchar(20)' )  AS [Addr.PostalCode],  [Resume].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/EMail)[1]' , 'nvarchar(max)' )  AS [EMail],  [Resume].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/WebSite)[1]' , 'nvarchar(max)' )  AS [WebSite], jc.[ModifiedDate] FROM HumanResources.JobCandidate AS jc   CROSS APPLY   jc.Resume.nodes( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
    /Resume' ) AS Resume (ref)
go

CREATE VIEW [HumanResources].[vJobCandidateEmployment] AS  SELECT jc.[JobCandidateID],  CONVERT(datetime,  REPLACE(  [Employment].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.StartDate)[1]' , 'nvarchar(20)' )  , 'Z' , '' ) , 101) AS [Emp.StartDate],  CONVERT(datetime,  REPLACE(  [Employment].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.EndDate)[1]' , 'nvarchar(20)' )  , 'Z' , '' ) , 101) AS [Emp.EndDate],  [Employment].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.OrgName)[1]' , 'nvarchar(100)' )  AS [Emp.OrgName],  [Employment].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.JobTitle)[1]' , 'nvarchar(100)' )  AS [Emp.JobTitle],  [Employment].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Responsibility)[1]' , 'nvarchar(max)' )  AS [Emp.Responsibility],  [Employment].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.FunctionCategory)[1]' , 'nvarchar(max)' )  AS [Emp.FunctionCategory],  [Employment].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.IndustryCategory)[1]' , 'nvarchar(max)' )  AS [Emp.IndustryCategory],  [Employment].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Location/Location/Loc.CountryRegion)[1]' , 'nvarchar(max)' )  AS [Emp.Loc.CountryRegion],  [Employment].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Location/Location/Loc.State)[1]' , 'nvarchar(max)' )  AS [Emp.Loc.State],  [Employment].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Location/Location/Loc.City)[1]' , 'nvarchar(max)' )  AS [Emp.Loc.City] FROM HumanResources.JobCandidate AS jc   CROSS APPLY   jc.Resume.nodes( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
    /Resume/Employment' ) AS Employment (ref)
go

CREATE VIEW [HumanResources].[vJobCandidateEducation] AS  SELECT jc.[JobCandidateID],  [Education].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Level)[1]' , 'nvarchar(max)' )  AS [Edu.Level],  CONVERT(datetime,  REPLACE(  [Education].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.StartDate)[1]' , 'nvarchar(20)' )  , 'Z' , '' ) , 101) AS [Edu.StartDate],  CONVERT(datetime,  REPLACE(  [Education].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.EndDate)[1]' , 'nvarchar(20)' )  , 'Z' , '' ) , 101) AS [Edu.EndDate],  [Education].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Degree)[1]' , 'nvarchar(50)' )  AS [Edu.Degree],  [Education].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Major)[1]' , 'nvarchar(50)' )  AS [Edu.Major],  [Education].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Minor)[1]' , 'nvarchar(50)' )  AS [Edu.Minor],  [Education].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.GPA)[1]' , 'nvarchar(5)' )  AS [Edu.GPA],  [Education].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.GPAScale)[1]' , 'nvarchar(5)' )  AS [Edu.GPAScale],  [Education].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.School)[1]' , 'nvarchar(100)' )  AS [Edu.School],  [Education].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Location/Location/Loc.CountryRegion)[1]' , 'nvarchar(100)' )  AS [Edu.Loc.CountryRegion],  [Education].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Location/Location/Loc.State)[1]' , 'nvarchar(100)' )  AS [Edu.Loc.State],  [Education].ref.value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Location/Location/Loc.City)[1]' , 'nvarchar(100)' )  AS [Edu.Loc.City] FROM HumanResources.JobCandidate AS jc   CROSS APPLY   jc.Resume.nodes( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
    /Resume/Education' ) AS [Education] (ref)
go

CREATE VIEW [Production].[vProductAndDescription] WITH SCHEMABINDING  AS  SELECT p.[ProductID], p.[Name], pm.[Name] AS [ProductModel], pmx.[CultureID], pd.[Description] FROM Production.Product AS p   INNER JOIN   Production.ProductModel AS pm ON p.[ProductModelID] = pm.[ProductModelID]   INNER JOIN   Production.ProductModelProductDescriptionCulture AS pmx ON pm.[ProductModelID] = pmx.[ProductModelID]   INNER JOIN   Production.ProductDescription AS pd ON pmx.[ProductDescriptionID] = pd.[ProductDescriptionID]
go

CREATE VIEW [vProductModelCatalogDescriptio]([ProductModelID],[Name],[Summary],[Manufacturer],[Copyright],[ProductURL],[WarrantyPeriod],[WarrantyDescription],[NoOfYears],[MaintenanceDescription],[Wheel],[Saddle],[Pedal],[BikeFrame],[Crankset],[PictureAngle],[PictureSize],[ProductPhotoID],[Material],[Color],[ProductLine],[Style],[RiderExperience],[rowguid],[ModifiedDate])
AS
SELECT [ProductModel].[ProductModelID],[ProductModel].[Nam], [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace html="http://www.w3.org/1999/xhtml"; 
        (/p1:ProductDescription/p1:Summary/html:p)[1]' , 'nvarchar(max)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Manufacturer/p1:Name)[1]' , 'nvarchar(max)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Manufacturer/p1:Copyright)[1]' , 'nvarchar(30)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Manufacturer/p1:ProductURL)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Warranty/wm:WarrantyPeriod)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Warranty/wm:Description)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Maintenance/wm:NoOfYears)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Maintenance/wm:Description)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:wheel)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:saddle)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:pedal)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:BikeFrame)[1]' , 'nvarchar(max)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:crankset)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Picture/p1:Angle)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Picture/p1:Size)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Picture/p1:ProductPhotoID)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/Material)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/Color)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/ProductLine)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/Style)[1]' , 'nvarchar(256)' ) , [CatalogDescription].value( N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/RiderExperience)[1]' , 'nvarchar(1024)' ) ,[ProductModel].[rowguid],[ProductModel].[ModifiedDt]
	FROM [ProductModel]
		WHERE [CatalogDescription] IS NOT NULL
go

CREATE VIEW [Production].[vProductModelInstructions] AS  SELECT [ProductModelID], [Name],  [Instructions].value( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"; 
        (/root/text())[1]' , 'nvarchar(max)' )  AS [Instructions],  [MfgInstructions].ref.value( '@LocationID [1]' , 'int' )  AS [LocationID],  [MfgInstructions].ref.value( '@SetupHours [1]' , 'decimal(9, 4)' )  AS [SetupHours],  [MfgInstructions].ref.value( '@MachineHours [1]' , 'decimal(9, 4)' )  AS [MachineHours],  [MfgInstructions].ref.value( '@LaborHours [1]' , 'decimal(9, 4)' )  AS [LaborHours],  [MfgInstructions].ref.value( '@LotSize [1]' , 'int' )  AS [LotSize],  [Steps].ref.value( 'string(.)[1]' , 'nvarchar(1024)' )  AS [Step], [rowguid], [ModifiedDate] FROM Production.ProductModel   CROSS APPLY   Instructions.nodes( N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"; 
    /root/Location' ) AS MfgInstructions (ref)   CROSS APPLY   MfgInstructions.ref.nodes( 'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"; 
    step' ) AS Steps (ref)
go

CREATE VIEW [Sales].[vSalesPerson] AS  SELECT s.[BusinessEntityID], p.[Title], p.[FirstName], p.[MiddleName], p.[LastName], p.[Suffix], e.[JobTitle], pp.[PhoneNumber], pnt.[Name] AS [PhoneNumberType], ea.[EmailAddress], p.[EmailPromotion], a.[AddressLine1], a.[AddressLine2], a.[City], sp.Name AS StateProvinceName, a.[PostalCode], cr.Name AS CountryRegionName, st.Name AS TerritoryName, st.Group AS TerritoryGroup, s.[SalesQuota], s.[SalesYTD], s.[SalesLastYear] FROM Sales.SalesPerson AS s   INNER JOIN   HumanResources.Employee AS e ON e.[BusinessEntityID] = s.[BusinessEntityID]   INNER JOIN   Person.Person AS p ON p.[BusinessEntityID] = s.[BusinessEntityID]   INNER JOIN   Person.BusinessEntityAddress AS bea ON bea.[BusinessEntityID] = s.[BusinessEntityID]   INNER JOIN   Person.Address AS a ON a.[AddressID] = bea.[AddressID]   INNER JOIN   Person.StateProvince AS sp ON sp.[StateProvinceID] = a.[StateProvinceID]   INNER JOIN   Person.CountryRegion AS cr ON cr.[CountryRegionCode] = sp.[CountryRegionCode]   LEFT OUTER JOIN   Sales.SalesTerritory AS st ON st.[TerritoryID] = s.[TerritoryID]   LEFT OUTER JOIN   Person.EmailAddress AS ea ON ea.[BusinessEntityID] = p.[BusinessEntityID]   LEFT OUTER JOIN   Person.PersonPhone AS pp ON pp.[BusinessEntityID] = p.[BusinessEntityID]   LEFT OUTER JOIN   Person.PhoneNumberType AS pnt ON pnt.[PhoneNumberTypeID] = pp.[PhoneNumberTypeID]
go

CREATE VIEW [Person].[vStateProvinceCountryRegion] WITH SCHEMABINDING  AS  SELECT sp.[StateProvinceID], sp.[StateProvinceCode], sp.[IsOnlyStateProvinceFlag], sp.[Name] AS [StateProvinceName], sp.[TerritoryID], cr.[CountryRegionCode], cr.[Name] AS [CountryRegionName] FROM Person.StateProvince AS sp   INNER JOIN   Person.CountryRegion AS cr ON sp.[CountryRegionCode] = cr.[CountryRegionCode]
go

CREATE VIEW [vStoreWithDemographics]([BusinessEntityID],[Name],[AnnualSales],[AnnualRevenue],[BankName],[BusinessType],[YearOpened],[Specialty],[SquareFeet],[Brands],[Internet],[NumberEmployees])
AS
SELECT s.[BusinessEntityID],s.[Nam], s.[Demographics].value( 'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/AnnualSales)[1]' , 'money' ) , s.[Demographics].value( 'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/AnnualRevenue)[1]' , 'money' ) , s.[Demographics].value( 'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/BankName)[1]' , 'nvarchar(50)' ) , s.[Demographics].value( 'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/BusinessType)[1]' , 'nvarchar(5)' ) , s.[Demographics].value( 'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/YearOpened)[1]' , 'integer' ) , s.[Demographics].value( 'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Specialty)[1]' , 'nvarchar(50)' ) , s.[Demographics].value( 'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/SquareFeet)[1]' , 'integer' ) , s.[Demographics].value( 'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Brands)[1]' , 'nvarchar(30)' ) , s.[Demographics].value( 'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Internet)[1]' , 'nvarchar(30)' ) , s.[Demographics].value( 'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/NumberEmployees)[1]' , 'integer' ) 
	FROM [Stor] s
go

CREATE VIEW [Sales].[vStoreWithContacts] AS  SELECT s.[BusinessEntityID], s.[Name], ct.[Name] AS [ContactType], p.[Title], p.[FirstName], p.[MiddleName], p.[LastName], p.[Suffix], pp.[PhoneNumber], pnt.[Name] AS [PhoneNumberType], ea.[EmailAddress], p.[EmailPromotion] FROM Sales.Store AS s   INNER JOIN   Person.BusinessEntityContact AS bec ON bec.[BusinessEntityID] = s.[BusinessEntityID]   INNER JOIN   Person.ContactType AS ct ON ct.[ContactTypeID] = bec.[ContactTypeID]   INNER JOIN   Person.Person AS p ON p.[BusinessEntityID] = bec.[PersonID]   LEFT OUTER JOIN   Person.EmailAddress AS ea ON ea.[BusinessEntityID] = p.[BusinessEntityID]   LEFT OUTER JOIN   Person.PersonPhone AS pp ON pp.[BusinessEntityID] = p.[BusinessEntityID]   LEFT OUTER JOIN   Person.PhoneNumberType AS pnt ON pnt.[PhoneNumberTypeID] = pp.[PhoneNumberTypeID]
go

CREATE VIEW [Sales].[vStoreWithAddresses] AS  SELECT s.[BusinessEntityID], s.[Name], at.[Name] AS [AddressType], a.[AddressLine1], a.[AddressLine2], a.[City], sp.[Name] AS [StateProvinceName], a.[PostalCode], cr.[Name] AS [CountryRegionName] FROM Sales.Store AS s   INNER JOIN   Person.BusinessEntityAddress AS bea ON bea.[BusinessEntityID] = s.[BusinessEntityID]   INNER JOIN   Person.Address AS a ON a.[AddressID] = bea.[AddressID]   INNER JOIN   Person.StateProvince AS sp ON sp.[StateProvinceID] = a.[StateProvinceID]   INNER JOIN   Person.CountryRegion AS cr ON cr.[CountryRegionCode] = sp.[CountryRegionCode]   INNER JOIN   Person.AddressType AS at ON at.[AddressTypeID] = bea.[AddressTypeID]
go

CREATE VIEW [Purchasing].[vVendorWithContacts] AS  SELECT v.[BusinessEntityID], v.[Name], ct.[Name] AS [ContactType], p.[Title], p.[FirstName], p.[MiddleName], p.[LastName], p.[Suffix], pp.[PhoneNumber], pnt.[Name] AS [PhoneNumberType], ea.[EmailAddress], p.[EmailPromotion] FROM Purchasing.Vendor AS v   INNER JOIN   Person.BusinessEntityContact AS bec ON bec.[BusinessEntityID] = v.[BusinessEntityID]   INNER JOIN   Person.ContactType AS ct ON ct.[ContactTypeID] = bec.[ContactTypeID]   INNER JOIN   Person.Person AS p ON p.[BusinessEntityID] = bec.[PersonID]   LEFT OUTER JOIN   Person.EmailAddress AS ea ON ea.[BusinessEntityID] = p.[BusinessEntityID]   LEFT OUTER JOIN   Person.PersonPhone AS pp ON pp.[BusinessEntityID] = p.[BusinessEntityID]   LEFT OUTER JOIN   Person.PhoneNumberType AS pnt ON pnt.[PhoneNumberTypeID] = pp.[PhoneNumberTypeID]
go

CREATE VIEW [Purchasing].[vVendorWithAddresses] AS  SELECT v.[BusinessEntityID], v.[Name], at.[Name] AS [AddressType], a.[AddressLine1], a.[AddressLine2], a.[City], sp.[Name] AS [StateProvinceName], a.[PostalCode], cr.[Name] AS [CountryRegionName] FROM Purchasing.Vendor AS v   INNER JOIN   Person.BusinessEntityAddress AS bea ON bea.[BusinessEntityID] = v.[BusinessEntityID]   INNER JOIN   Person.Address AS a ON a.[AddressID] = bea.[AddressID]   INNER JOIN   Person.StateProvince AS sp ON sp.[StateProvinceID] = a.[StateProvinceID]   INNER JOIN   Person.CountryRegion AS cr ON cr.[CountryRegionCode] = sp.[CountryRegionCode]   INNER JOIN   Person.AddressType AS at ON at.[AddressTypeID] = bea.[AddressTypeID]
go

CREATE VIEW [Sales].[vSalesPersonSalesByFiscalYears] AS  SELECT pvt.[SalesPersonID], pvt.[FullName], pvt.[JobTitle], pvt.[SalesTerritory], pvt.[2002], pvt.[2003], pvt.[2004] FROM (  SELECT soh.[SalesPersonID], p.[FirstName] + ' ' +  Coalesce(p.[MiddleName] , '')  + ' ' + p.[LastName] AS [FullName], e.[JobTitle], st.[Name] AS [SalesTerritory], soh.[SubTotal],  Year( DateAdd(m, 6, soh.[OrderDate])) AS [FiscalYear] FROM Sales.SalesPerson AS sp   INNER JOIN   Sales.SalesOrderHeader AS soh ON sp.[BusinessEntityID] = soh.[SalesPersonID]   INNER JOIN   Sales.SalesTerritory AS st ON sp.[TerritoryID] = st.[TerritoryID]   INNER JOIN   HumanResources.Employee AS e ON soh.[SalesPersonID] = e.[BusinessEntityID]   INNER JOIN   Person.Person AS p ON p.[BusinessEntityID] = sp.[BusinessEntityID] ) AS soh  PIVOT ( SUM( [SubTotal]) FOR FiscalYear IN ([2002], [2003], [2004]) )   pvt
go


ALTER TABLE [Addr] WITH CHECK 
	ADD CONSTRAINT [FK_Person.StProvince_Person.Ad] FOREIGN KEY ([StProvinceID]) REFERENCES [StProvince]([StProvinceID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Addr]
	  WITH CHECK CHECK CONSTRAINT [FK_Person.StProvince_Person.Ad]
go


ALTER TABLE [BillOfMaterials] WITH CHECK 
	ADD CONSTRAINT  [CK_BillOfMaterials_EndDate]
		CHECK  ( [EndDate]>[StartDate] OR [EndDate] IS NULL ) 
go

ALTER TABLE [BillOfMaterials] WITH CHECK 
	ADD CONSTRAINT  [CK_BillOfMaterials_ProductAsse]
		CHECK  ( [ProductAssemblyID]<>[ComponentID] ) 
go

ALTER TABLE [BillOfMaterials] WITH CHECK 
	ADD CONSTRAINT  [CK_BillOfMaterials_BOMLevel]
		CHECK  ( [ProductAssemblyID] IS NULL AND [BOMLevel]=(0) AND [PerAssemblyQty]=(1.00) OR [ProductAssemblyID] IS NOT NULL AND [BOMLevel]>=(1) ) 
go


ALTER TABLE [BillOfMaterials] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Product_Producti] FOREIGN KEY ([ProductAssemblyID]) REFERENCES [Product]([ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [BillOfMaterials]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Product_Producti]
go

ALTER TABLE [BillOfMaterials] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Product_Producti] FOREIGN KEY ([ComponentID]) REFERENCES [Product]([ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [BillOfMaterials]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Product_Producti]
go

ALTER TABLE [BillOfMaterials] WITH CHECK 
	ADD CONSTRAINT [FK_Production.UnitMeasure_Prod] FOREIGN KEY ([UnitMeasureCd]) REFERENCES [UnitMeasure]([UnitMeasureCd])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [BillOfMaterials]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.UnitMeasure_Prod]
go


ALTER TABLE [BusinessEntityAddr] WITH CHECK 
	ADD CONSTRAINT [FK_Person.Addr_Person.Business] FOREIGN KEY ([AddrID]) REFERENCES [Addr]([AddrID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [BusinessEntityAddr]
	  WITH CHECK CHECK CONSTRAINT [FK_Person.Addr_Person.Business]
go

ALTER TABLE [BusinessEntityAddr] WITH CHECK 
	ADD CONSTRAINT [FK_Person.AddrTyp_Person.Busin] FOREIGN KEY ([AddrTypID]) REFERENCES [AddrTyp]([AddrTypID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [BusinessEntityAddr]
	  WITH CHECK CHECK CONSTRAINT [FK_Person.AddrTyp_Person.Busin]
go

ALTER TABLE [BusinessEntityAddr] WITH CHECK 
	ADD CONSTRAINT [FK_BusinessEntity_BusinessEnti] FOREIGN KEY ([BusinessEntityID]) REFERENCES [BusinessEntity]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [BusinessEntityAddr]
	  WITH CHECK CHECK CONSTRAINT [FK_BusinessEntity_BusinessEnti]
go


ALTER TABLE [BusinessEntityContact] WITH CHECK 
	ADD CONSTRAINT [FK_Person_BusinessEntityContac] FOREIGN KEY ([PersonID]) REFERENCES [Person]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [BusinessEntityContact]
	  WITH CHECK CHECK CONSTRAINT [FK_Person_BusinessEntityContac]
go

ALTER TABLE [BusinessEntityContact] WITH CHECK 
	ADD CONSTRAINT [FK_Person.ContactTyp_Person.Bu] FOREIGN KEY ([ContactTypID]) REFERENCES [ContactTyp]([ContactTypID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [BusinessEntityContact]
	  WITH CHECK CHECK CONSTRAINT [FK_Person.ContactTyp_Person.Bu]
go

ALTER TABLE [BusinessEntityContact] WITH CHECK 
	ADD CONSTRAINT [FK_BusinessEntity_BusinessEnti] FOREIGN KEY ([BusinessEntityID]) REFERENCES [BusinessEntity]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [BusinessEntityContact]
	  WITH CHECK CHECK CONSTRAINT [FK_BusinessEntity_BusinessEnti]
go


ALTER TABLE [CountryRgnCurrency] WITH CHECK 
	ADD CONSTRAINT [FK_Person.CountryRgn_Sales.Cou] FOREIGN KEY ([CountryRgnCd]) REFERENCES [CountryRgn]([CountryRgnCd])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [CountryRgnCurrency]
	  WITH CHECK CHECK CONSTRAINT [FK_Person.CountryRgn_Sales.Cou]
go

ALTER TABLE [CountryRgnCurrency] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.Currency_Sales.Countr] FOREIGN KEY ([CurrencyCd]) REFERENCES [Currency]([CurrencyCd])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [CountryRgnCurrency]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.Currency_Sales.Countr]
go


ALTER TABLE [CurrencyRate] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.Currency_Sales.Curren] FOREIGN KEY ([FromCurrencyCd]) REFERENCES [Currency]([CurrencyCd])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [CurrencyRate]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.Currency_Sales.Curren]
go

ALTER TABLE [CurrencyRate] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.Currency_Sales.Curren] FOREIGN KEY ([ToCurrencyCd]) REFERENCES [Currency]([CurrencyCd])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [CurrencyRate]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.Currency_Sales.Curren]
go


ALTER TABLE [Cust] WITH CHECK 
	ADD CONSTRAINT [FK_Person_Cust] FOREIGN KEY ([PersonID]) REFERENCES [Person]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Cust]
	  WITH CHECK CHECK CONSTRAINT [FK_Person_Cust]
go

ALTER TABLE [Cust] WITH CHECK 
	ADD CONSTRAINT [FK_Stor_Cust] FOREIGN KEY ([StorID]) REFERENCES [Stor]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Cust]
	  WITH CHECK CHECK CONSTRAINT [FK_Stor_Cust]
go

ALTER TABLE [Cust] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.SlsTerritory_Sales.Cu] FOREIGN KEY ([TerritoryID]) REFERENCES [SlsTerritory]([TerritoryID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Cust]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.SlsTerritory_Sales.Cu]
go


ALTER TABLE [Document] WITH CHECK 
	ADD CONSTRAINT [FK_Emp_Document] FOREIGN KEY ([Owner]) REFERENCES [Emp]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Document]
	  WITH CHECK CHECK CONSTRAINT [FK_Emp_Document]
go


ALTER TABLE [EmailAddr] WITH CHECK 
	ADD CONSTRAINT [FK_Person_EmailAddr] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [EmailAddr]
	  WITH CHECK CHECK CONSTRAINT [FK_Person_EmailAddr]
go


ALTER TABLE [Emp] WITH CHECK 
	ADD CONSTRAINT [FK_Person_Emp] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Emp]
	  WITH CHECK CHECK CONSTRAINT [FK_Person_Emp]
go


ALTER TABLE [EmpDepartmentHist] WITH CHECK 
	ADD CONSTRAINT  [CK_EmployeeDepartmentHistory_E]
		CHECK  ( [EndDate]>=[StartDate] OR [EndDate] IS NULL ) 
go


ALTER TABLE [EmpDepartmentHist] WITH CHECK 
	ADD CONSTRAINT [FK_HumanResources.Department_H] FOREIGN KEY ([DepartmentID]) REFERENCES [Department]([DepartmentID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [EmpDepartmentHist]
	  WITH CHECK CHECK CONSTRAINT [FK_HumanResources.Department_H]
go

ALTER TABLE [EmpDepartmentHist] WITH CHECK 
	ADD CONSTRAINT [FK_Emp_EmpDepartmentHist] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Emp]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [EmpDepartmentHist]
	  WITH CHECK CHECK CONSTRAINT [FK_Emp_EmpDepartmentHist]
go

ALTER TABLE [EmpDepartmentHist] WITH CHECK 
	ADD CONSTRAINT [FK_HumanResources.Shift_HumanR] FOREIGN KEY ([ShiftID]) REFERENCES [Shift]([ShiftID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [EmpDepartmentHist]
	  WITH CHECK CHECK CONSTRAINT [FK_HumanResources.Shift_HumanR]
go


ALTER TABLE [EmpPayHist] WITH CHECK 
	ADD CONSTRAINT [FK_Emp_EmpPayHist] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Emp]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [EmpPayHist]
	  WITH CHECK CHECK CONSTRAINT [FK_Emp_EmpPayHist]
go


ALTER TABLE [JobCandiDt] WITH CHECK 
	ADD CONSTRAINT [FK_Emp_JobCandiDt] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Emp]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [JobCandiDt]
	  WITH CHECK CHECK CONSTRAINT [FK_Emp_JobCandiDt]
go


ALTER TABLE [Password] WITH CHECK 
	ADD CONSTRAINT [FK_Person_Password] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Password]
	  WITH CHECK CHECK CONSTRAINT [FK_Person_Password]
go


ALTER TABLE [Person] WITH CHECK 
	ADD CONSTRAINT [FK_BusinessEntity_Person] FOREIGN KEY ([BusinessEntityID]) REFERENCES [BusinessEntity]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Person]
	  WITH CHECK CHECK CONSTRAINT [FK_BusinessEntity_Person]
go


ALTER TABLE [PersonCrdCard] WITH CHECK 
	ADD CONSTRAINT [FK_Person_PersonCrdCard] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [PersonCrdCard]
	  WITH CHECK CHECK CONSTRAINT [FK_Person_PersonCrdCard]
go

ALTER TABLE [PersonCrdCard] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.CrdCard_Sales.PersonC] FOREIGN KEY ([CrdCardID]) REFERENCES [CrdCard]([CrdCardID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [PersonCrdCard]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.CrdCard_Sales.PersonC]
go


ALTER TABLE [PersonPhn] WITH CHECK 
	ADD CONSTRAINT [FK_Person_PersonPhn] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [PersonPhn]
	  WITH CHECK CHECK CONSTRAINT [FK_Person_PersonPhn]
go

ALTER TABLE [PersonPhn] WITH CHECK 
	ADD CONSTRAINT [FK_Person.PhnNbrTyp_Person.Per] FOREIGN KEY ([PhnNbrTypID]) REFERENCES [PhnNbrTyp]([PhnNbrTypID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [PersonPhn]
	  WITH CHECK CHECK CONSTRAINT [FK_Person.PhnNbrTyp_Person.Per]
go


ALTER TABLE [Product] WITH CHECK 
	ADD CONSTRAINT  [CK_Product_SellEndDate]
		CHECK  ( [SellEndDate]>=[SellStartDate] OR [SellEndDate] IS NULL ) 
go


ALTER TABLE [Product] WITH CHECK 
	ADD CONSTRAINT [FK_Production.UnitMeasure_Prod] FOREIGN KEY ([SizeUnitMeasureCd]) REFERENCES [UnitMeasure]([UnitMeasureCd])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Product]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.UnitMeasure_Prod]
go

ALTER TABLE [Product] WITH CHECK 
	ADD CONSTRAINT [FK_Production.UnitMeasure_Prod] FOREIGN KEY ([WeightUnitMeasureCd]) REFERENCES [UnitMeasure]([UnitMeasureCd])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Product]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.UnitMeasure_Prod]
go

ALTER TABLE [Product] WITH CHECK 
	ADD CONSTRAINT [FK_Production.ProductModel_Pro] FOREIGN KEY ([ProductModelID]) REFERENCES [ProductModel]([ProductModelID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Product]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.ProductModel_Pro]
go

ALTER TABLE [Product] WITH CHECK 
	ADD CONSTRAINT [FK_Production.ProductSubcatego] FOREIGN KEY ([ProductSubcategoryID]) REFERENCES [ProductSubcategory]([ProductSubcategoryID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Product]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.ProductSubcatego]
go


ALTER TABLE [ProductCostHist] WITH CHECK 
	ADD CONSTRAINT  [CK_ProductCostHistory_EndDate]
		CHECK  ( [EndDate]>=[StartDate] OR [EndDate] IS NULL ) 
go


ALTER TABLE [ProductCostHist] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Product_Producti] FOREIGN KEY ([ProductID]) REFERENCES [Product]([ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductCostHist]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Product_Producti]
go


ALTER TABLE [ProductDocument] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Product_Producti] FOREIGN KEY ([ProductID]) REFERENCES [Product]([ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductDocument]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Product_Producti]
go

ALTER TABLE [ProductDocument] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Document_Product] FOREIGN KEY ([DocumentNode]) REFERENCES [Document]([DocumentNode])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductDocument]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Document_Product]
go


ALTER TABLE [ProductInventory] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Location_Product] FOREIGN KEY ([LocationID]) REFERENCES [Location]([LocationID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductInventory]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Location_Product]
go

ALTER TABLE [ProductInventory] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Product_Producti] FOREIGN KEY ([ProductID]) REFERENCES [Product]([ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductInventory]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Product_Producti]
go


ALTER TABLE [ProductListPriceHist] WITH CHECK 
	ADD CONSTRAINT  [CK_ProductListPriceHistory_End]
		CHECK  ( [EndDate]>=[StartDate] OR [EndDate] IS NULL ) 
go


ALTER TABLE [ProductListPriceHist] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Product_Producti] FOREIGN KEY ([ProductID]) REFERENCES [Product]([ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductListPriceHist]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Product_Producti]
go


ALTER TABLE [ProductModelIllustration] WITH CHECK 
	ADD CONSTRAINT [FK_Production.ProductModel_Pro] FOREIGN KEY ([ProductModelID]) REFERENCES [ProductModel]([ProductModelID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductModelIllustration]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.ProductModel_Pro]
go

ALTER TABLE [ProductModelIllustration] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Illustration_Pro] FOREIGN KEY ([IllustrationID]) REFERENCES [Illustration]([IllustrationID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductModelIllustration]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Illustration_Pro]
go


ALTER TABLE [ProductModelProductDescCulture] WITH CHECK 
	ADD CONSTRAINT [FK_Production.ProductDesc_Prod] FOREIGN KEY ([ProductDescID]) REFERENCES [ProductDesc]([ProductDescID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductModelProductDescCulture]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.ProductDesc_Prod]
go

ALTER TABLE [ProductModelProductDescCulture] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Culture_Producti] FOREIGN KEY ([CultureID]) REFERENCES [Culture]([CultureID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductModelProductDescCulture]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Culture_Producti]
go

ALTER TABLE [ProductModelProductDescCulture] WITH CHECK 
	ADD CONSTRAINT [FK_Production.ProductModel_Pro] FOREIGN KEY ([ProductModelID]) REFERENCES [ProductModel]([ProductModelID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductModelProductDescCulture]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.ProductModel_Pro]
go


ALTER TABLE [ProductProductPhoto] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Product_Producti] FOREIGN KEY ([ProductID]) REFERENCES [Product]([ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductProductPhoto]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Product_Producti]
go

ALTER TABLE [ProductProductPhoto] WITH CHECK 
	ADD CONSTRAINT [FK_Production.ProductPhoto_Pro] FOREIGN KEY ([ProductPhotoID]) REFERENCES [ProductPhoto]([ProductPhotoID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductProductPhoto]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.ProductPhoto_Pro]
go


ALTER TABLE [ProductReview] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Product_Producti] FOREIGN KEY ([ProductID]) REFERENCES [Product]([ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductReview]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Product_Producti]
go


ALTER TABLE [ProductSubcategory] WITH CHECK 
	ADD CONSTRAINT [FK_Production.ProductCategory_] FOREIGN KEY ([ProductCategoryID]) REFERENCES [ProductCategory]([ProductCategoryID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductSubcategory]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.ProductCategory_]
go


ALTER TABLE [ProductVendor] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Product_Purchasi] FOREIGN KEY ([ProductID]) REFERENCES [Product]([ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductVendor]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Product_Purchasi]
go

ALTER TABLE [ProductVendor] WITH CHECK 
	ADD CONSTRAINT [FK_Production.UnitMeasure_Purc] FOREIGN KEY ([UnitMeasureCd]) REFERENCES [UnitMeasure]([UnitMeasureCd])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductVendor]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.UnitMeasure_Purc]
go

ALTER TABLE [ProductVendor] WITH CHECK 
	ADD CONSTRAINT [FK_Vendor_ProductVendor] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Vendor]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ProductVendor]
	  WITH CHECK CHECK CONSTRAINT [FK_Vendor_ProductVendor]
go


ALTER TABLE [PurchaseOrdrDetail] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Product_Purchasi] FOREIGN KEY ([ProductID]) REFERENCES [Product]([ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [PurchaseOrdrDetail]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Product_Purchasi]
go

ALTER TABLE [PurchaseOrdrDetail] WITH CHECK 
	ADD CONSTRAINT [FK_Purchasing.PurchaseOrdrHead] FOREIGN KEY ([PurchaseOrdrID]) REFERENCES [PurchaseOrdrHeader]([PurchaseOrdrID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [PurchaseOrdrDetail]
	  WITH CHECK CHECK CONSTRAINT [FK_Purchasing.PurchaseOrdrHead]
go


ALTER TABLE [PurchaseOrdrHeader] WITH CHECK 
	ADD CONSTRAINT  [CK_PurchaseOrderHeader_ShipDat]
		CHECK  ( [ShipDate]>=[OrderDate] OR [ShipDate] IS NULL ) 
go


ALTER TABLE [PurchaseOrdrHeader] WITH CHECK 
	ADD CONSTRAINT [FK_Emp_PurchaseOrdrHeader] FOREIGN KEY ([EmpID]) REFERENCES [Emp]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [PurchaseOrdrHeader]
	  WITH CHECK CHECK CONSTRAINT [FK_Emp_PurchaseOrdrHeader]
go

ALTER TABLE [PurchaseOrdrHeader] WITH CHECK 
	ADD CONSTRAINT [FK_Vendor_PurchaseOrdrHeader] FOREIGN KEY ([VendorID]) REFERENCES [Vendor]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [PurchaseOrdrHeader]
	  WITH CHECK CHECK CONSTRAINT [FK_Vendor_PurchaseOrdrHeader]
go

ALTER TABLE [PurchaseOrdrHeader] WITH CHECK 
	ADD CONSTRAINT [FK_Purchasing.ShipMethod_Purch] FOREIGN KEY ([ShipMethodID]) REFERENCES [ShipMethod]([ShipMethodID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [PurchaseOrdrHeader]
	  WITH CHECK CHECK CONSTRAINT [FK_Purchasing.ShipMethod_Purch]
go


ALTER TABLE [ShoppingCartitm] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Product_Sales.Sh] FOREIGN KEY ([ProductID]) REFERENCES [Product]([ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ShoppingCartitm]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Product_Sales.Sh]
go


ALTER TABLE [SlsOrdrDetail] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.SlsOrdrHeader_Sales.S] FOREIGN KEY ([SlsOrdrID]) REFERENCES [SlsOrdrHeader]([SlsOrdrID])
		ON DELETE CASCADE
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsOrdrDetail]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.SlsOrdrHeader_Sales.S]
go

ALTER TABLE [SlsOrdrDetail] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.SpecialOfferProduct_S] FOREIGN KEY ([SpecialOfferID],[ProductID]) REFERENCES [SpecialOfferProduct]([SpecialOfferID],[ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsOrdrDetail]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.SpecialOfferProduct_S]
go


ALTER TABLE [SlsOrdrHeader] WITH CHECK 
	ADD CONSTRAINT  [CK_SalesOrderHeader_DueDate]
		CHECK  ( [DueDate]>=[OrderDate] ) 
go

ALTER TABLE [SlsOrdrHeader] WITH CHECK 
	ADD CONSTRAINT  [CK_SalesOrderHeader_ShipDate]
		CHECK  ( [ShipDate]>=[OrderDate] OR [ShipDate] IS NULL ) 
go


ALTER TABLE [SlsOrdrHeader] WITH CHECK 
	ADD CONSTRAINT [FK_Person.Addr_Sales.SlsOrdrHe] FOREIGN KEY ([BillToAddrID]) REFERENCES [Addr]([AddrID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsOrdrHeader]
	  WITH CHECK CHECK CONSTRAINT [FK_Person.Addr_Sales.SlsOrdrHe]
go

ALTER TABLE [SlsOrdrHeader] WITH CHECK 
	ADD CONSTRAINT [FK_Person.Addr_Sales.SlsOrdrHe] FOREIGN KEY ([ShipToAddrID]) REFERENCES [Addr]([AddrID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsOrdrHeader]
	  WITH CHECK CHECK CONSTRAINT [FK_Person.Addr_Sales.SlsOrdrHe]
go

ALTER TABLE [SlsOrdrHeader] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.CrdCard_Sales.SlsOrdr] FOREIGN KEY ([CrdCardID]) REFERENCES [CrdCard]([CrdCardID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsOrdrHeader]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.CrdCard_Sales.SlsOrdr]
go

ALTER TABLE [SlsOrdrHeader] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.CurrencyRate_Sales.Sl] FOREIGN KEY ([CurrencyRateID]) REFERENCES [CurrencyRate]([CurrencyRateID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsOrdrHeader]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.CurrencyRate_Sales.Sl]
go

ALTER TABLE [SlsOrdrHeader] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.Cust_Sales.SlsOrdrHea] FOREIGN KEY ([CustID]) REFERENCES [Cust]([CustID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsOrdrHeader]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.Cust_Sales.SlsOrdrHea]
go

ALTER TABLE [SlsOrdrHeader] WITH CHECK 
	ADD CONSTRAINT [FK_SlsPerson_SlsOrdrHeader] FOREIGN KEY ([SlsPersonID]) REFERENCES [SlsPerson]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsOrdrHeader]
	  WITH CHECK CHECK CONSTRAINT [FK_SlsPerson_SlsOrdrHeader]
go

ALTER TABLE [SlsOrdrHeader] WITH CHECK 
	ADD CONSTRAINT [FK_Purchasing.ShipMethod_Sales] FOREIGN KEY ([ShipMethodID]) REFERENCES [ShipMethod]([ShipMethodID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsOrdrHeader]
	  WITH CHECK CHECK CONSTRAINT [FK_Purchasing.ShipMethod_Sales]
go

ALTER TABLE [SlsOrdrHeader] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.SlsTerritory_Sales.Sl] FOREIGN KEY ([TerritoryID]) REFERENCES [SlsTerritory]([TerritoryID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsOrdrHeader]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.SlsTerritory_Sales.Sl]
go


ALTER TABLE [SlsOrdrHeaderSlsReason] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.SlsReason_Sales.SlsOr] FOREIGN KEY ([SlsReasonID]) REFERENCES [SlsReason]([SlsReasonID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsOrdrHeaderSlsReason]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.SlsReason_Sales.SlsOr]
go

ALTER TABLE [SlsOrdrHeaderSlsReason] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.SlsOrdrHeader_Sales.S] FOREIGN KEY ([SlsOrdrID]) REFERENCES [SlsOrdrHeader]([SlsOrdrID])
		ON DELETE CASCADE
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsOrdrHeaderSlsReason]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.SlsOrdrHeader_Sales.S]
go


ALTER TABLE [SlsPerson] WITH CHECK 
	ADD CONSTRAINT [FK_Emp_SlsPerson] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Emp]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsPerson]
	  WITH CHECK CHECK CONSTRAINT [FK_Emp_SlsPerson]
go

ALTER TABLE [SlsPerson] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.SlsTerritory_Sales.Sl] FOREIGN KEY ([TerritoryID]) REFERENCES [SlsTerritory]([TerritoryID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsPerson]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.SlsTerritory_Sales.Sl]
go


ALTER TABLE [SlsPersonQuotaHist] WITH CHECK 
	ADD CONSTRAINT [FK_SlsPerson_SlsPersonQuotaHis] FOREIGN KEY ([BusinessEntityID]) REFERENCES [SlsPerson]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsPersonQuotaHist]
	  WITH CHECK CHECK CONSTRAINT [FK_SlsPerson_SlsPersonQuotaHis]
go


ALTER TABLE [SlsTaxRate] WITH CHECK 
	ADD CONSTRAINT [FK_Person.StProvince_Sales.Sls] FOREIGN KEY ([StProvinceID]) REFERENCES [StProvince]([StProvinceID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsTaxRate]
	  WITH CHECK CHECK CONSTRAINT [FK_Person.StProvince_Sales.Sls]
go


ALTER TABLE [SlsTerritory] WITH CHECK 
	ADD CONSTRAINT [FK_Person.CountryRgn_Sales.Sls] FOREIGN KEY ([CountryRgnCd]) REFERENCES [CountryRgn]([CountryRgnCd])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsTerritory]
	  WITH CHECK CHECK CONSTRAINT [FK_Person.CountryRgn_Sales.Sls]
go


ALTER TABLE [SlsTerritoryHist] WITH CHECK 
	ADD CONSTRAINT  [CK_SalesTerritoryHistory_EndDa]
		CHECK  ( [EndDate]>=[StartDate] OR [EndDate] IS NULL ) 
go


ALTER TABLE [SlsTerritoryHist] WITH CHECK 
	ADD CONSTRAINT [FK_SlsPerson_SlsTerritoryHist] FOREIGN KEY ([BusinessEntityID]) REFERENCES [SlsPerson]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsTerritoryHist]
	  WITH CHECK CHECK CONSTRAINT [FK_SlsPerson_SlsTerritoryHist]
go

ALTER TABLE [SlsTerritoryHist] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.SlsTerritory_Sales.Sl] FOREIGN KEY ([TerritoryID]) REFERENCES [SlsTerritory]([TerritoryID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SlsTerritoryHist]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.SlsTerritory_Sales.Sl]
go


ALTER TABLE [SpecialOffer] WITH CHECK 
	ADD CONSTRAINT  [CK_SpecialOffer_EndDate]
		CHECK  ( [EndDate]>=[StartDate] ) 
go


ALTER TABLE [SpecialOfferProduct] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Product_Sales.Sp] FOREIGN KEY ([ProductID]) REFERENCES [Product]([ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SpecialOfferProduct]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Product_Sales.Sp]
go

ALTER TABLE [SpecialOfferProduct] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.SpecialOffer_Sales.Sp] FOREIGN KEY ([SpecialOfferID]) REFERENCES [SpecialOffer]([SpecialOfferID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [SpecialOfferProduct]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.SpecialOffer_Sales.Sp]
go


ALTER TABLE [Stor] WITH CHECK 
	ADD CONSTRAINT [FK_BusinessEntity_Stor] FOREIGN KEY ([BusinessEntityID]) REFERENCES [BusinessEntity]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Stor]
	  WITH CHECK CHECK CONSTRAINT [FK_BusinessEntity_Stor]
go

ALTER TABLE [Stor] WITH CHECK 
	ADD CONSTRAINT [FK_SlsPerson_Stor] FOREIGN KEY ([SlsPersonID]) REFERENCES [SlsPerson]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Stor]
	  WITH CHECK CHECK CONSTRAINT [FK_SlsPerson_Stor]
go


ALTER TABLE [StProvince] WITH CHECK 
	ADD CONSTRAINT [FK_Person.CountryRgn_Person.St] FOREIGN KEY ([CountryRgnCd]) REFERENCES [CountryRgn]([CountryRgnCd])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [StProvince]
	  WITH CHECK CHECK CONSTRAINT [FK_Person.CountryRgn_Person.St]
go

ALTER TABLE [StProvince] WITH CHECK 
	ADD CONSTRAINT [FK_Sales.SlsTerritory_Person.S] FOREIGN KEY ([TerritoryID]) REFERENCES [SlsTerritory]([TerritoryID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [StProvince]
	  WITH CHECK CHECK CONSTRAINT [FK_Sales.SlsTerritory_Person.S]
go


ALTER TABLE [TransactionHist] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Product_Producti] FOREIGN KEY ([ProductID]) REFERENCES [Product]([ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [TransactionHist]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Product_Producti]
go


ALTER TABLE [Vendor] WITH CHECK 
	ADD CONSTRAINT [FK_BusinessEntity_Vendor] FOREIGN KEY ([BusinessEntityID]) REFERENCES [BusinessEntity]([BusinessEntityID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Vendor]
	  WITH CHECK CHECK CONSTRAINT [FK_BusinessEntity_Vendor]
go


ALTER TABLE [WorkOrdr] WITH CHECK 
	ADD CONSTRAINT  [CK_WorkOrder_EndDate]
		CHECK  ( [EndDate]>=[StartDate] OR [EndDate] IS NULL ) 
go


ALTER TABLE [WorkOrdr] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Product_Producti] FOREIGN KEY ([ProductID]) REFERENCES [Product]([ProductID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [WorkOrdr]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Product_Producti]
go

ALTER TABLE [WorkOrdr] WITH CHECK 
	ADD CONSTRAINT [FK_Production.ScrapReason_Prod] FOREIGN KEY ([ScrapReasonID]) REFERENCES [ScrapReason]([ScrapReasonID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [WorkOrdr]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.ScrapReason_Prod]
go


ALTER TABLE [WorkOrdrRouting] WITH CHECK 
	ADD CONSTRAINT  [CK_WorkOrderRouting_ScheduledE]
		CHECK  ( [ScheduledEndDate]>=[ScheduledStartDate] ) 
go

ALTER TABLE [WorkOrdrRouting] WITH CHECK 
	ADD CONSTRAINT  [CK_WorkOrderRouting_ActualEndD]
		CHECK  ( [ActualEndDate]>=[ActualStartDate] OR [ActualEndDate] IS NULL OR [ActualStartDate] IS NULL ) 
go


ALTER TABLE [WorkOrdrRouting] WITH CHECK 
	ADD CONSTRAINT [FK_Production.Location_Product] FOREIGN KEY ([LocationID]) REFERENCES [Location]([LocationID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [WorkOrdrRouting]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.Location_Product]
go

ALTER TABLE [WorkOrdrRouting] WITH CHECK 
	ADD CONSTRAINT [FK_Production.WorkOrdr_Product] FOREIGN KEY ([WorkOrdrID]) REFERENCES [WorkOrdr]([WorkOrdrID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [WorkOrdrRouting]
	  WITH CHECK CHECK CONSTRAINT [FK_Production.WorkOrdr_Product]
go

CREATE TRIGGER HumanResources.tD_EmployeePayHistory ON HumanResources.EmpPayHist FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on EmpPayHist */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* HumanResources.Emp  HumanResources.EmpPayHist on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001a522", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpPayHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_EmpPayHist", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,HumanResources.Emp
      WHERE
        /* %JoinFKPK(deleted,HumanResources.Emp," = "," AND") */
        deleted.BusinessEntityID = HumanResources.Emp.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM HumanResources.EmpPayHist
          WHERE
            /* %JoinFKPK(HumanResources.EmpPayHist,HumanResources.Emp," = "," AND") */
            HumanResources.EmpPayHist.BusinessEntityID = HumanResources.Emp.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last HumanResources.EmpPayHist because HumanResources.Emp exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.tU_EmployeePayHistory ON HumanResources.EmpPayHist FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on EmpPayHist */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int, 
           @insRateChangeDt datetime,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* HumanResources.Emp  HumanResources.EmpPayHist on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001a749", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpPayHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_EmpPayHist", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,HumanResources.Emp
        WHERE
          /* %JoinFKPK(inserted,HumanResources.Emp) */
          inserted.BusinessEntityID = HumanResources.Emp.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update HumanResources.EmpPayHist because HumanResources.Emp does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_SalesOrderHeaderSalesReason ON Sales.SlsOrdrHeaderSlsReason FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on SlsOrdrHeaderSlsReason */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.SlsOrdrHeader  Sales.SlsOrdrHeaderSlsReason on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000339a2", PARENT_OWNER="Sales", PARENT_TABLE="SlsOrdrHeader"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeaderSlsReason"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsOrdrHeader_Sales.S", FK_COLUMNS="SlsOrdrID" */
    IF EXISTS (SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /* %JoinFKPK(deleted,Sales.SlsOrdrHeader," = "," AND") */
        deleted.SlsOrdrID = Sales.SlsOrdrHeader.SlsOrdrID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsOrdrHeaderSlsReason
          WHERE
            /* %JoinFKPK(Sales.SlsOrdrHeaderSlsReason,Sales.SlsOrdrHeader," = "," AND") */
            Sales.SlsOrdrHeaderSlsReason.SlsOrdrID = Sales.SlsOrdrHeader.SlsOrdrID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsOrdrHeaderSlsReason because Sales.SlsOrdrHeader exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsReason  Sales.SlsOrdrHeaderSlsReason on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsReason"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeaderSlsReason"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsReason_Sales.SlsOr", FK_COLUMNS="SlsReasonID" */
    IF EXISTS (SELECT * FROM deleted,Sales.SlsReason
      WHERE
        /* %JoinFKPK(deleted,Sales.SlsReason," = "," AND") */
        deleted.SlsReasonID = Sales.SlsReason.SlsReasonID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsOrdrHeaderSlsReason
          WHERE
            /* %JoinFKPK(Sales.SlsOrdrHeaderSlsReason,Sales.SlsReason," = "," AND") */
            Sales.SlsOrdrHeaderSlsReason.SlsReasonID = Sales.SlsReason.SlsReasonID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsOrdrHeaderSlsReason because Sales.SlsReason exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_SalesOrderHeaderSalesReason ON Sales.SlsOrdrHeaderSlsReason FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsOrdrHeaderSlsReason */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSlsOrdrID int, 
           @insSlsReasonID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.SlsOrdrHeader  Sales.SlsOrdrHeaderSlsReason on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00034188", PARENT_OWNER="Sales", PARENT_TABLE="SlsOrdrHeader"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeaderSlsReason"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsOrdrHeader_Sales.S", FK_COLUMNS="SlsOrdrID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(SlsOrdrID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.SlsOrdrHeader
        WHERE
          /* %JoinFKPK(inserted,Sales.SlsOrdrHeader) */
          inserted.SlsOrdrID = Sales.SlsOrdrHeader.SlsOrdrID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsOrdrHeaderSlsReason because Sales.SlsOrdrHeader does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SlsReason  Sales.SlsOrdrHeaderSlsReason on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsReason"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeaderSlsReason"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsReason_Sales.SlsOr", FK_COLUMNS="SlsReasonID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(SlsReasonID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.SlsReason
        WHERE
          /* %JoinFKPK(inserted,Sales.SlsReason) */
          inserted.SlsReasonID = Sales.SlsReason.SlsReasonID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsOrdrHeaderSlsReason because Sales.SlsReason does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_SalesPerson ON Sales.SlsPerson FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on SlsPerson */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.SlsPerson  Sales.SlsOrdrHeader on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00079f4e", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_SlsOrdrHeader", FK_COLUMNS="SlsPersonID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.SlsPersonID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.SlsPerson because Sales.SlsOrdrHeader exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsPerson  Sales.Stor on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="Stor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_Stor", FK_COLUMNS="SlsPersonID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.Stor
      WHERE
        /*  %JoinFKPK(Sales.Stor,deleted," = "," AND") */
        Sales.Stor.SlsPersonID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.SlsPerson because Sales.Stor exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsPerson  Sales.SlsTerritoryHist on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTerritoryHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_SlsTerritoryHist", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsTerritoryHist
      WHERE
        /*  %JoinFKPK(Sales.SlsTerritoryHist,deleted," = "," AND") */
        Sales.SlsTerritoryHist.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.SlsPerson because Sales.SlsTerritoryHist exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsPerson  Sales.SlsPersonQuotaHist on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsPersonQuotaHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_SlsPersonQuotaHis", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsPersonQuotaHist
      WHERE
        /*  %JoinFKPK(Sales.SlsPersonQuotaHist,deleted," = "," AND") */
        Sales.SlsPersonQuotaHist.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.SlsPerson because Sales.SlsPersonQuotaHist exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsTerritory  Sales.SlsPerson on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsPerson"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Sl", FK_COLUMNS="TerritoryID" */
    IF EXISTS (SELECT * FROM deleted,Sales.SlsTerritory
      WHERE
        /* %JoinFKPK(deleted,Sales.SlsTerritory," = "," AND") */
        deleted.TerritoryID = Sales.SlsTerritory.TerritoryID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsPerson
          WHERE
            /* %JoinFKPK(Sales.SlsPerson,Sales.SlsTerritory," = "," AND") */
            Sales.SlsPerson.TerritoryID = Sales.SlsTerritory.TerritoryID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsPerson because Sales.SlsTerritory exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* HumanResources.Emp  Sales.SlsPerson on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsPerson"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_SlsPerson", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,HumanResources.Emp
      WHERE
        /* %JoinFKPK(deleted,HumanResources.Emp," = "," AND") */
        deleted.BusinessEntityID = HumanResources.Emp.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsPerson
          WHERE
            /* %JoinFKPK(Sales.SlsPerson,HumanResources.Emp," = "," AND") */
            Sales.SlsPerson.BusinessEntityID = HumanResources.Emp.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsPerson because HumanResources.Emp exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_SalesPerson ON Sales.SlsPerson FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsPerson */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.SlsPerson  Sales.SlsOrdrHeader on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00084560", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_SlsOrdrHeader", FK_COLUMNS="SlsPersonID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.SlsPersonID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.SlsPerson because Sales.SlsOrdrHeader exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SlsPerson  Sales.Stor on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="Stor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_Stor", FK_COLUMNS="SlsPersonID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.Stor
      WHERE
        /*  %JoinFKPK(Sales.Stor,deleted," = "," AND") */
        Sales.Stor.SlsPersonID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.SlsPerson because Sales.Stor exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SlsPerson  Sales.SlsTerritoryHist on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTerritoryHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_SlsTerritoryHist", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsTerritoryHist
      WHERE
        /*  %JoinFKPK(Sales.SlsTerritoryHist,deleted," = "," AND") */
        Sales.SlsTerritoryHist.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.SlsPerson because Sales.SlsTerritoryHist exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SlsPerson  Sales.SlsPersonQuotaHist on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsPersonQuotaHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_SlsPersonQuotaHis", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsPersonQuotaHist
      WHERE
        /*  %JoinFKPK(Sales.SlsPersonQuotaHist,deleted," = "," AND") */
        Sales.SlsPersonQuotaHist.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.SlsPerson because Sales.SlsPersonQuotaHist exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SlsTerritory  Sales.SlsPerson on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsPerson"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Sl", FK_COLUMNS="TerritoryID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(TerritoryID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.SlsTerritory
        WHERE
          /* %JoinFKPK(inserted,Sales.SlsTerritory) */
          inserted.TerritoryID = Sales.SlsTerritory.TerritoryID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.TerritoryID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsPerson because Sales.SlsTerritory does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* HumanResources.Emp  Sales.SlsPerson on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsPerson"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_SlsPerson", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,HumanResources.Emp
        WHERE
          /* %JoinFKPK(inserted,HumanResources.Emp) */
          inserted.BusinessEntityID = HumanResources.Emp.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsPerson because HumanResources.Emp does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_Illustration ON Production.Illustration FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Illustration */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.Illustration  Production.ProductModelIllustration on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00016b30", PARENT_OWNER="Production", PARENT_TABLE="Illustration"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelIllustration"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Illustration_Pro", FK_COLUMNS="IllustrationID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductModelIllustration
      WHERE
        /*  %JoinFKPK(Production.ProductModelIllustration,deleted," = "," AND") */
        Production.ProductModelIllustration.IllustrationID = deleted.IllustrationID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Illustration because Production.ProductModelIllustration exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_Illustration ON Production.Illustration FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Illustration */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIllustrationID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Illustration  Production.ProductModelIllustration on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000193fa", PARENT_OWNER="Production", PARENT_TABLE="Illustration"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelIllustration"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Illustration_Pro", FK_COLUMNS="IllustrationID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IllustrationID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductModelIllustration
      WHERE
        /*  %JoinFKPK(Production.ProductModelIllustration,deleted," = "," AND") */
        Production.ProductModelIllustration.IllustrationID = deleted.IllustrationID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Illustration because Production.ProductModelIllustration exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.tD_JobCandidate ON HumanResources.JobCandiDt FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on JobCandiDt */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* HumanResources.Emp  HumanResources.JobCandiDt on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001a7dd", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="HumanResources", CHILD_TABLE="JobCandiDt"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_JobCandiDt", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,HumanResources.Emp
      WHERE
        /* %JoinFKPK(deleted,HumanResources.Emp," = "," AND") */
        deleted.BusinessEntityID = HumanResources.Emp.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM HumanResources.JobCandiDt
          WHERE
            /* %JoinFKPK(HumanResources.JobCandiDt,HumanResources.Emp," = "," AND") */
            HumanResources.JobCandiDt.BusinessEntityID = HumanResources.Emp.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last HumanResources.JobCandiDt because HumanResources.Emp exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.tU_JobCandidate ON HumanResources.JobCandiDt FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on JobCandiDt */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insJobCandiDtID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* HumanResources.Emp  HumanResources.JobCandiDt on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001c0cd", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="HumanResources", CHILD_TABLE="JobCandiDt"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_JobCandiDt", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,HumanResources.Emp
        WHERE
          /* %JoinFKPK(inserted,HumanResources.Emp) */
          inserted.BusinessEntityID = HumanResources.Emp.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.BusinessEntityID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update HumanResources.JobCandiDt because HumanResources.Emp does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_Location ON Production.Location FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Location */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.Location  Production.WorkOrdrRouting on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002a07a", PARENT_OWNER="Production", PARENT_TABLE="Location"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdrRouting"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Location_Product", FK_COLUMNS="LocationID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.WorkOrdrRouting
      WHERE
        /*  %JoinFKPK(Production.WorkOrdrRouting,deleted," = "," AND") */
        Production.WorkOrdrRouting.LocationID = deleted.LocationID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Location because Production.WorkOrdrRouting exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Location  Production.ProductInventory on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Location"
    CHILD_OWNER="Production", CHILD_TABLE="ProductInventory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Location_Product", FK_COLUMNS="LocationID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductInventory
      WHERE
        /*  %JoinFKPK(Production.ProductInventory,deleted," = "," AND") */
        Production.ProductInventory.LocationID = deleted.LocationID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Location because Production.ProductInventory exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_Location ON Production.Location FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Location */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insLocationID smallint,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Location  Production.WorkOrdrRouting on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002c114", PARENT_OWNER="Production", PARENT_TABLE="Location"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdrRouting"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Location_Product", FK_COLUMNS="LocationID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(LocationID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.WorkOrdrRouting
      WHERE
        /*  %JoinFKPK(Production.WorkOrdrRouting,deleted," = "," AND") */
        Production.WorkOrdrRouting.LocationID = deleted.LocationID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Location because Production.WorkOrdrRouting exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Location  Production.ProductInventory on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Location"
    CHILD_OWNER="Production", CHILD_TABLE="ProductInventory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Location_Product", FK_COLUMNS="LocationID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(LocationID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductInventory
      WHERE
        /*  %JoinFKPK(Production.ProductInventory,deleted," = "," AND") */
        Production.ProductInventory.LocationID = deleted.LocationID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Location because Production.ProductInventory exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tD_Password ON Person.Password FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Password */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.Person  Person.Password on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00017b3e", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="Password"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_Password", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,Person.Person
      WHERE
        /* %JoinFKPK(deleted,Person.Person," = "," AND") */
        deleted.BusinessEntityID = Person.Person.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Person.Password
          WHERE
            /* %JoinFKPK(Person.Password,Person.Person," = "," AND") */
            Person.Password.BusinessEntityID = Person.Person.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Person.Password because Person.Person exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tU_Password ON Person.Password FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Password */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.Person  Person.Password on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001916d", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="Password"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_Password", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.Person
        WHERE
          /* %JoinFKPK(inserted,Person.Person) */
          inserted.BusinessEntityID = Person.Person.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Person.Password because Person.Person does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_SalesPersonQuotaHistory ON Sales.SlsPersonQuotaHist FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on SlsPersonQuotaHist */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.SlsPerson  Sales.SlsPersonQuotaHist on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001a6cb", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsPersonQuotaHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_SlsPersonQuotaHis", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,Sales.SlsPerson
      WHERE
        /* %JoinFKPK(deleted,Sales.SlsPerson," = "," AND") */
        deleted.BusinessEntityID = Sales.SlsPerson.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsPersonQuotaHist
          WHERE
            /* %JoinFKPK(Sales.SlsPersonQuotaHist,Sales.SlsPerson," = "," AND") */
            Sales.SlsPersonQuotaHist.BusinessEntityID = Sales.SlsPerson.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsPersonQuotaHist because Sales.SlsPerson exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_SalesPersonQuotaHistory ON Sales.SlsPersonQuotaHist FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsPersonQuotaHist */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int, 
           @insQuotaDt datetime,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.SlsPerson  Sales.SlsPersonQuotaHist on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001a491", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsPersonQuotaHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_SlsPersonQuotaHis", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.SlsPerson
        WHERE
          /* %JoinFKPK(inserted,Sales.SlsPerson) */
          inserted.BusinessEntityID = Sales.SlsPerson.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsPersonQuotaHist because Sales.SlsPerson does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER [iuPerson] ON Person
   WITH 
 EXECUTE AS CALLER  AFTER INSERT,UPDATE 
 
 NOT FOR REPLICATION 
  AS

BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    IF UPDATE([BusinessEntityID]) OR UPDATE([Demographics]) 
    BEGIN
        UPDATE [Person].[Person] 
        SET [Person].[Person].[Demographics] = N'<IndividualSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"> 
            <TotalPurchaseYTD>0.00</TotalPurchaseYTD> 
            </IndividualSurvey>' 
        FROM inserted 
        WHERE [Person].[Person].[BusinessEntityID] = inserted.[BusinessEntityID] 
            AND inserted.[Demographics] IS NULL;
        
        UPDATE [Person].[Person] 
        SET [Demographics].modify(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
            insert <TotalPurchaseYTD>0.00</TotalPurchaseYTD> 
            as first 
            into (/IndividualSurvey)[1]') 
        FROM inserted 
        WHERE [Person].[Person].[BusinessEntityID] = inserted.[BusinessEntityID] 
            AND inserted.[Demographics] IS NOT NULL 
            AND inserted.[Demographics].exist(N'declare default element namespace 
                "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
                /IndividualSurvey/TotalPurchaseYTD') <> 1;
    END;
END;

 
go


ENABLE TRIGGER [iuPerson] ON Person
go

CREATE TRIGGER Person.tD_Person ON Person.Person FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Person */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.Person  HumanResources.Emp on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00096397", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="HumanResources", CHILD_TABLE="Emp"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_Emp", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,HumanResources.Emp
      WHERE
        /*  %JoinFKPK(HumanResources.Emp,deleted," = "," AND") */
        HumanResources.Emp.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.Person because HumanResources.Emp exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Person  Person.EmailAddr on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="EmailAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_EmailAddr", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,Person.EmailAddr
      WHERE
        /*  %JoinFKPK(Person.EmailAddr,deleted," = "," AND") */
        Person.EmailAddr.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.Person because Person.EmailAddr exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Person  Sales.Cust on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Sales", CHILD_TABLE="Cust"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_Cust", FK_COLUMNS="PersonID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.Cust
      WHERE
        /*  %JoinFKPK(Sales.Cust,deleted," = "," AND") */
        Sales.Cust.PersonID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.Person because Sales.Cust exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Person  Person.BusinessEntityContact on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityContact"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_BusinessEntityContac", FK_COLUMNS="PersonID" */
    IF EXISTS (
      SELECT * FROM deleted,Person.BusinessEntityContact
      WHERE
        /*  %JoinFKPK(Person.BusinessEntityContact,deleted," = "," AND") */
        Person.BusinessEntityContact.PersonID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.Person because Person.BusinessEntityContact exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Person  Person.PersonPhn on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="PersonPhn"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_PersonPhn", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,Person.PersonPhn
      WHERE
        /*  %JoinFKPK(Person.PersonPhn,deleted," = "," AND") */
        Person.PersonPhn.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.Person because Person.PersonPhn exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Person  Sales.PersonCrdCard on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Sales", CHILD_TABLE="PersonCrdCard"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_PersonCrdCard", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.PersonCrdCard
      WHERE
        /*  %JoinFKPK(Sales.PersonCrdCard,deleted," = "," AND") */
        Sales.PersonCrdCard.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.Person because Sales.PersonCrdCard exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Person  Person.Password on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="Password"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_Password", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,Person.Password
      WHERE
        /*  %JoinFKPK(Person.Password,deleted," = "," AND") */
        Person.Password.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.Person because Person.Password exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.BusinessEntity  Person.Person on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Person", CHILD_TABLE="Person"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_Person", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,Person.BusinessEntity
      WHERE
        /* %JoinFKPK(deleted,Person.BusinessEntity," = "," AND") */
        deleted.BusinessEntityID = Person.BusinessEntity.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Person.Person
          WHERE
            /* %JoinFKPK(Person.Person,Person.BusinessEntity," = "," AND") */
            Person.Person.BusinessEntityID = Person.BusinessEntity.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Person.Person because Person.BusinessEntity exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tU_Person ON Person.Person FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Person */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.Person  HumanResources.Emp on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000a4aed", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="HumanResources", CHILD_TABLE="Emp"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_Emp", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,HumanResources.Emp
      WHERE
        /*  %JoinFKPK(HumanResources.Emp,deleted," = "," AND") */
        HumanResources.Emp.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.Person because HumanResources.Emp exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.Person  Person.EmailAddr on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="EmailAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_EmailAddr", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Person.EmailAddr
      WHERE
        /*  %JoinFKPK(Person.EmailAddr,deleted," = "," AND") */
        Person.EmailAddr.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.Person because Person.EmailAddr exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.Person  Sales.Cust on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Sales", CHILD_TABLE="Cust"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_Cust", FK_COLUMNS="PersonID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.Cust
      WHERE
        /*  %JoinFKPK(Sales.Cust,deleted," = "," AND") */
        Sales.Cust.PersonID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.Person because Sales.Cust exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.Person  Person.BusinessEntityContact on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityContact"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_BusinessEntityContac", FK_COLUMNS="PersonID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Person.BusinessEntityContact
      WHERE
        /*  %JoinFKPK(Person.BusinessEntityContact,deleted," = "," AND") */
        Person.BusinessEntityContact.PersonID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.Person because Person.BusinessEntityContact exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.Person  Person.PersonPhn on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="PersonPhn"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_PersonPhn", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Person.PersonPhn
      WHERE
        /*  %JoinFKPK(Person.PersonPhn,deleted," = "," AND") */
        Person.PersonPhn.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.Person because Person.PersonPhn exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.Person  Sales.PersonCrdCard on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Sales", CHILD_TABLE="PersonCrdCard"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_PersonCrdCard", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.PersonCrdCard
      WHERE
        /*  %JoinFKPK(Sales.PersonCrdCard,deleted," = "," AND") */
        Sales.PersonCrdCard.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.Person because Sales.PersonCrdCard exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.Person  Person.Password on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="Password"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_Password", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Person.Password
      WHERE
        /*  %JoinFKPK(Person.Password,deleted," = "," AND") */
        Person.Password.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.Person because Person.Password exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.BusinessEntity  Person.Person on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Person", CHILD_TABLE="Person"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_Person", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.BusinessEntity
        WHERE
          /* %JoinFKPK(inserted,Person.BusinessEntity) */
          inserted.BusinessEntityID = Person.BusinessEntity.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Person.Person because Person.BusinessEntity does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_SalesReason ON Sales.SlsReason FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on SlsReason */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.SlsReason  Sales.SlsOrdrHeaderSlsReason on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00015985", PARENT_OWNER="Sales", PARENT_TABLE="SlsReason"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeaderSlsReason"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsReason_Sales.SlsOr", FK_COLUMNS="SlsReasonID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeaderSlsReason
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeaderSlsReason,deleted," = "," AND") */
        Sales.SlsOrdrHeaderSlsReason.SlsReasonID = deleted.SlsReasonID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.SlsReason because Sales.SlsOrdrHeaderSlsReason exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_SalesReason ON Sales.SlsReason FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsReason */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSlsReasonID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.SlsReason  Sales.SlsOrdrHeaderSlsReason on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00017aa6", PARENT_OWNER="Sales", PARENT_TABLE="SlsReason"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeaderSlsReason"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsReason_Sales.SlsOr", FK_COLUMNS="SlsReasonID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(SlsReasonID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeaderSlsReason
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeaderSlsReason,deleted," = "," AND") */
        Sales.SlsOrdrHeaderSlsReason.SlsReasonID = deleted.SlsReasonID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.SlsReason because Sales.SlsOrdrHeaderSlsReason exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_SalesTaxRate ON Sales.SlsTaxRate FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on SlsTaxRate */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.StProvince  Sales.SlsTaxRate on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00018bdb", PARENT_OWNER="Person", PARENT_TABLE="StProvince"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTaxRate"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.StProvince_Sales.Sls", FK_COLUMNS="StProvinceID" */
    IF EXISTS (SELECT * FROM deleted,Person.StProvince
      WHERE
        /* %JoinFKPK(deleted,Person.StProvince," = "," AND") */
        deleted.StProvinceID = Person.StProvince.StProvinceID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsTaxRate
          WHERE
            /* %JoinFKPK(Sales.SlsTaxRate,Person.StProvince," = "," AND") */
            Sales.SlsTaxRate.StProvinceID = Person.StProvince.StProvinceID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsTaxRate because Person.StProvince exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_SalesTaxRate ON Sales.SlsTaxRate FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsTaxRate */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSlsTaxRateID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.StProvince  Sales.SlsTaxRate on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00019a03", PARENT_OWNER="Person", PARENT_TABLE="StProvince"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTaxRate"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.StProvince_Sales.Sls", FK_COLUMNS="StProvinceID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(StProvinceID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.StProvince
        WHERE
          /* %JoinFKPK(inserted,Person.StProvince) */
          inserted.StProvinceID = Person.StProvince.StProvinceID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsTaxRate because Person.StProvince does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_PersonCreditCard ON Sales.PersonCrdCard FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on PersonCrdCard */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.CrdCard  Sales.PersonCrdCard on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002f53d", PARENT_OWNER="Sales", PARENT_TABLE="CrdCard"
    CHILD_OWNER="Sales", CHILD_TABLE="PersonCrdCard"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.CrdCard_Sales.PersonC", FK_COLUMNS="CrdCardID" */
    IF EXISTS (SELECT * FROM deleted,Sales.CrdCard
      WHERE
        /* %JoinFKPK(deleted,Sales.CrdCard," = "," AND") */
        deleted.CrdCardID = Sales.CrdCard.CrdCardID AND
        NOT EXISTS (
          SELECT * FROM Sales.PersonCrdCard
          WHERE
            /* %JoinFKPK(Sales.PersonCrdCard,Sales.CrdCard," = "," AND") */
            Sales.PersonCrdCard.CrdCardID = Sales.CrdCard.CrdCardID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.PersonCrdCard because Sales.CrdCard exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Person  Sales.PersonCrdCard on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Sales", CHILD_TABLE="PersonCrdCard"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_PersonCrdCard", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,Person.Person
      WHERE
        /* %JoinFKPK(deleted,Person.Person," = "," AND") */
        deleted.BusinessEntityID = Person.Person.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Sales.PersonCrdCard
          WHERE
            /* %JoinFKPK(Sales.PersonCrdCard,Person.Person," = "," AND") */
            Sales.PersonCrdCard.BusinessEntityID = Person.Person.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.PersonCrdCard because Person.Person exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_PersonCreditCard ON Sales.PersonCrdCard FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on PersonCrdCard */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int, 
           @insCrdCardID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.CrdCard  Sales.PersonCrdCard on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000306a8", PARENT_OWNER="Sales", PARENT_TABLE="CrdCard"
    CHILD_OWNER="Sales", CHILD_TABLE="PersonCrdCard"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.CrdCard_Sales.PersonC", FK_COLUMNS="CrdCardID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CrdCardID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.CrdCard
        WHERE
          /* %JoinFKPK(inserted,Sales.CrdCard) */
          inserted.CrdCardID = Sales.CrdCard.CrdCardID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.PersonCrdCard because Sales.CrdCard does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.Person  Sales.PersonCrdCard on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Sales", CHILD_TABLE="PersonCrdCard"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_PersonCrdCard", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.Person
        WHERE
          /* %JoinFKPK(inserted,Person.Person) */
          inserted.BusinessEntityID = Person.Person.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.PersonCrdCard because Person.Person does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tD_PersonPhone ON Person.PersonPhn FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on PersonPhn */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.PhnNbrTyp  Person.PersonPhn on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002eff0", PARENT_OWNER="Person", PARENT_TABLE="PhnNbrTyp"
    CHILD_OWNER="Person", CHILD_TABLE="PersonPhn"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.PhnNbrTyp_Person.Per", FK_COLUMNS="PhnNbrTypID" */
    IF EXISTS (SELECT * FROM deleted,Person.PhnNbrTyp
      WHERE
        /* %JoinFKPK(deleted,Person.PhnNbrTyp," = "," AND") */
        deleted.PhnNbrTypID = Person.PhnNbrTyp.PhnNbrTypID AND
        NOT EXISTS (
          SELECT * FROM Person.PersonPhn
          WHERE
            /* %JoinFKPK(Person.PersonPhn,Person.PhnNbrTyp," = "," AND") */
            Person.PersonPhn.PhnNbrTypID = Person.PhnNbrTyp.PhnNbrTypID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Person.PersonPhn because Person.PhnNbrTyp exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Person  Person.PersonPhn on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="PersonPhn"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_PersonPhn", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,Person.Person
      WHERE
        /* %JoinFKPK(deleted,Person.Person," = "," AND") */
        deleted.BusinessEntityID = Person.Person.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Person.PersonPhn
          WHERE
            /* %JoinFKPK(Person.PersonPhn,Person.Person," = "," AND") */
            Person.PersonPhn.BusinessEntityID = Person.Person.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Person.PersonPhn because Person.Person exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tU_PersonPhone ON Person.PersonPhn FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on PersonPhn */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int, 
           @insPhnNbr Phn, 
           @insPhnNbrTypID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.PhnNbrTyp  Person.PersonPhn on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00030568", PARENT_OWNER="Person", PARENT_TABLE="PhnNbrTyp"
    CHILD_OWNER="Person", CHILD_TABLE="PersonPhn"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.PhnNbrTyp_Person.Per", FK_COLUMNS="PhnNbrTypID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(PhnNbrTypID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.PhnNbrTyp
        WHERE
          /* %JoinFKPK(inserted,Person.PhnNbrTyp) */
          inserted.PhnNbrTypID = Person.PhnNbrTyp.PhnNbrTypID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Person.PersonPhn because Person.PhnNbrTyp does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.Person  Person.PersonPhn on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="PersonPhn"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_PersonPhn", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.Person
        WHERE
          /* %JoinFKPK(inserted,Person.Person) */
          inserted.BusinessEntityID = Person.Person.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Person.PersonPhn because Person.Person does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_SalesTerritory ON Sales.SlsTerritory FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on SlsTerritory */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.SlsTerritory  Sales.SlsOrdrHeader on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0007459b", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Sl", FK_COLUMNS="TerritoryID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.TerritoryID = deleted.TerritoryID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.SlsTerritory because Sales.SlsOrdrHeader exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsTerritory  Sales.Cust on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="Cust"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Cu", FK_COLUMNS="TerritoryID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.Cust
      WHERE
        /*  %JoinFKPK(Sales.Cust,deleted," = "," AND") */
        Sales.Cust.TerritoryID = deleted.TerritoryID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.SlsTerritory because Sales.Cust exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsTerritory  Person.StProvince on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Person", CHILD_TABLE="StProvince"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Person.S", FK_COLUMNS="TerritoryID" */
    IF EXISTS (
      SELECT * FROM deleted,Person.StProvince
      WHERE
        /*  %JoinFKPK(Person.StProvince,deleted," = "," AND") */
        Person.StProvince.TerritoryID = deleted.TerritoryID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.SlsTerritory because Person.StProvince exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsTerritory  Sales.SlsTerritoryHist on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTerritoryHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Sl", FK_COLUMNS="TerritoryID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsTerritoryHist
      WHERE
        /*  %JoinFKPK(Sales.SlsTerritoryHist,deleted," = "," AND") */
        Sales.SlsTerritoryHist.TerritoryID = deleted.TerritoryID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.SlsTerritory because Sales.SlsTerritoryHist exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsTerritory  Sales.SlsPerson on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsPerson"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Sl", FK_COLUMNS="TerritoryID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsPerson
      WHERE
        /*  %JoinFKPK(Sales.SlsPerson,deleted," = "," AND") */
        Sales.SlsPerson.TerritoryID = deleted.TerritoryID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.SlsTerritory because Sales.SlsPerson exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.CountryRgn  Sales.SlsTerritory on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="CountryRgn"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTerritory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.CountryRgn_Sales.Sls", FK_COLUMNS="CountryRgnCd" */
    IF EXISTS (SELECT * FROM deleted,Person.CountryRgn
      WHERE
        /* %JoinFKPK(deleted,Person.CountryRgn," = "," AND") */
        deleted.CountryRgnCd = Person.CountryRgn.CountryRgnCd AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsTerritory
          WHERE
            /* %JoinFKPK(Sales.SlsTerritory,Person.CountryRgn," = "," AND") */
            Sales.SlsTerritory.CountryRgnCd = Person.CountryRgn.CountryRgnCd
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsTerritory because Person.CountryRgn exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_SalesTerritory ON Sales.SlsTerritory FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsTerritory */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insTerritoryID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.SlsTerritory  Sales.SlsOrdrHeader on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0007da02", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Sl", FK_COLUMNS="TerritoryID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(TerritoryID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.TerritoryID = deleted.TerritoryID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.SlsTerritory because Sales.SlsOrdrHeader exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SlsTerritory  Sales.Cust on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="Cust"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Cu", FK_COLUMNS="TerritoryID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(TerritoryID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.Cust
      WHERE
        /*  %JoinFKPK(Sales.Cust,deleted," = "," AND") */
        Sales.Cust.TerritoryID = deleted.TerritoryID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.SlsTerritory because Sales.Cust exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SlsTerritory  Person.StProvince on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Person", CHILD_TABLE="StProvince"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Person.S", FK_COLUMNS="TerritoryID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(TerritoryID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Person.StProvince
      WHERE
        /*  %JoinFKPK(Person.StProvince,deleted," = "," AND") */
        Person.StProvince.TerritoryID = deleted.TerritoryID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.SlsTerritory because Person.StProvince exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SlsTerritory  Sales.SlsTerritoryHist on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTerritoryHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Sl", FK_COLUMNS="TerritoryID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(TerritoryID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsTerritoryHist
      WHERE
        /*  %JoinFKPK(Sales.SlsTerritoryHist,deleted," = "," AND") */
        Sales.SlsTerritoryHist.TerritoryID = deleted.TerritoryID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.SlsTerritory because Sales.SlsTerritoryHist exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SlsTerritory  Sales.SlsPerson on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsPerson"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Sl", FK_COLUMNS="TerritoryID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(TerritoryID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsPerson
      WHERE
        /*  %JoinFKPK(Sales.SlsPerson,deleted," = "," AND") */
        Sales.SlsPerson.TerritoryID = deleted.TerritoryID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.SlsTerritory because Sales.SlsPerson exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.CountryRgn  Sales.SlsTerritory on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="CountryRgn"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTerritory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.CountryRgn_Sales.Sls", FK_COLUMNS="CountryRgnCd" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CountryRgnCd)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.CountryRgn
        WHERE
          /* %JoinFKPK(inserted,Person.CountryRgn) */
          inserted.CountryRgnCd = Person.CountryRgn.CountryRgnCd
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsTerritory because Person.CountryRgn does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tD_PhoneNumberType ON Person.PhnNbrTyp FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on PhnNbrTyp */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.PhnNbrTyp  Person.PersonPhn on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00012b5e", PARENT_OWNER="Person", PARENT_TABLE="PhnNbrTyp"
    CHILD_OWNER="Person", CHILD_TABLE="PersonPhn"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.PhnNbrTyp_Person.Per", FK_COLUMNS="PhnNbrTypID" */
    IF EXISTS (
      SELECT * FROM deleted,Person.PersonPhn
      WHERE
        /*  %JoinFKPK(Person.PersonPhn,deleted," = "," AND") */
        Person.PersonPhn.PhnNbrTypID = deleted.PhnNbrTypID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.PhnNbrTyp because Person.PersonPhn exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tU_PhoneNumberType ON Person.PhnNbrTyp FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on PhnNbrTyp */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPhnNbrTypID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.PhnNbrTyp  Person.PersonPhn on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0001508d", PARENT_OWNER="Person", PARENT_TABLE="PhnNbrTyp"
    CHILD_OWNER="Person", CHILD_TABLE="PersonPhn"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.PhnNbrTyp_Person.Per", FK_COLUMNS="PhnNbrTypID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(PhnNbrTypID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Person.PersonPhn
      WHERE
        /*  %JoinFKPK(Person.PersonPhn,deleted," = "," AND") */
        Person.PersonPhn.PhnNbrTypID = deleted.PhnNbrTypID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.PhnNbrTyp because Person.PersonPhn exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_Product ON Production.Product FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Product */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.Product  Purchasing.PurchaseOrdrDetail on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0017d578", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Purchasi", FK_COLUMNS="ProductID" */
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.PurchaseOrdrDetail
      WHERE
        /*  %JoinFKPK(Purchasing.PurchaseOrdrDetail,deleted," = "," AND") */
        Purchasing.PurchaseOrdrDetail.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Product because Purchasing.PurchaseOrdrDetail exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.WorkOrdr on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.WorkOrdr
      WHERE
        /*  %JoinFKPK(Production.WorkOrdr,deleted," = "," AND") */
        Production.WorkOrdr.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Product because Production.WorkOrdr exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Purchasing.ProductVendor on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Purchasing", CHILD_TABLE="ProductVendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Purchasi", FK_COLUMNS="ProductID" */
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.ProductVendor
      WHERE
        /*  %JoinFKPK(Purchasing.ProductVendor,deleted," = "," AND") */
        Purchasing.ProductVendor.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Product because Purchasing.ProductVendor exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.ProductReview on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductReview"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductReview
      WHERE
        /*  %JoinFKPK(Production.ProductReview,deleted," = "," AND") */
        Production.ProductReview.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Product because Production.ProductReview exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.TransactionHist on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="TransactionHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.TransactionHist
      WHERE
        /*  %JoinFKPK(Production.TransactionHist,deleted," = "," AND") */
        Production.TransactionHist.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Product because Production.TransactionHist exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.ProductProductPhoto on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductProductPhoto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductProductPhoto
      WHERE
        /*  %JoinFKPK(Production.ProductProductPhoto,deleted," = "," AND") */
        Production.ProductProductPhoto.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Product because Production.ProductProductPhoto exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.BillOfMaterials on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="BillOfMaterials"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ComponentID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.BillOfMaterials
      WHERE
        /*  %JoinFKPK(Production.BillOfMaterials,deleted," = "," AND") */
        Production.BillOfMaterials.ComponentID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Product because Production.BillOfMaterials exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.BillOfMaterials on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="BillOfMaterials"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductAssemblyID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.BillOfMaterials
      WHERE
        /*  %JoinFKPK(Production.BillOfMaterials,deleted," = "," AND") */
        Production.BillOfMaterials.ProductAssemblyID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Product because Production.BillOfMaterials exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Sales.SpecialOfferProduct on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Sales", CHILD_TABLE="SpecialOfferProduct"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Sales.Sp", FK_COLUMNS="ProductID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SpecialOfferProduct
      WHERE
        /*  %JoinFKPK(Sales.SpecialOfferProduct,deleted," = "," AND") */
        Sales.SpecialOfferProduct.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Product because Sales.SpecialOfferProduct exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.ProductListPriceHist on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductListPriceHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductListPriceHist
      WHERE
        /*  %JoinFKPK(Production.ProductListPriceHist,deleted," = "," AND") */
        Production.ProductListPriceHist.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Product because Production.ProductListPriceHist exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.ProductInventory on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductInventory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductInventory
      WHERE
        /*  %JoinFKPK(Production.ProductInventory,deleted," = "," AND") */
        Production.ProductInventory.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Product because Production.ProductInventory exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.ProductDocument on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductDocument"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductDocument
      WHERE
        /*  %JoinFKPK(Production.ProductDocument,deleted," = "," AND") */
        Production.ProductDocument.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Product because Production.ProductDocument exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Sales.ShoppingCartitm on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Sales", CHILD_TABLE="ShoppingCartitm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Sales.Sh", FK_COLUMNS="ProductID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.ShoppingCartitm
      WHERE
        /*  %JoinFKPK(Sales.ShoppingCartitm,deleted," = "," AND") */
        Sales.ShoppingCartitm.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Product because Sales.ShoppingCartitm exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.ProductCostHist on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductCostHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductCostHist
      WHERE
        /*  %JoinFKPK(Production.ProductCostHist,deleted," = "," AND") */
        Production.ProductCostHist.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Product because Production.ProductCostHist exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.ProductSubcategory  Production.Product on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ProductSubcategory"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductSubcatego", FK_COLUMNS="ProductSubcategoryID" */
    IF EXISTS (SELECT * FROM deleted,Production.ProductSubcategory
      WHERE
        /* %JoinFKPK(deleted,Production.ProductSubcategory," = "," AND") */
        deleted.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID AND
        NOT EXISTS (
          SELECT * FROM Production.Product
          WHERE
            /* %JoinFKPK(Production.Product,Production.ProductSubcategory," = "," AND") */
            Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.Product because Production.ProductSubcategory exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.ProductModel  Production.Product on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ProductModel"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductModel_Pro", FK_COLUMNS="ProductModelID" */
    IF EXISTS (SELECT * FROM deleted,Production.ProductModel
      WHERE
        /* %JoinFKPK(deleted,Production.ProductModel," = "," AND") */
        deleted.ProductModelID = Production.ProductModel.ProductModelID AND
        NOT EXISTS (
          SELECT * FROM Production.Product
          WHERE
            /* %JoinFKPK(Production.Product,Production.ProductModel," = "," AND") */
            Production.Product.ProductModelID = Production.ProductModel.ProductModelID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.Product because Production.ProductModel exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.UnitMeasure  Production.Product on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Prod", FK_COLUMNS="WeightUnitMeasureCd" */
    IF EXISTS (SELECT * FROM deleted,Production.UnitMeasure
      WHERE
        /* %JoinFKPK(deleted,Production.UnitMeasure," = "," AND") */
        deleted.WeightUnitMeasureCd = Production.UnitMeasure.UnitMeasureCd AND
        NOT EXISTS (
          SELECT * FROM Production.Product
          WHERE
            /* %JoinFKPK(Production.Product,Production.UnitMeasure," = "," AND") */
            Production.Product.WeightUnitMeasureCd = Production.UnitMeasure.UnitMeasureCd
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.Product because Production.UnitMeasure exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.UnitMeasure  Production.Product on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Prod", FK_COLUMNS="SizeUnitMeasureCd" */
    IF EXISTS (SELECT * FROM deleted,Production.UnitMeasure
      WHERE
        /* %JoinFKPK(deleted,Production.UnitMeasure," = "," AND") */
        deleted.SizeUnitMeasureCd = Production.UnitMeasure.UnitMeasureCd AND
        NOT EXISTS (
          SELECT * FROM Production.Product
          WHERE
            /* %JoinFKPK(Production.Product,Production.UnitMeasure," = "," AND") */
            Production.Product.SizeUnitMeasureCd = Production.UnitMeasure.UnitMeasureCd
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.Product because Production.UnitMeasure exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_Product ON Production.Product FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Product */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Product  Purchasing.PurchaseOrdrDetail on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0019bf9f", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Purchasi", FK_COLUMNS="ProductID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.PurchaseOrdrDetail
      WHERE
        /*  %JoinFKPK(Purchasing.PurchaseOrdrDetail,deleted," = "," AND") */
        Purchasing.PurchaseOrdrDetail.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Product because Purchasing.PurchaseOrdrDetail exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Production.WorkOrdr on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.WorkOrdr
      WHERE
        /*  %JoinFKPK(Production.WorkOrdr,deleted," = "," AND") */
        Production.WorkOrdr.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Product because Production.WorkOrdr exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Purchasing.ProductVendor on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Purchasing", CHILD_TABLE="ProductVendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Purchasi", FK_COLUMNS="ProductID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.ProductVendor
      WHERE
        /*  %JoinFKPK(Purchasing.ProductVendor,deleted," = "," AND") */
        Purchasing.ProductVendor.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Product because Purchasing.ProductVendor exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Production.ProductReview on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductReview"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductReview
      WHERE
        /*  %JoinFKPK(Production.ProductReview,deleted," = "," AND") */
        Production.ProductReview.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Product because Production.ProductReview exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Production.TransactionHist on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="TransactionHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.TransactionHist
      WHERE
        /*  %JoinFKPK(Production.TransactionHist,deleted," = "," AND") */
        Production.TransactionHist.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Product because Production.TransactionHist exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Production.ProductProductPhoto on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductProductPhoto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductProductPhoto
      WHERE
        /*  %JoinFKPK(Production.ProductProductPhoto,deleted," = "," AND") */
        Production.ProductProductPhoto.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Product because Production.ProductProductPhoto exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Production.BillOfMaterials on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="BillOfMaterials"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ComponentID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.BillOfMaterials
      WHERE
        /*  %JoinFKPK(Production.BillOfMaterials,deleted," = "," AND") */
        Production.BillOfMaterials.ComponentID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Product because Production.BillOfMaterials exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Production.BillOfMaterials on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="BillOfMaterials"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductAssemblyID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.BillOfMaterials
      WHERE
        /*  %JoinFKPK(Production.BillOfMaterials,deleted," = "," AND") */
        Production.BillOfMaterials.ProductAssemblyID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Product because Production.BillOfMaterials exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Sales.SpecialOfferProduct on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Sales", CHILD_TABLE="SpecialOfferProduct"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Sales.Sp", FK_COLUMNS="ProductID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SpecialOfferProduct
      WHERE
        /*  %JoinFKPK(Sales.SpecialOfferProduct,deleted," = "," AND") */
        Sales.SpecialOfferProduct.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Product because Sales.SpecialOfferProduct exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Production.ProductListPriceHist on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductListPriceHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductListPriceHist
      WHERE
        /*  %JoinFKPK(Production.ProductListPriceHist,deleted," = "," AND") */
        Production.ProductListPriceHist.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Product because Production.ProductListPriceHist exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Production.ProductInventory on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductInventory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductInventory
      WHERE
        /*  %JoinFKPK(Production.ProductInventory,deleted," = "," AND") */
        Production.ProductInventory.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Product because Production.ProductInventory exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Production.ProductDocument on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductDocument"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductDocument
      WHERE
        /*  %JoinFKPK(Production.ProductDocument,deleted," = "," AND") */
        Production.ProductDocument.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Product because Production.ProductDocument exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Sales.ShoppingCartitm on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Sales", CHILD_TABLE="ShoppingCartitm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Sales.Sh", FK_COLUMNS="ProductID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.ShoppingCartitm
      WHERE
        /*  %JoinFKPK(Sales.ShoppingCartitm,deleted," = "," AND") */
        Sales.ShoppingCartitm.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Product because Sales.ShoppingCartitm exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Production.ProductCostHist on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductCostHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductCostHist
      WHERE
        /*  %JoinFKPK(Production.ProductCostHist,deleted," = "," AND") */
        Production.ProductCostHist.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Product because Production.ProductCostHist exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.ProductSubcategory  Production.Product on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ProductSubcategory"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductSubcatego", FK_COLUMNS="ProductSubcategoryID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductSubcategoryID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.ProductSubcategory
        WHERE
          /* %JoinFKPK(inserted,Production.ProductSubcategory) */
          inserted.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.ProductSubcategoryID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.Product because Production.ProductSubcategory does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.ProductModel  Production.Product on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ProductModel"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductModel_Pro", FK_COLUMNS="ProductModelID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductModelID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.ProductModel
        WHERE
          /* %JoinFKPK(inserted,Production.ProductModel) */
          inserted.ProductModelID = Production.ProductModel.ProductModelID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.ProductModelID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.Product because Production.ProductModel does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.UnitMeasure  Production.Product on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Prod", FK_COLUMNS="WeightUnitMeasureCd" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(WeightUnitMeasureCd)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.UnitMeasure
        WHERE
          /* %JoinFKPK(inserted,Production.UnitMeasure) */
          inserted.WeightUnitMeasureCd = Production.UnitMeasure.UnitMeasureCd
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.WeightUnitMeasureCd IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.Product because Production.UnitMeasure does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.UnitMeasure  Production.Product on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Prod", FK_COLUMNS="SizeUnitMeasureCd" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(SizeUnitMeasureCd)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.UnitMeasure
        WHERE
          /* %JoinFKPK(inserted,Production.UnitMeasure) */
          inserted.SizeUnitMeasureCd = Production.UnitMeasure.UnitMeasureCd
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.SizeUnitMeasureCd IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.Product because Production.UnitMeasure does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_SalesTerritoryHistory ON Sales.SlsTerritoryHist FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on SlsTerritoryHist */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.SlsTerritory  Sales.SlsTerritoryHist on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0003356f", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTerritoryHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Sl", FK_COLUMNS="TerritoryID" */
    IF EXISTS (SELECT * FROM deleted,Sales.SlsTerritory
      WHERE
        /* %JoinFKPK(deleted,Sales.SlsTerritory," = "," AND") */
        deleted.TerritoryID = Sales.SlsTerritory.TerritoryID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsTerritoryHist
          WHERE
            /* %JoinFKPK(Sales.SlsTerritoryHist,Sales.SlsTerritory," = "," AND") */
            Sales.SlsTerritoryHist.TerritoryID = Sales.SlsTerritory.TerritoryID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsTerritoryHist because Sales.SlsTerritory exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsPerson  Sales.SlsTerritoryHist on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTerritoryHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_SlsTerritoryHist", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,Sales.SlsPerson
      WHERE
        /* %JoinFKPK(deleted,Sales.SlsPerson," = "," AND") */
        deleted.BusinessEntityID = Sales.SlsPerson.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsTerritoryHist
          WHERE
            /* %JoinFKPK(Sales.SlsTerritoryHist,Sales.SlsPerson," = "," AND") */
            Sales.SlsTerritoryHist.BusinessEntityID = Sales.SlsPerson.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsTerritoryHist because Sales.SlsPerson exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_SalesTerritoryHistory ON Sales.SlsTerritoryHist FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsTerritoryHist */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int, 
           @insTerritoryID int, 
           @insStartDt datetime,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.SlsTerritory  Sales.SlsTerritoryHist on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00032fd3", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTerritoryHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Sl", FK_COLUMNS="TerritoryID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(TerritoryID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.SlsTerritory
        WHERE
          /* %JoinFKPK(inserted,Sales.SlsTerritory) */
          inserted.TerritoryID = Sales.SlsTerritory.TerritoryID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsTerritoryHist because Sales.SlsTerritory does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SlsPerson  Sales.SlsTerritoryHist on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTerritoryHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_SlsTerritoryHist", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.SlsPerson
        WHERE
          /* %JoinFKPK(inserted,Sales.SlsPerson) */
          inserted.BusinessEntityID = Sales.SlsPerson.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsTerritoryHist because Sales.SlsPerson does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_ScrapReason ON Production.ScrapReason FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ScrapReason */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.ScrapReason  Production.WorkOrdr on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000153bc", PARENT_OWNER="Production", PARENT_TABLE="ScrapReason"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ScrapReason_Prod", FK_COLUMNS="ScrapReasonID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.WorkOrdr
      WHERE
        /*  %JoinFKPK(Production.WorkOrdr,deleted," = "," AND") */
        Production.WorkOrdr.ScrapReasonID = deleted.ScrapReasonID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.ScrapReason because Production.WorkOrdr exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_ScrapReason ON Production.ScrapReason FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ScrapReason */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insScrapReasonID smallint,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.ScrapReason  Production.WorkOrdr on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00016e9b", PARENT_OWNER="Production", PARENT_TABLE="ScrapReason"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ScrapReason_Prod", FK_COLUMNS="ScrapReasonID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ScrapReasonID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.WorkOrdr
      WHERE
        /*  %JoinFKPK(Production.WorkOrdr,deleted," = "," AND") */
        Production.WorkOrdr.ScrapReasonID = deleted.ScrapReasonID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.ScrapReason because Production.WorkOrdr exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.tD_Shift ON HumanResources.Shift FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Shift */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* HumanResources.Shift  HumanResources.EmpDepartmentHist on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00015a62", PARENT_OWNER="HumanResources", PARENT_TABLE="Shift"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpDepartmentHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_HumanResources.Shift_HumanR", FK_COLUMNS="ShiftID" */
    IF EXISTS (
      SELECT * FROM deleted,HumanResources.EmpDepartmentHist
      WHERE
        /*  %JoinFKPK(HumanResources.EmpDepartmentHist,deleted," = "," AND") */
        HumanResources.EmpDepartmentHist.ShiftID = deleted.ShiftID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete HumanResources.Shift because HumanResources.EmpDepartmentHist exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.tU_Shift ON HumanResources.Shift FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Shift */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insShiftID tinyint,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* HumanResources.Shift  HumanResources.EmpDepartmentHist on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00018296", PARENT_OWNER="HumanResources", PARENT_TABLE="Shift"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpDepartmentHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_HumanResources.Shift_HumanR", FK_COLUMNS="ShiftID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ShiftID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,HumanResources.EmpDepartmentHist
      WHERE
        /*  %JoinFKPK(HumanResources.EmpDepartmentHist,deleted," = "," AND") */
        HumanResources.EmpDepartmentHist.ShiftID = deleted.ShiftID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update HumanResources.Shift because HumanResources.EmpDepartmentHist exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_ProductCategory ON Production.ProductCategory FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ProductCategory */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.ProductCategory  Production.ProductSubcategory on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00016c26", PARENT_OWNER="Production", PARENT_TABLE="ProductCategory"
    CHILD_OWNER="Production", CHILD_TABLE="ProductSubcategory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductCategory_", FK_COLUMNS="ProductCategoryID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductSubcategory
      WHERE
        /*  %JoinFKPK(Production.ProductSubcategory,deleted," = "," AND") */
        Production.ProductSubcategory.ProductCategoryID = deleted.ProductCategoryID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.ProductCategory because Production.ProductSubcategory exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_ProductCategory ON Production.ProductCategory FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ProductCategory */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductCategoryID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.ProductCategory  Production.ProductSubcategory on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00018f46", PARENT_OWNER="Production", PARENT_TABLE="ProductCategory"
    CHILD_OWNER="Production", CHILD_TABLE="ProductSubcategory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductCategory_", FK_COLUMNS="ProductCategoryID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductCategoryID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductSubcategory
      WHERE
        /*  %JoinFKPK(Production.ProductSubcategory,deleted," = "," AND") */
        Production.ProductSubcategory.ProductCategoryID = deleted.ProductCategoryID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.ProductCategory because Production.ProductSubcategory exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Purchasing.tD_ShipMethod ON Purchasing.ShipMethod FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ShipMethod */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Purchasing.ShipMethod  Sales.SlsOrdrHeader on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000292a2", PARENT_OWNER="Purchasing", PARENT_TABLE="ShipMethod"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchasing.ShipMethod_Sales", FK_COLUMNS="ShipMethodID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.ShipMethodID = deleted.ShipMethodID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Purchasing.ShipMethod because Sales.SlsOrdrHeader exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Purchasing.ShipMethod  Purchasing.PurchaseOrdrHeader on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Purchasing", PARENT_TABLE="ShipMethod"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchasing.ShipMethod_Purch", FK_COLUMNS="ShipMethodID" */
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.PurchaseOrdrHeader
      WHERE
        /*  %JoinFKPK(Purchasing.PurchaseOrdrHeader,deleted," = "," AND") */
        Purchasing.PurchaseOrdrHeader.ShipMethodID = deleted.ShipMethodID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Purchasing.ShipMethod because Purchasing.PurchaseOrdrHeader exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Purchasing.tU_ShipMethod ON Purchasing.ShipMethod FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ShipMethod */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insShipMethodID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Purchasing.ShipMethod  Sales.SlsOrdrHeader on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002d1f9", PARENT_OWNER="Purchasing", PARENT_TABLE="ShipMethod"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchasing.ShipMethod_Sales", FK_COLUMNS="ShipMethodID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ShipMethodID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.ShipMethodID = deleted.ShipMethodID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Purchasing.ShipMethod because Sales.SlsOrdrHeader exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Purchasing.ShipMethod  Purchasing.PurchaseOrdrHeader on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Purchasing", PARENT_TABLE="ShipMethod"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchasing.ShipMethod_Purch", FK_COLUMNS="ShipMethodID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ShipMethodID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.PurchaseOrdrHeader
      WHERE
        /*  %JoinFKPK(Purchasing.PurchaseOrdrHeader,deleted," = "," AND") */
        Purchasing.PurchaseOrdrHeader.ShipMethodID = deleted.ShipMethodID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Purchasing.ShipMethod because Purchasing.PurchaseOrdrHeader exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_ProductCostHistory ON Production.ProductCostHist FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ProductCostHist */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.Product  Production.ProductCostHist on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001a51f", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductCostHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (SELECT * FROM deleted,Production.Product
      WHERE
        /* %JoinFKPK(deleted,Production.Product," = "," AND") */
        deleted.ProductID = Production.Product.ProductID AND
        NOT EXISTS (
          SELECT * FROM Production.ProductCostHist
          WHERE
            /* %JoinFKPK(Production.ProductCostHist,Production.Product," = "," AND") */
            Production.ProductCostHist.ProductID = Production.Product.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductCostHist because Production.Product exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_ProductCostHistory ON Production.ProductCostHist FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ProductCostHist */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductID int, 
           @insStartDt datetime,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Product  Production.ProductCostHist on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000194d1", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductCostHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Product
        WHERE
          /* %JoinFKPK(inserted,Production.Product) */
          inserted.ProductID = Production.Product.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductCostHist because Production.Product does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_ProductDescription ON Production.ProductDesc FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ProductDesc */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.ProductDesc  Production.ProductModelProductDescCulture on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000189ff", PARENT_OWNER="Production", PARENT_TABLE="ProductDesc"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelProductDescCulture"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductDesc_Prod", FK_COLUMNS="ProductDescID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductModelProductDescCulture
      WHERE
        /*  %JoinFKPK(Production.ProductModelProductDescCulture,deleted," = "," AND") */
        Production.ProductModelProductDescCulture.ProductDescID = deleted.ProductDescID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.ProductDesc because Production.ProductModelProductDescCulture exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_ProductDescription ON Production.ProductDesc FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ProductDesc */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductDescID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.ProductDesc  Production.ProductModelProductDescCulture on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0001a516", PARENT_OWNER="Production", PARENT_TABLE="ProductDesc"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelProductDescCulture"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductDesc_Prod", FK_COLUMNS="ProductDescID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductDescID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductModelProductDescCulture
      WHERE
        /*  %JoinFKPK(Production.ProductModelProductDescCulture,deleted," = "," AND") */
        Production.ProductModelProductDescCulture.ProductDescID = deleted.ProductDescID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.ProductDesc because Production.ProductModelProductDescCulture exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_ShoppingCartItem ON Sales.ShoppingCartitm FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ShoppingCartitm */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.Product  Sales.ShoppingCartitm on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001a0c5", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Sales", CHILD_TABLE="ShoppingCartitm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Sales.Sh", FK_COLUMNS="ProductID" */
    IF EXISTS (SELECT * FROM deleted,Production.Product
      WHERE
        /* %JoinFKPK(deleted,Production.Product," = "," AND") */
        deleted.ProductID = Production.Product.ProductID AND
        NOT EXISTS (
          SELECT * FROM Sales.ShoppingCartitm
          WHERE
            /* %JoinFKPK(Sales.ShoppingCartitm,Production.Product," = "," AND") */
            Sales.ShoppingCartitm.ProductID = Production.Product.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.ShoppingCartitm because Production.Product exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_ShoppingCartItem ON Sales.ShoppingCartitm FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ShoppingCartitm */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insShoppingCartitmID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Product  Sales.ShoppingCartitm on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001a59b", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Sales", CHILD_TABLE="ShoppingCartitm"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Sales.Sh", FK_COLUMNS="ProductID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Product
        WHERE
          /* %JoinFKPK(inserted,Production.Product) */
          inserted.ProductID = Production.Product.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.ShoppingCartitm because Production.Product does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_ProductDocument ON Production.ProductDocument FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ProductDocument */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.Document  Production.ProductDocument on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00033bcc", PARENT_OWNER="Production", PARENT_TABLE="Document"
    CHILD_OWNER="Production", CHILD_TABLE="ProductDocument"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Document_Product", FK_COLUMNS="DocumentNode" */
    IF EXISTS (SELECT * FROM deleted,Production.Document
      WHERE
        /* %JoinFKPK(deleted,Production.Document," = "," AND") */
        deleted.DocumentNode = Production.Document.DocumentNode AND
        NOT EXISTS (
          SELECT * FROM Production.ProductDocument
          WHERE
            /* %JoinFKPK(Production.ProductDocument,Production.Document," = "," AND") */
            Production.ProductDocument.DocumentNode = Production.Document.DocumentNode
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductDocument because Production.Document exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.ProductDocument on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductDocument"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (SELECT * FROM deleted,Production.Product
      WHERE
        /* %JoinFKPK(deleted,Production.Product," = "," AND") */
        deleted.ProductID = Production.Product.ProductID AND
        NOT EXISTS (
          SELECT * FROM Production.ProductDocument
          WHERE
            /* %JoinFKPK(Production.ProductDocument,Production.Product," = "," AND") */
            Production.ProductDocument.ProductID = Production.Product.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductDocument because Production.Product exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_ProductDocument ON Production.ProductDocument FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ProductDocument */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductID int, 
           @insDocumentNode hierarchyid,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Document  Production.ProductDocument on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00032995", PARENT_OWNER="Production", PARENT_TABLE="Document"
    CHILD_OWNER="Production", CHILD_TABLE="ProductDocument"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Document_Product", FK_COLUMNS="DocumentNode" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(DocumentNode)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Document
        WHERE
          /* %JoinFKPK(inserted,Production.Document) */
          inserted.DocumentNode = Production.Document.DocumentNode
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductDocument because Production.Document does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Production.ProductDocument on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductDocument"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Product
        WHERE
          /* %JoinFKPK(inserted,Production.Product) */
          inserted.ProductID = Production.Product.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductDocument because Production.Product does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_ProductInventory ON Production.ProductInventory FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ProductInventory */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.Product  Production.ProductInventory on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00033e32", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductInventory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (SELECT * FROM deleted,Production.Product
      WHERE
        /* %JoinFKPK(deleted,Production.Product," = "," AND") */
        deleted.ProductID = Production.Product.ProductID AND
        NOT EXISTS (
          SELECT * FROM Production.ProductInventory
          WHERE
            /* %JoinFKPK(Production.ProductInventory,Production.Product," = "," AND") */
            Production.ProductInventory.ProductID = Production.Product.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductInventory because Production.Product exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Location  Production.ProductInventory on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Location"
    CHILD_OWNER="Production", CHILD_TABLE="ProductInventory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Location_Product", FK_COLUMNS="LocationID" */
    IF EXISTS (SELECT * FROM deleted,Production.Location
      WHERE
        /* %JoinFKPK(deleted,Production.Location," = "," AND") */
        deleted.LocationID = Production.Location.LocationID AND
        NOT EXISTS (
          SELECT * FROM Production.ProductInventory
          WHERE
            /* %JoinFKPK(Production.ProductInventory,Production.Location," = "," AND") */
            Production.ProductInventory.LocationID = Production.Location.LocationID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductInventory because Production.Location exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_ProductInventory ON Production.ProductInventory FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ProductInventory */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductID int, 
           @insLocationID smallint,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Product  Production.ProductInventory on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00032d31", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductInventory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Product
        WHERE
          /* %JoinFKPK(inserted,Production.Product) */
          inserted.ProductID = Production.Product.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductInventory because Production.Product does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Location  Production.ProductInventory on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Location"
    CHILD_OWNER="Production", CHILD_TABLE="ProductInventory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Location_Product", FK_COLUMNS="LocationID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(LocationID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Location
        WHERE
          /* %JoinFKPK(inserted,Production.Location) */
          inserted.LocationID = Production.Location.LocationID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductInventory because Production.Location does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_SpecialOffer ON Sales.SpecialOffer FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on SpecialOffer */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.SpecialOffer  Sales.SpecialOfferProduct on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001487e", PARENT_OWNER="Sales", PARENT_TABLE="SpecialOffer"
    CHILD_OWNER="Sales", CHILD_TABLE="SpecialOfferProduct"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SpecialOffer_Sales.Sp", FK_COLUMNS="SpecialOfferID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SpecialOfferProduct
      WHERE
        /*  %JoinFKPK(Sales.SpecialOfferProduct,deleted," = "," AND") */
        Sales.SpecialOfferProduct.SpecialOfferID = deleted.SpecialOfferID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.SpecialOffer because Sales.SpecialOfferProduct exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_SpecialOffer ON Sales.SpecialOffer FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SpecialOffer */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSpecialOfferID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.SpecialOffer  Sales.SpecialOfferProduct on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0001708b", PARENT_OWNER="Sales", PARENT_TABLE="SpecialOffer"
    CHILD_OWNER="Sales", CHILD_TABLE="SpecialOfferProduct"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SpecialOffer_Sales.Sp", FK_COLUMNS="SpecialOfferID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(SpecialOfferID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SpecialOfferProduct
      WHERE
        /*  %JoinFKPK(Sales.SpecialOfferProduct,deleted," = "," AND") */
        Sales.SpecialOfferProduct.SpecialOfferID = deleted.SpecialOfferID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.SpecialOffer because Sales.SpecialOfferProduct exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_ProductListPriceHistory ON Production.ProductListPriceHist FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ProductListPriceHist */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.Product  Production.ProductListPriceHist on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001a3a8", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductListPriceHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (SELECT * FROM deleted,Production.Product
      WHERE
        /* %JoinFKPK(deleted,Production.Product," = "," AND") */
        deleted.ProductID = Production.Product.ProductID AND
        NOT EXISTS (
          SELECT * FROM Production.ProductListPriceHist
          WHERE
            /* %JoinFKPK(Production.ProductListPriceHist,Production.Product," = "," AND") */
            Production.ProductListPriceHist.ProductID = Production.Product.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductListPriceHist because Production.Product exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_ProductListPriceHistory ON Production.ProductListPriceHist FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ProductListPriceHist */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductID int, 
           @insStartDt datetime,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Product  Production.ProductListPriceHist on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001b096", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductListPriceHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Product
        WHERE
          /* %JoinFKPK(inserted,Production.Product) */
          inserted.ProductID = Production.Product.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductListPriceHist because Production.Product does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tD_Address ON Person.Addr FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Addr */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.Addr  Sales.SlsOrdrHeader on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0004dba4", PARENT_OWNER="Person", PARENT_TABLE="Addr"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.Addr_Sales.SlsOrdrHe", FK_COLUMNS="ShipToAddrID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.ShipToAddrID = deleted.AddrID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.Addr because Sales.SlsOrdrHeader exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Addr  Sales.SlsOrdrHeader on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Addr"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.Addr_Sales.SlsOrdrHe", FK_COLUMNS="BillToAddrID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.BillToAddrID = deleted.AddrID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.Addr because Sales.SlsOrdrHeader exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Addr  Person.BusinessEntityAddr on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Addr"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.Addr_Person.Business", FK_COLUMNS="AddrID" */
    IF EXISTS (
      SELECT * FROM deleted,Person.BusinessEntityAddr
      WHERE
        /*  %JoinFKPK(Person.BusinessEntityAddr,deleted," = "," AND") */
        Person.BusinessEntityAddr.AddrID = deleted.AddrID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.Addr because Person.BusinessEntityAddr exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.StProvince  Person.Addr on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="StProvince"
    CHILD_OWNER="Person", CHILD_TABLE="Addr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.StProvince_Person.Ad", FK_COLUMNS="StProvinceID" */
    IF EXISTS (SELECT * FROM deleted,Person.StProvince
      WHERE
        /* %JoinFKPK(deleted,Person.StProvince," = "," AND") */
        deleted.StProvinceID = Person.StProvince.StProvinceID AND
        NOT EXISTS (
          SELECT * FROM Person.Addr
          WHERE
            /* %JoinFKPK(Person.Addr,Person.StProvince," = "," AND") */
            Person.Addr.StProvinceID = Person.StProvince.StProvinceID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Person.Addr because Person.StProvince exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tU_Address ON Person.Addr FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Addr */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insAddrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.Addr  Sales.SlsOrdrHeader on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0005358e", PARENT_OWNER="Person", PARENT_TABLE="Addr"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.Addr_Sales.SlsOrdrHe", FK_COLUMNS="ShipToAddrID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(AddrID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.ShipToAddrID = deleted.AddrID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.Addr because Sales.SlsOrdrHeader exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.Addr  Sales.SlsOrdrHeader on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Addr"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.Addr_Sales.SlsOrdrHe", FK_COLUMNS="BillToAddrID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(AddrID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.BillToAddrID = deleted.AddrID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.Addr because Sales.SlsOrdrHeader exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.Addr  Person.BusinessEntityAddr on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Addr"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.Addr_Person.Business", FK_COLUMNS="AddrID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(AddrID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Person.BusinessEntityAddr
      WHERE
        /*  %JoinFKPK(Person.BusinessEntityAddr,deleted," = "," AND") */
        Person.BusinessEntityAddr.AddrID = deleted.AddrID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.Addr because Person.BusinessEntityAddr exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.StProvince  Person.Addr on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="StProvince"
    CHILD_OWNER="Person", CHILD_TABLE="Addr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.StProvince_Person.Ad", FK_COLUMNS="StProvinceID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(StProvinceID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.StProvince
        WHERE
          /* %JoinFKPK(inserted,Person.StProvince) */
          inserted.StProvinceID = Person.StProvince.StProvinceID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Person.Addr because Person.StProvince does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_SpecialOfferProduct ON Sales.SpecialOfferProduct FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on SpecialOfferProduct */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.SpecialOfferProduct  Sales.SlsOrdrDetail on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00047253", PARENT_OWNER="Sales", PARENT_TABLE="SpecialOfferProduct"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SpecialOfferProduct_S", FK_COLUMNS="SpecialOfferID""ProductID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrDetail
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrDetail,deleted," = "," AND") */
        Sales.SlsOrdrDetail.SpecialOfferID = deleted.SpecialOfferID AND
        Sales.SlsOrdrDetail.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.SpecialOfferProduct because Sales.SlsOrdrDetail exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SpecialOffer  Sales.SpecialOfferProduct on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SpecialOffer"
    CHILD_OWNER="Sales", CHILD_TABLE="SpecialOfferProduct"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SpecialOffer_Sales.Sp", FK_COLUMNS="SpecialOfferID" */
    IF EXISTS (SELECT * FROM deleted,Sales.SpecialOffer
      WHERE
        /* %JoinFKPK(deleted,Sales.SpecialOffer," = "," AND") */
        deleted.SpecialOfferID = Sales.SpecialOffer.SpecialOfferID AND
        NOT EXISTS (
          SELECT * FROM Sales.SpecialOfferProduct
          WHERE
            /* %JoinFKPK(Sales.SpecialOfferProduct,Sales.SpecialOffer," = "," AND") */
            Sales.SpecialOfferProduct.SpecialOfferID = Sales.SpecialOffer.SpecialOfferID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SpecialOfferProduct because Sales.SpecialOffer exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Sales.SpecialOfferProduct on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Sales", CHILD_TABLE="SpecialOfferProduct"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Sales.Sp", FK_COLUMNS="ProductID" */
    IF EXISTS (SELECT * FROM deleted,Production.Product
      WHERE
        /* %JoinFKPK(deleted,Production.Product," = "," AND") */
        deleted.ProductID = Production.Product.ProductID AND
        NOT EXISTS (
          SELECT * FROM Sales.SpecialOfferProduct
          WHERE
            /* %JoinFKPK(Sales.SpecialOfferProduct,Production.Product," = "," AND") */
            Sales.SpecialOfferProduct.ProductID = Production.Product.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SpecialOfferProduct because Production.Product exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_SpecialOfferProduct ON Sales.SpecialOfferProduct FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SpecialOfferProduct */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSpecialOfferID int, 
           @insProductID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.SpecialOfferProduct  Sales.SlsOrdrDetail on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0004a569", PARENT_OWNER="Sales", PARENT_TABLE="SpecialOfferProduct"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SpecialOfferProduct_S", FK_COLUMNS="SpecialOfferID""ProductID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(SpecialOfferID) OR
    UPDATE(ProductID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrDetail
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrDetail,deleted," = "," AND") */
        Sales.SlsOrdrDetail.SpecialOfferID = deleted.SpecialOfferID AND
        Sales.SlsOrdrDetail.ProductID = deleted.ProductID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.SpecialOfferProduct because Sales.SlsOrdrDetail exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SpecialOffer  Sales.SpecialOfferProduct on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SpecialOffer"
    CHILD_OWNER="Sales", CHILD_TABLE="SpecialOfferProduct"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SpecialOffer_Sales.Sp", FK_COLUMNS="SpecialOfferID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(SpecialOfferID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.SpecialOffer
        WHERE
          /* %JoinFKPK(inserted,Sales.SpecialOffer) */
          inserted.SpecialOfferID = Sales.SpecialOffer.SpecialOfferID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SpecialOfferProduct because Sales.SpecialOffer does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Sales.SpecialOfferProduct on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Sales", CHILD_TABLE="SpecialOfferProduct"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Sales.Sp", FK_COLUMNS="ProductID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Product
        WHERE
          /* %JoinFKPK(inserted,Production.Product) */
          inserted.ProductID = Production.Product.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SpecialOfferProduct because Production.Product does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_ProductModel ON Production.ProductModel FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ProductModel */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.ProductModel  Production.ProductModelProductDescCulture on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000410f1", PARENT_OWNER="Production", PARENT_TABLE="ProductModel"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelProductDescCulture"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductModel_Pro", FK_COLUMNS="ProductModelID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductModelProductDescCulture
      WHERE
        /*  %JoinFKPK(Production.ProductModelProductDescCulture,deleted," = "," AND") */
        Production.ProductModelProductDescCulture.ProductModelID = deleted.ProductModelID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.ProductModel because Production.ProductModelProductDescCulture exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.ProductModel  Production.ProductModelIllustration on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ProductModel"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelIllustration"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductModel_Pro", FK_COLUMNS="ProductModelID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductModelIllustration
      WHERE
        /*  %JoinFKPK(Production.ProductModelIllustration,deleted," = "," AND") */
        Production.ProductModelIllustration.ProductModelID = deleted.ProductModelID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.ProductModel because Production.ProductModelIllustration exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.ProductModel  Production.Product on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ProductModel"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductModel_Pro", FK_COLUMNS="ProductModelID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.Product
      WHERE
        /*  %JoinFKPK(Production.Product,deleted," = "," AND") */
        Production.Product.ProductModelID = deleted.ProductModelID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.ProductModel because Production.Product exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_ProductModel ON Production.ProductModel FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ProductModel */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductModelID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.ProductModel  Production.ProductModelProductDescCulture on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000477db", PARENT_OWNER="Production", PARENT_TABLE="ProductModel"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelProductDescCulture"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductModel_Pro", FK_COLUMNS="ProductModelID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductModelID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductModelProductDescCulture
      WHERE
        /*  %JoinFKPK(Production.ProductModelProductDescCulture,deleted," = "," AND") */
        Production.ProductModelProductDescCulture.ProductModelID = deleted.ProductModelID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.ProductModel because Production.ProductModelProductDescCulture exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.ProductModel  Production.ProductModelIllustration on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ProductModel"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelIllustration"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductModel_Pro", FK_COLUMNS="ProductModelID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductModelID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductModelIllustration
      WHERE
        /*  %JoinFKPK(Production.ProductModelIllustration,deleted," = "," AND") */
        Production.ProductModelIllustration.ProductModelID = deleted.ProductModelID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.ProductModel because Production.ProductModelIllustration exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.ProductModel  Production.Product on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ProductModel"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductModel_Pro", FK_COLUMNS="ProductModelID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductModelID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.Product
      WHERE
        /*  %JoinFKPK(Production.Product,deleted," = "," AND") */
        Production.Product.ProductModelID = deleted.ProductModelID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.ProductModel because Production.Product exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tD_AddressType ON Person.AddrTyp FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on AddrTyp */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.AddrTyp  Person.BusinessEntityAddr on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000147f9", PARENT_OWNER="Person", PARENT_TABLE="AddrTyp"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.AddrTyp_Person.Busin", FK_COLUMNS="AddrTypID" */
    IF EXISTS (
      SELECT * FROM deleted,Person.BusinessEntityAddr
      WHERE
        /*  %JoinFKPK(Person.BusinessEntityAddr,deleted," = "," AND") */
        Person.BusinessEntityAddr.AddrTypID = deleted.AddrTypID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.AddrTyp because Person.BusinessEntityAddr exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tU_AddressType ON Person.AddrTyp FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on AddrTyp */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insAddrTypID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.AddrTyp  Person.BusinessEntityAddr on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00015fb5", PARENT_OWNER="Person", PARENT_TABLE="AddrTyp"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.AddrTyp_Person.Busin", FK_COLUMNS="AddrTypID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(AddrTypID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Person.BusinessEntityAddr
      WHERE
        /*  %JoinFKPK(Person.BusinessEntityAddr,deleted," = "," AND") */
        Person.BusinessEntityAddr.AddrTypID = deleted.AddrTypID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.AddrTyp because Person.BusinessEntityAddr exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tD_StateProvince ON Person.StProvince FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on StProvince */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.StProvince  Person.Addr on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000542b1", PARENT_OWNER="Person", PARENT_TABLE="StProvince"
    CHILD_OWNER="Person", CHILD_TABLE="Addr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.StProvince_Person.Ad", FK_COLUMNS="StProvinceID" */
    IF EXISTS (
      SELECT * FROM deleted,Person.Addr
      WHERE
        /*  %JoinFKPK(Person.Addr,deleted," = "," AND") */
        Person.Addr.StProvinceID = deleted.StProvinceID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.StProvince because Person.Addr exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.StProvince  Sales.SlsTaxRate on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="StProvince"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTaxRate"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.StProvince_Sales.Sls", FK_COLUMNS="StProvinceID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsTaxRate
      WHERE
        /*  %JoinFKPK(Sales.SlsTaxRate,deleted," = "," AND") */
        Sales.SlsTaxRate.StProvinceID = deleted.StProvinceID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.StProvince because Sales.SlsTaxRate exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsTerritory  Person.StProvince on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Person", CHILD_TABLE="StProvince"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Person.S", FK_COLUMNS="TerritoryID" */
    IF EXISTS (SELECT * FROM deleted,Sales.SlsTerritory
      WHERE
        /* %JoinFKPK(deleted,Sales.SlsTerritory," = "," AND") */
        deleted.TerritoryID = Sales.SlsTerritory.TerritoryID AND
        NOT EXISTS (
          SELECT * FROM Person.StProvince
          WHERE
            /* %JoinFKPK(Person.StProvince,Sales.SlsTerritory," = "," AND") */
            Person.StProvince.TerritoryID = Sales.SlsTerritory.TerritoryID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Person.StProvince because Sales.SlsTerritory exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.CountryRgn  Person.StProvince on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="CountryRgn"
    CHILD_OWNER="Person", CHILD_TABLE="StProvince"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.CountryRgn_Person.St", FK_COLUMNS="CountryRgnCd" */
    IF EXISTS (SELECT * FROM deleted,Person.CountryRgn
      WHERE
        /* %JoinFKPK(deleted,Person.CountryRgn," = "," AND") */
        deleted.CountryRgnCd = Person.CountryRgn.CountryRgnCd AND
        NOT EXISTS (
          SELECT * FROM Person.StProvince
          WHERE
            /* %JoinFKPK(Person.StProvince,Person.CountryRgn," = "," AND") */
            Person.StProvince.CountryRgnCd = Person.CountryRgn.CountryRgnCd
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Person.StProvince because Person.CountryRgn exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tU_StateProvince ON Person.StProvince FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on StProvince */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insStProvinceID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.StProvince  Person.Addr on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00059df0", PARENT_OWNER="Person", PARENT_TABLE="StProvince"
    CHILD_OWNER="Person", CHILD_TABLE="Addr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.StProvince_Person.Ad", FK_COLUMNS="StProvinceID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(StProvinceID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Person.Addr
      WHERE
        /*  %JoinFKPK(Person.Addr,deleted," = "," AND") */
        Person.Addr.StProvinceID = deleted.StProvinceID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.StProvince because Person.Addr exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.StProvince  Sales.SlsTaxRate on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="StProvince"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTaxRate"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.StProvince_Sales.Sls", FK_COLUMNS="StProvinceID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(StProvinceID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsTaxRate
      WHERE
        /*  %JoinFKPK(Sales.SlsTaxRate,deleted," = "," AND") */
        Sales.SlsTaxRate.StProvinceID = deleted.StProvinceID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.StProvince because Sales.SlsTaxRate exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SlsTerritory  Person.StProvince on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Person", CHILD_TABLE="StProvince"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Person.S", FK_COLUMNS="TerritoryID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(TerritoryID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.SlsTerritory
        WHERE
          /* %JoinFKPK(inserted,Sales.SlsTerritory) */
          inserted.TerritoryID = Sales.SlsTerritory.TerritoryID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Person.StProvince because Sales.SlsTerritory does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.CountryRgn  Person.StProvince on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="CountryRgn"
    CHILD_OWNER="Person", CHILD_TABLE="StProvince"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.CountryRgn_Person.St", FK_COLUMNS="CountryRgnCd" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CountryRgnCd)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.CountryRgn
        WHERE
          /* %JoinFKPK(inserted,Person.CountryRgn) */
          inserted.CountryRgnCd = Person.CountryRgn.CountryRgnCd
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Person.StProvince because Person.CountryRgn does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_ProductModelIllustration ON Production.ProductModelIllustration FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ProductModelIllustration */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.Illustration  Production.ProductModelIllustration on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00039588", PARENT_OWNER="Production", PARENT_TABLE="Illustration"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelIllustration"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Illustration_Pro", FK_COLUMNS="IllustrationID" */
    IF EXISTS (SELECT * FROM deleted,Production.Illustration
      WHERE
        /* %JoinFKPK(deleted,Production.Illustration," = "," AND") */
        deleted.IllustrationID = Production.Illustration.IllustrationID AND
        NOT EXISTS (
          SELECT * FROM Production.ProductModelIllustration
          WHERE
            /* %JoinFKPK(Production.ProductModelIllustration,Production.Illustration," = "," AND") */
            Production.ProductModelIllustration.IllustrationID = Production.Illustration.IllustrationID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductModelIllustration because Production.Illustration exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.ProductModel  Production.ProductModelIllustration on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ProductModel"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelIllustration"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductModel_Pro", FK_COLUMNS="ProductModelID" */
    IF EXISTS (SELECT * FROM deleted,Production.ProductModel
      WHERE
        /* %JoinFKPK(deleted,Production.ProductModel," = "," AND") */
        deleted.ProductModelID = Production.ProductModel.ProductModelID AND
        NOT EXISTS (
          SELECT * FROM Production.ProductModelIllustration
          WHERE
            /* %JoinFKPK(Production.ProductModelIllustration,Production.ProductModel," = "," AND") */
            Production.ProductModelIllustration.ProductModelID = Production.ProductModel.ProductModelID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductModelIllustration because Production.ProductModel exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_ProductModelIllustration ON Production.ProductModelIllustration FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ProductModelIllustration */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductModelID int, 
           @insIllustrationID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Illustration  Production.ProductModelIllustration on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00036196", PARENT_OWNER="Production", PARENT_TABLE="Illustration"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelIllustration"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Illustration_Pro", FK_COLUMNS="IllustrationID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IllustrationID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Illustration
        WHERE
          /* %JoinFKPK(inserted,Production.Illustration) */
          inserted.IllustrationID = Production.Illustration.IllustrationID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductModelIllustration because Production.Illustration does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.ProductModel  Production.ProductModelIllustration on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ProductModel"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelIllustration"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductModel_Pro", FK_COLUMNS="ProductModelID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductModelID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.ProductModel
        WHERE
          /* %JoinFKPK(inserted,Production.ProductModel) */
          inserted.ProductModelID = Production.ProductModel.ProductModelID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductModelIllustration because Production.ProductModel does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_ProductModelProductDescriptionCulture ON Production.ProductModelProductDescCulture FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ProductModelProductDescCulture */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.ProductModel  Production.ProductModelProductDescCulture on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000578e3", PARENT_OWNER="Production", PARENT_TABLE="ProductModel"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelProductDescCulture"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductModel_Pro", FK_COLUMNS="ProductModelID" */
    IF EXISTS (SELECT * FROM deleted,Production.ProductModel
      WHERE
        /* %JoinFKPK(deleted,Production.ProductModel," = "," AND") */
        deleted.ProductModelID = Production.ProductModel.ProductModelID AND
        NOT EXISTS (
          SELECT * FROM Production.ProductModelProductDescCulture
          WHERE
            /* %JoinFKPK(Production.ProductModelProductDescCulture,Production.ProductModel," = "," AND") */
            Production.ProductModelProductDescCulture.ProductModelID = Production.ProductModel.ProductModelID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductModelProductDescCulture because Production.ProductModel exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Culture  Production.ProductModelProductDescCulture on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Culture"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelProductDescCulture"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Culture_Producti", FK_COLUMNS="CultureID" */
    IF EXISTS (SELECT * FROM deleted,Production.Culture
      WHERE
        /* %JoinFKPK(deleted,Production.Culture," = "," AND") */
        deleted.CultureID = Production.Culture.CultureID AND
        NOT EXISTS (
          SELECT * FROM Production.ProductModelProductDescCulture
          WHERE
            /* %JoinFKPK(Production.ProductModelProductDescCulture,Production.Culture," = "," AND") */
            Production.ProductModelProductDescCulture.CultureID = Production.Culture.CultureID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductModelProductDescCulture because Production.Culture exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.ProductDesc  Production.ProductModelProductDescCulture on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ProductDesc"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelProductDescCulture"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductDesc_Prod", FK_COLUMNS="ProductDescID" */
    IF EXISTS (SELECT * FROM deleted,Production.ProductDesc
      WHERE
        /* %JoinFKPK(deleted,Production.ProductDesc," = "," AND") */
        deleted.ProductDescID = Production.ProductDesc.ProductDescID AND
        NOT EXISTS (
          SELECT * FROM Production.ProductModelProductDescCulture
          WHERE
            /* %JoinFKPK(Production.ProductModelProductDescCulture,Production.ProductDesc," = "," AND") */
            Production.ProductModelProductDescCulture.ProductDescID = Production.ProductDesc.ProductDescID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductModelProductDescCulture because Production.ProductDesc exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_ProductModelProductDescriptionCulture ON Production.ProductModelProductDescCulture FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ProductModelProductDescCulture */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductModelID int, 
           @insProductDescID int, 
           @insCultureID nchar(6),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.ProductModel  Production.ProductModelProductDescCulture on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000524c3", PARENT_OWNER="Production", PARENT_TABLE="ProductModel"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelProductDescCulture"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductModel_Pro", FK_COLUMNS="ProductModelID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductModelID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.ProductModel
        WHERE
          /* %JoinFKPK(inserted,Production.ProductModel) */
          inserted.ProductModelID = Production.ProductModel.ProductModelID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductModelProductDescCulture because Production.ProductModel does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Culture  Production.ProductModelProductDescCulture on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Culture"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelProductDescCulture"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Culture_Producti", FK_COLUMNS="CultureID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CultureID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Culture
        WHERE
          /* %JoinFKPK(inserted,Production.Culture) */
          inserted.CultureID = Production.Culture.CultureID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductModelProductDescCulture because Production.Culture does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.ProductDesc  Production.ProductModelProductDescCulture on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ProductDesc"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelProductDescCulture"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductDesc_Prod", FK_COLUMNS="ProductDescID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductDescID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.ProductDesc
        WHERE
          /* %JoinFKPK(inserted,Production.ProductDesc) */
          inserted.ProductDescID = Production.ProductDesc.ProductDescID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductModelProductDescCulture because Production.ProductDesc does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_BillOfMaterials ON Production.BillOfMaterials FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on BillOfMaterials */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.UnitMeasure  Production.BillOfMaterials on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000501d8", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Production", CHILD_TABLE="BillOfMaterials"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Prod", FK_COLUMNS="UnitMeasureCd" */
    IF EXISTS (SELECT * FROM deleted,Production.UnitMeasure
      WHERE
        /* %JoinFKPK(deleted,Production.UnitMeasure," = "," AND") */
        deleted.UnitMeasureCd = Production.UnitMeasure.UnitMeasureCd AND
        NOT EXISTS (
          SELECT * FROM Production.BillOfMaterials
          WHERE
            /* %JoinFKPK(Production.BillOfMaterials,Production.UnitMeasure," = "," AND") */
            Production.BillOfMaterials.UnitMeasureCd = Production.UnitMeasure.UnitMeasureCd
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.BillOfMaterials because Production.UnitMeasure exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.BillOfMaterials on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="BillOfMaterials"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ComponentID" */
    IF EXISTS (SELECT * FROM deleted,Production.Product
      WHERE
        /* %JoinFKPK(deleted,Production.Product," = "," AND") */
        deleted.ComponentID = Production.Product.ProductID AND
        NOT EXISTS (
          SELECT * FROM Production.BillOfMaterials
          WHERE
            /* %JoinFKPK(Production.BillOfMaterials,Production.Product," = "," AND") */
            Production.BillOfMaterials.ComponentID = Production.Product.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.BillOfMaterials because Production.Product exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.BillOfMaterials on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="BillOfMaterials"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductAssemblyID" */
    IF EXISTS (SELECT * FROM deleted,Production.Product
      WHERE
        /* %JoinFKPK(deleted,Production.Product," = "," AND") */
        deleted.ProductAssemblyID = Production.Product.ProductID AND
        NOT EXISTS (
          SELECT * FROM Production.BillOfMaterials
          WHERE
            /* %JoinFKPK(Production.BillOfMaterials,Production.Product," = "," AND") */
            Production.BillOfMaterials.ProductAssemblyID = Production.Product.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.BillOfMaterials because Production.Product exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_BillOfMaterials ON Production.BillOfMaterials FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on BillOfMaterials */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBillOfMaterialsID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.UnitMeasure  Production.BillOfMaterials on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0004ff1c", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Production", CHILD_TABLE="BillOfMaterials"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Prod", FK_COLUMNS="UnitMeasureCd" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(UnitMeasureCd)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.UnitMeasure
        WHERE
          /* %JoinFKPK(inserted,Production.UnitMeasure) */
          inserted.UnitMeasureCd = Production.UnitMeasure.UnitMeasureCd
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.BillOfMaterials because Production.UnitMeasure does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Production.BillOfMaterials on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="BillOfMaterials"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ComponentID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ComponentID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Product
        WHERE
          /* %JoinFKPK(inserted,Production.Product) */
          inserted.ComponentID = Production.Product.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.BillOfMaterials because Production.Product does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Production.BillOfMaterials on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="BillOfMaterials"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductAssemblyID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductAssemblyID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Product
        WHERE
          /* %JoinFKPK(inserted,Production.Product) */
          inserted.ProductAssemblyID = Production.Product.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.ProductAssemblyID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.BillOfMaterials because Production.Product does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_Store ON Sales.Stor FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Stor */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.Stor  Sales.Cust on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0003d58e", PARENT_OWNER="Sales", PARENT_TABLE="Stor"
    CHILD_OWNER="Sales", CHILD_TABLE="Cust"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Stor_Cust", FK_COLUMNS="StorID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.Cust
      WHERE
        /*  %JoinFKPK(Sales.Cust,deleted," = "," AND") */
        Sales.Cust.StorID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.Stor because Sales.Cust exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsPerson  Sales.Stor on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="Stor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_Stor", FK_COLUMNS="SlsPersonID" */
    IF EXISTS (SELECT * FROM deleted,Sales.SlsPerson
      WHERE
        /* %JoinFKPK(deleted,Sales.SlsPerson," = "," AND") */
        deleted.SlsPersonID = Sales.SlsPerson.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Sales.Stor
          WHERE
            /* %JoinFKPK(Sales.Stor,Sales.SlsPerson," = "," AND") */
            Sales.Stor.SlsPersonID = Sales.SlsPerson.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.Stor because Sales.SlsPerson exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.BusinessEntity  Sales.Stor on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Sales", CHILD_TABLE="Stor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_Stor", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,Person.BusinessEntity
      WHERE
        /* %JoinFKPK(deleted,Person.BusinessEntity," = "," AND") */
        deleted.BusinessEntityID = Person.BusinessEntity.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Sales.Stor
          WHERE
            /* %JoinFKPK(Sales.Stor,Person.BusinessEntity," = "," AND") */
            Sales.Stor.BusinessEntityID = Person.BusinessEntity.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.Stor because Person.BusinessEntity exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_Store ON Sales.Stor FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Stor */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.Stor  Sales.Cust on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000456b7", PARENT_OWNER="Sales", PARENT_TABLE="Stor"
    CHILD_OWNER="Sales", CHILD_TABLE="Cust"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Stor_Cust", FK_COLUMNS="StorID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.Cust
      WHERE
        /*  %JoinFKPK(Sales.Cust,deleted," = "," AND") */
        Sales.Cust.StorID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.Stor because Sales.Cust exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SlsPerson  Sales.Stor on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="Stor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_Stor", FK_COLUMNS="SlsPersonID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(SlsPersonID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.SlsPerson
        WHERE
          /* %JoinFKPK(inserted,Sales.SlsPerson) */
          inserted.SlsPersonID = Sales.SlsPerson.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.SlsPersonID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.Stor because Sales.SlsPerson does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.BusinessEntity  Sales.Stor on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Sales", CHILD_TABLE="Stor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_Stor", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.BusinessEntity
        WHERE
          /* %JoinFKPK(inserted,Person.BusinessEntity) */
          inserted.BusinessEntityID = Person.BusinessEntity.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.Stor because Person.BusinessEntity does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_ProductPhoto ON Production.ProductPhoto FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ProductPhoto */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.ProductPhoto  Production.ProductProductPhoto on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00016708", PARENT_OWNER="Production", PARENT_TABLE="ProductPhoto"
    CHILD_OWNER="Production", CHILD_TABLE="ProductProductPhoto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductPhoto_Pro", FK_COLUMNS="ProductPhotoID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductProductPhoto
      WHERE
        /*  %JoinFKPK(Production.ProductProductPhoto,deleted," = "," AND") */
        Production.ProductProductPhoto.ProductPhotoID = deleted.ProductPhotoID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.ProductPhoto because Production.ProductProductPhoto exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_ProductPhoto ON Production.ProductPhoto FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ProductPhoto */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductPhotoID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.ProductPhoto  Production.ProductProductPhoto on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000181f4", PARENT_OWNER="Production", PARENT_TABLE="ProductPhoto"
    CHILD_OWNER="Production", CHILD_TABLE="ProductProductPhoto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductPhoto_Pro", FK_COLUMNS="ProductPhotoID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductPhotoID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductProductPhoto
      WHERE
        /*  %JoinFKPK(Production.ProductProductPhoto,deleted," = "," AND") */
        Production.ProductProductPhoto.ProductPhotoID = deleted.ProductPhotoID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.ProductPhoto because Production.ProductProductPhoto exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_ProductProductPhoto ON Production.ProductProductPhoto FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ProductProductPhoto */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.ProductPhoto  Production.ProductProductPhoto on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0003646d", PARENT_OWNER="Production", PARENT_TABLE="ProductPhoto"
    CHILD_OWNER="Production", CHILD_TABLE="ProductProductPhoto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductPhoto_Pro", FK_COLUMNS="ProductPhotoID" */
    IF EXISTS (SELECT * FROM deleted,Production.ProductPhoto
      WHERE
        /* %JoinFKPK(deleted,Production.ProductPhoto," = "," AND") */
        deleted.ProductPhotoID = Production.ProductPhoto.ProductPhotoID AND
        NOT EXISTS (
          SELECT * FROM Production.ProductProductPhoto
          WHERE
            /* %JoinFKPK(Production.ProductProductPhoto,Production.ProductPhoto," = "," AND") */
            Production.ProductProductPhoto.ProductPhotoID = Production.ProductPhoto.ProductPhotoID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductProductPhoto because Production.ProductPhoto exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.ProductProductPhoto on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductProductPhoto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (SELECT * FROM deleted,Production.Product
      WHERE
        /* %JoinFKPK(deleted,Production.Product," = "," AND") */
        deleted.ProductID = Production.Product.ProductID AND
        NOT EXISTS (
          SELECT * FROM Production.ProductProductPhoto
          WHERE
            /* %JoinFKPK(Production.ProductProductPhoto,Production.Product," = "," AND") */
            Production.ProductProductPhoto.ProductID = Production.Product.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductProductPhoto because Production.Product exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_ProductProductPhoto ON Production.ProductProductPhoto FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ProductProductPhoto */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductID int, 
           @insProductPhotoID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.ProductPhoto  Production.ProductProductPhoto on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000346d2", PARENT_OWNER="Production", PARENT_TABLE="ProductPhoto"
    CHILD_OWNER="Production", CHILD_TABLE="ProductProductPhoto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductPhoto_Pro", FK_COLUMNS="ProductPhotoID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductPhotoID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.ProductPhoto
        WHERE
          /* %JoinFKPK(inserted,Production.ProductPhoto) */
          inserted.ProductPhotoID = Production.ProductPhoto.ProductPhotoID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductProductPhoto because Production.ProductPhoto does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Production.ProductProductPhoto on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductProductPhoto"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Product
        WHERE
          /* %JoinFKPK(inserted,Production.Product) */
          inserted.ProductID = Production.Product.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductProductPhoto because Production.Product does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_TransactionHistory ON Production.TransactionHist FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on TransactionHist */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.Product  Production.TransactionHist on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001a1c8", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="TransactionHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (SELECT * FROM deleted,Production.Product
      WHERE
        /* %JoinFKPK(deleted,Production.Product," = "," AND") */
        deleted.ProductID = Production.Product.ProductID AND
        NOT EXISTS (
          SELECT * FROM Production.TransactionHist
          WHERE
            /* %JoinFKPK(Production.TransactionHist,Production.Product," = "," AND") */
            Production.TransactionHist.ProductID = Production.Product.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.TransactionHist because Production.Product exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_TransactionHistory ON Production.TransactionHist FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on TransactionHist */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insTransactionID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Product  Production.TransactionHist on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001a201", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="TransactionHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Product
        WHERE
          /* %JoinFKPK(inserted,Production.Product) */
          inserted.ProductID = Production.Product.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.TransactionHist because Production.Product does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_ProductReview ON Production.ProductReview FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ProductReview */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.Product  Production.ProductReview on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001a7b9", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductReview"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (SELECT * FROM deleted,Production.Product
      WHERE
        /* %JoinFKPK(deleted,Production.Product," = "," AND") */
        deleted.ProductID = Production.Product.ProductID AND
        NOT EXISTS (
          SELECT * FROM Production.ProductReview
          WHERE
            /* %JoinFKPK(Production.ProductReview,Production.Product," = "," AND") */
            Production.ProductReview.ProductID = Production.Product.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductReview because Production.Product exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_ProductReview ON Production.ProductReview FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ProductReview */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductReviewID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Product  Production.ProductReview on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001988c", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="ProductReview"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Product
        WHERE
          /* %JoinFKPK(inserted,Production.Product) */
          inserted.ProductID = Production.Product.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductReview because Production.Product does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tD_BusinessEntity ON Person.BusinessEntity FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on BusinessEntity */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.BusinessEntity  Purchasing.Vendor on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00061f36", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Purchasing", CHILD_TABLE="Vendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_Vendor", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.Vendor
      WHERE
        /*  %JoinFKPK(Purchasing.Vendor,deleted," = "," AND") */
        Purchasing.Vendor.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.BusinessEntity because Purchasing.Vendor exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.BusinessEntity  Person.BusinessEntityContact on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityContact"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_BusinessEnti", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,Person.BusinessEntityContact
      WHERE
        /*  %JoinFKPK(Person.BusinessEntityContact,deleted," = "," AND") */
        Person.BusinessEntityContact.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.BusinessEntity because Person.BusinessEntityContact exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.BusinessEntity  Person.BusinessEntityAddr on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_BusinessEnti", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,Person.BusinessEntityAddr
      WHERE
        /*  %JoinFKPK(Person.BusinessEntityAddr,deleted," = "," AND") */
        Person.BusinessEntityAddr.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.BusinessEntity because Person.BusinessEntityAddr exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.BusinessEntity  Sales.Stor on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Sales", CHILD_TABLE="Stor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_Stor", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.Stor
      WHERE
        /*  %JoinFKPK(Sales.Stor,deleted," = "," AND") */
        Sales.Stor.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.BusinessEntity because Sales.Stor exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.BusinessEntity  Person.Person on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Person", CHILD_TABLE="Person"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_Person", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,Person.Person
      WHERE
        /*  %JoinFKPK(Person.Person,deleted," = "," AND") */
        Person.Person.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.BusinessEntity because Person.Person exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tU_BusinessEntity ON Person.BusinessEntity FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on BusinessEntity */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.BusinessEntity  Purchasing.Vendor on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0006944e", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Purchasing", CHILD_TABLE="Vendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_Vendor", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.Vendor
      WHERE
        /*  %JoinFKPK(Purchasing.Vendor,deleted," = "," AND") */
        Purchasing.Vendor.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.BusinessEntity because Purchasing.Vendor exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.BusinessEntity  Person.BusinessEntityContact on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityContact"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_BusinessEnti", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Person.BusinessEntityContact
      WHERE
        /*  %JoinFKPK(Person.BusinessEntityContact,deleted," = "," AND") */
        Person.BusinessEntityContact.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.BusinessEntity because Person.BusinessEntityContact exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.BusinessEntity  Person.BusinessEntityAddr on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_BusinessEnti", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Person.BusinessEntityAddr
      WHERE
        /*  %JoinFKPK(Person.BusinessEntityAddr,deleted," = "," AND") */
        Person.BusinessEntityAddr.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.BusinessEntity because Person.BusinessEntityAddr exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.BusinessEntity  Sales.Stor on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Sales", CHILD_TABLE="Stor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_Stor", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.Stor
      WHERE
        /*  %JoinFKPK(Sales.Stor,deleted," = "," AND") */
        Sales.Stor.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.BusinessEntity because Sales.Stor exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.BusinessEntity  Person.Person on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Person", CHILD_TABLE="Person"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_Person", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Person.Person
      WHERE
        /*  %JoinFKPK(Person.Person,deleted," = "," AND") */
        Person.Person.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.BusinessEntity because Person.Person exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_ProductSubcategory ON Production.ProductSubcategory FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ProductSubcategory */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.ProductSubcategory  Production.Product on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00030957", PARENT_OWNER="Production", PARENT_TABLE="ProductSubcategory"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductSubcatego", FK_COLUMNS="ProductSubcategoryID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.Product
      WHERE
        /*  %JoinFKPK(Production.Product,deleted," = "," AND") */
        Production.Product.ProductSubcategoryID = deleted.ProductSubcategoryID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.ProductSubcategory because Production.Product exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.ProductCategory  Production.ProductSubcategory on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ProductCategory"
    CHILD_OWNER="Production", CHILD_TABLE="ProductSubcategory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductCategory_", FK_COLUMNS="ProductCategoryID" */
    IF EXISTS (SELECT * FROM deleted,Production.ProductCategory
      WHERE
        /* %JoinFKPK(deleted,Production.ProductCategory," = "," AND") */
        deleted.ProductCategoryID = Production.ProductCategory.ProductCategoryID AND
        NOT EXISTS (
          SELECT * FROM Production.ProductSubcategory
          WHERE
            /* %JoinFKPK(Production.ProductSubcategory,Production.ProductCategory," = "," AND") */
            Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.ProductSubcategory because Production.ProductCategory exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_ProductSubcategory ON Production.ProductSubcategory FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ProductSubcategory */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductSubcategoryID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.ProductSubcategory  Production.Product on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00031021", PARENT_OWNER="Production", PARENT_TABLE="ProductSubcategory"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductSubcatego", FK_COLUMNS="ProductSubcategoryID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ProductSubcategoryID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.Product
      WHERE
        /*  %JoinFKPK(Production.Product,deleted," = "," AND") */
        Production.Product.ProductSubcategoryID = deleted.ProductSubcategoryID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.ProductSubcategory because Production.Product exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.ProductCategory  Production.ProductSubcategory on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ProductCategory"
    CHILD_OWNER="Production", CHILD_TABLE="ProductSubcategory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ProductCategory_", FK_COLUMNS="ProductCategoryID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductCategoryID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.ProductCategory
        WHERE
          /* %JoinFKPK(inserted,Production.ProductCategory) */
          inserted.ProductCategoryID = Production.ProductCategory.ProductCategoryID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.ProductSubcategory because Production.ProductCategory does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tD_BusinessEntityAddress ON Person.BusinessEntityAddr FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on BusinessEntityAddr */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.BusinessEntity  Person.BusinessEntityAddr on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00049c46", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_BusinessEnti", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,Person.BusinessEntity
      WHERE
        /* %JoinFKPK(deleted,Person.BusinessEntity," = "," AND") */
        deleted.BusinessEntityID = Person.BusinessEntity.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Person.BusinessEntityAddr
          WHERE
            /* %JoinFKPK(Person.BusinessEntityAddr,Person.BusinessEntity," = "," AND") */
            Person.BusinessEntityAddr.BusinessEntityID = Person.BusinessEntity.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Person.BusinessEntityAddr because Person.BusinessEntity exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.AddrTyp  Person.BusinessEntityAddr on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="AddrTyp"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.AddrTyp_Person.Busin", FK_COLUMNS="AddrTypID" */
    IF EXISTS (SELECT * FROM deleted,Person.AddrTyp
      WHERE
        /* %JoinFKPK(deleted,Person.AddrTyp," = "," AND") */
        deleted.AddrTypID = Person.AddrTyp.AddrTypID AND
        NOT EXISTS (
          SELECT * FROM Person.BusinessEntityAddr
          WHERE
            /* %JoinFKPK(Person.BusinessEntityAddr,Person.AddrTyp," = "," AND") */
            Person.BusinessEntityAddr.AddrTypID = Person.AddrTyp.AddrTypID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Person.BusinessEntityAddr because Person.AddrTyp exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Addr  Person.BusinessEntityAddr on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Addr"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.Addr_Person.Business", FK_COLUMNS="AddrID" */
    IF EXISTS (SELECT * FROM deleted,Person.Addr
      WHERE
        /* %JoinFKPK(deleted,Person.Addr," = "," AND") */
        deleted.AddrID = Person.Addr.AddrID AND
        NOT EXISTS (
          SELECT * FROM Person.BusinessEntityAddr
          WHERE
            /* %JoinFKPK(Person.BusinessEntityAddr,Person.Addr," = "," AND") */
            Person.BusinessEntityAddr.AddrID = Person.Addr.AddrID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Person.BusinessEntityAddr because Person.Addr exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tU_BusinessEntityAddress ON Person.BusinessEntityAddr FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on BusinessEntityAddr */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int, 
           @insAddrID int, 
           @insAddrTypID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.BusinessEntity  Person.BusinessEntityAddr on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00048d2e", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_BusinessEnti", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.BusinessEntity
        WHERE
          /* %JoinFKPK(inserted,Person.BusinessEntity) */
          inserted.BusinessEntityID = Person.BusinessEntity.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Person.BusinessEntityAddr because Person.BusinessEntity does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.AddrTyp  Person.BusinessEntityAddr on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="AddrTyp"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.AddrTyp_Person.Busin", FK_COLUMNS="AddrTypID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(AddrTypID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.AddrTyp
        WHERE
          /* %JoinFKPK(inserted,Person.AddrTyp) */
          inserted.AddrTypID = Person.AddrTyp.AddrTypID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Person.BusinessEntityAddr because Person.AddrTyp does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.Addr  Person.BusinessEntityAddr on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Addr"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.Addr_Person.Business", FK_COLUMNS="AddrID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(AddrID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.Addr
        WHERE
          /* %JoinFKPK(inserted,Person.Addr) */
          inserted.AddrID = Person.Addr.AddrID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Person.BusinessEntityAddr because Person.Addr does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Purchasing.tD_ProductVendor ON Purchasing.ProductVendor FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ProductVendor */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Purchasing.Vendor  Purchasing.ProductVendor on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0004be95", PARENT_OWNER="Purchasing", PARENT_TABLE="Vendor"
    CHILD_OWNER="Purchasing", CHILD_TABLE="ProductVendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Vendor_ProductVendor", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,Purchasing.Vendor
      WHERE
        /* %JoinFKPK(deleted,Purchasing.Vendor," = "," AND") */
        deleted.BusinessEntityID = Purchasing.Vendor.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Purchasing.ProductVendor
          WHERE
            /* %JoinFKPK(Purchasing.ProductVendor,Purchasing.Vendor," = "," AND") */
            Purchasing.ProductVendor.BusinessEntityID = Purchasing.Vendor.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Purchasing.ProductVendor because Purchasing.Vendor exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.UnitMeasure  Purchasing.ProductVendor on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Purchasing", CHILD_TABLE="ProductVendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Purc", FK_COLUMNS="UnitMeasureCd" */
    IF EXISTS (SELECT * FROM deleted,Production.UnitMeasure
      WHERE
        /* %JoinFKPK(deleted,Production.UnitMeasure," = "," AND") */
        deleted.UnitMeasureCd = Production.UnitMeasure.UnitMeasureCd AND
        NOT EXISTS (
          SELECT * FROM Purchasing.ProductVendor
          WHERE
            /* %JoinFKPK(Purchasing.ProductVendor,Production.UnitMeasure," = "," AND") */
            Purchasing.ProductVendor.UnitMeasureCd = Production.UnitMeasure.UnitMeasureCd
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Purchasing.ProductVendor because Production.UnitMeasure exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Purchasing.ProductVendor on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Purchasing", CHILD_TABLE="ProductVendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Purchasi", FK_COLUMNS="ProductID" */
    IF EXISTS (SELECT * FROM deleted,Production.Product
      WHERE
        /* %JoinFKPK(deleted,Production.Product," = "," AND") */
        deleted.ProductID = Production.Product.ProductID AND
        NOT EXISTS (
          SELECT * FROM Purchasing.ProductVendor
          WHERE
            /* %JoinFKPK(Purchasing.ProductVendor,Production.Product," = "," AND") */
            Purchasing.ProductVendor.ProductID = Production.Product.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Purchasing.ProductVendor because Production.Product exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Purchasing.tU_ProductVendor ON Purchasing.ProductVendor FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ProductVendor */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProductID int, 
           @insBusinessEntityID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Purchasing.Vendor  Purchasing.ProductVendor on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0004b49d", PARENT_OWNER="Purchasing", PARENT_TABLE="Vendor"
    CHILD_OWNER="Purchasing", CHILD_TABLE="ProductVendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Vendor_ProductVendor", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Purchasing.Vendor
        WHERE
          /* %JoinFKPK(inserted,Purchasing.Vendor) */
          inserted.BusinessEntityID = Purchasing.Vendor.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Purchasing.ProductVendor because Purchasing.Vendor does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.UnitMeasure  Purchasing.ProductVendor on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Purchasing", CHILD_TABLE="ProductVendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Purc", FK_COLUMNS="UnitMeasureCd" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(UnitMeasureCd)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.UnitMeasure
        WHERE
          /* %JoinFKPK(inserted,Production.UnitMeasure) */
          inserted.UnitMeasureCd = Production.UnitMeasure.UnitMeasureCd
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Purchasing.ProductVendor because Production.UnitMeasure does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Product  Purchasing.ProductVendor on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Purchasing", CHILD_TABLE="ProductVendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Purchasi", FK_COLUMNS="ProductID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Product
        WHERE
          /* %JoinFKPK(inserted,Production.Product) */
          inserted.ProductID = Production.Product.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Purchasing.ProductVendor because Production.Product does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tD_BusinessEntityContact ON Person.BusinessEntityContact FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on BusinessEntityContact */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.BusinessEntity  Person.BusinessEntityContact on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0004c20b", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityContact"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_BusinessEnti", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,Person.BusinessEntity
      WHERE
        /* %JoinFKPK(deleted,Person.BusinessEntity," = "," AND") */
        deleted.BusinessEntityID = Person.BusinessEntity.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Person.BusinessEntityContact
          WHERE
            /* %JoinFKPK(Person.BusinessEntityContact,Person.BusinessEntity," = "," AND") */
            Person.BusinessEntityContact.BusinessEntityID = Person.BusinessEntity.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Person.BusinessEntityContact because Person.BusinessEntity exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.ContactTyp  Person.BusinessEntityContact on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="ContactTyp"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityContact"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.ContactTyp_Person.Bu", FK_COLUMNS="ContactTypID" */
    IF EXISTS (SELECT * FROM deleted,Person.ContactTyp
      WHERE
        /* %JoinFKPK(deleted,Person.ContactTyp," = "," AND") */
        deleted.ContactTypID = Person.ContactTyp.ContactTypID AND
        NOT EXISTS (
          SELECT * FROM Person.BusinessEntityContact
          WHERE
            /* %JoinFKPK(Person.BusinessEntityContact,Person.ContactTyp," = "," AND") */
            Person.BusinessEntityContact.ContactTypID = Person.ContactTyp.ContactTypID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Person.BusinessEntityContact because Person.ContactTyp exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Person  Person.BusinessEntityContact on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityContact"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_BusinessEntityContac", FK_COLUMNS="PersonID" */
    IF EXISTS (SELECT * FROM deleted,Person.Person
      WHERE
        /* %JoinFKPK(deleted,Person.Person," = "," AND") */
        deleted.PersonID = Person.Person.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Person.BusinessEntityContact
          WHERE
            /* %JoinFKPK(Person.BusinessEntityContact,Person.Person," = "," AND") */
            Person.BusinessEntityContact.PersonID = Person.Person.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Person.BusinessEntityContact because Person.Person exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tU_BusinessEntityContact ON Person.BusinessEntityContact FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on BusinessEntityContact */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int, 
           @insPersonID int, 
           @insContactTypID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.BusinessEntity  Person.BusinessEntityContact on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0004b730", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityContact"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_BusinessEnti", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.BusinessEntity
        WHERE
          /* %JoinFKPK(inserted,Person.BusinessEntity) */
          inserted.BusinessEntityID = Person.BusinessEntity.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Person.BusinessEntityContact because Person.BusinessEntity does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.ContactTyp  Person.BusinessEntityContact on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="ContactTyp"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityContact"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.ContactTyp_Person.Bu", FK_COLUMNS="ContactTypID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ContactTypID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.ContactTyp
        WHERE
          /* %JoinFKPK(inserted,Person.ContactTyp) */
          inserted.ContactTypID = Person.ContactTyp.ContactTypID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Person.BusinessEntityContact because Person.ContactTyp does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.Person  Person.BusinessEntityContact on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityContact"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_BusinessEntityContac", FK_COLUMNS="PersonID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(PersonID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.Person
        WHERE
          /* %JoinFKPK(inserted,Person.Person) */
          inserted.PersonID = Person.Person.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Person.BusinessEntityContact because Person.Person does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_UnitMeasure ON Production.UnitMeasure FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on UnitMeasure */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.UnitMeasure  Purchasing.ProductVendor on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00050cee", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Purchasing", CHILD_TABLE="ProductVendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Purc", FK_COLUMNS="UnitMeasureCd" */
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.ProductVendor
      WHERE
        /*  %JoinFKPK(Purchasing.ProductVendor,deleted," = "," AND") */
        Purchasing.ProductVendor.UnitMeasureCd = deleted.UnitMeasureCd
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.UnitMeasure because Purchasing.ProductVendor exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.UnitMeasure  Production.BillOfMaterials on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Production", CHILD_TABLE="BillOfMaterials"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Prod", FK_COLUMNS="UnitMeasureCd" */
    IF EXISTS (
      SELECT * FROM deleted,Production.BillOfMaterials
      WHERE
        /*  %JoinFKPK(Production.BillOfMaterials,deleted," = "," AND") */
        Production.BillOfMaterials.UnitMeasureCd = deleted.UnitMeasureCd
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.UnitMeasure because Production.BillOfMaterials exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.UnitMeasure  Production.Product on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Prod", FK_COLUMNS="WeightUnitMeasureCd" */
    IF EXISTS (
      SELECT * FROM deleted,Production.Product
      WHERE
        /*  %JoinFKPK(Production.Product,deleted," = "," AND") */
        Production.Product.WeightUnitMeasureCd = deleted.UnitMeasureCd
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.UnitMeasure because Production.Product exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.UnitMeasure  Production.Product on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Prod", FK_COLUMNS="SizeUnitMeasureCd" */
    IF EXISTS (
      SELECT * FROM deleted,Production.Product
      WHERE
        /*  %JoinFKPK(Production.Product,deleted," = "," AND") */
        Production.Product.SizeUnitMeasureCd = deleted.UnitMeasureCd
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.UnitMeasure because Production.Product exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_UnitMeasure ON Production.UnitMeasure FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on UnitMeasure */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insUnitMeasureCd nchar(3),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.UnitMeasure  Purchasing.ProductVendor on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00055682", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Purchasing", CHILD_TABLE="ProductVendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Purc", FK_COLUMNS="UnitMeasureCd" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(UnitMeasureCd)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.ProductVendor
      WHERE
        /*  %JoinFKPK(Purchasing.ProductVendor,deleted," = "," AND") */
        Purchasing.ProductVendor.UnitMeasureCd = deleted.UnitMeasureCd
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.UnitMeasure because Purchasing.ProductVendor exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.UnitMeasure  Production.BillOfMaterials on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Production", CHILD_TABLE="BillOfMaterials"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Prod", FK_COLUMNS="UnitMeasureCd" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(UnitMeasureCd)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.BillOfMaterials
      WHERE
        /*  %JoinFKPK(Production.BillOfMaterials,deleted," = "," AND") */
        Production.BillOfMaterials.UnitMeasureCd = deleted.UnitMeasureCd
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.UnitMeasure because Production.BillOfMaterials exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.UnitMeasure  Production.Product on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Prod", FK_COLUMNS="WeightUnitMeasureCd" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(UnitMeasureCd)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.Product
      WHERE
        /*  %JoinFKPK(Production.Product,deleted," = "," AND") */
        Production.Product.WeightUnitMeasureCd = deleted.UnitMeasureCd
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.UnitMeasure because Production.Product exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.UnitMeasure  Production.Product on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="UnitMeasure"
    CHILD_OWNER="Production", CHILD_TABLE="Product"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.UnitMeasure_Prod", FK_COLUMNS="SizeUnitMeasureCd" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(UnitMeasureCd)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.Product
      WHERE
        /*  %JoinFKPK(Production.Product,deleted," = "," AND") */
        Production.Product.SizeUnitMeasureCd = deleted.UnitMeasureCd
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.UnitMeasure because Production.Product exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER [dVendor] ON Vendor
   WITH 
 EXECUTE AS CALLER  INSTEAD OF DELETE 
 
 NOT FOR REPLICATION 
  AS

BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        DECLARE @DeleteCount int;

        SELECT @DeleteCount = COUNT(*) FROM deleted;
        IF @DeleteCount > 0 
        BEGIN
            RAISERROR
                (N'Vendors cannot be deleted. They can only be marked as not active.', -- Message
                10, -- Severity.
                1); -- State.

        -- Rollback any active or uncommittable transactions
            IF @@TRANCOUNT > 0
            BEGIN
                ROLLBACK TRANSACTION;
            END
        END;
    END TRY
    BEGIN CATCH
        EXECUTE [dbo].[uspPrintError];

        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;

 
go


ENABLE TRIGGER [dVendor] ON Vendor
go

CREATE TRIGGER Purchasing.tU_Vendor ON Purchasing.Vendor FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Vendor */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Purchasing.Vendor  Purchasing.PurchaseOrdrHeader on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00046cbb", PARENT_OWNER="Purchasing", PARENT_TABLE="Vendor"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Vendor_PurchaseOrdrHeader", FK_COLUMNS="VendorID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.PurchaseOrdrHeader
      WHERE
        /*  %JoinFKPK(Purchasing.PurchaseOrdrHeader,deleted," = "," AND") */
        Purchasing.PurchaseOrdrHeader.VendorID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Purchasing.Vendor because Purchasing.PurchaseOrdrHeader exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Purchasing.Vendor  Purchasing.ProductVendor on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Purchasing", PARENT_TABLE="Vendor"
    CHILD_OWNER="Purchasing", CHILD_TABLE="ProductVendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Vendor_ProductVendor", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.ProductVendor
      WHERE
        /*  %JoinFKPK(Purchasing.ProductVendor,deleted," = "," AND") */
        Purchasing.ProductVendor.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Purchasing.Vendor because Purchasing.ProductVendor exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.BusinessEntity  Purchasing.Vendor on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Purchasing", CHILD_TABLE="Vendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_Vendor", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.BusinessEntity
        WHERE
          /* %JoinFKPK(inserted,Person.BusinessEntity) */
          inserted.BusinessEntityID = Person.BusinessEntity.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Purchasing.Vendor because Person.BusinessEntity does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Purchasing.Trigger_3076 ON Purchasing.Vendor FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Vendor */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Purchasing.Vendor  Purchasing.ProductVendor on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000151ce", PARENT_OWNER="Purchasing", PARENT_TABLE="Vendor"
    CHILD_OWNER="Purchasing", CHILD_TABLE="ProductVendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Vendor_ProductVendor", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.ProductVendor
      WHERE
        /*  %JoinFKPK(Purchasing.ProductVendor,deleted," = "," AND") */
        Purchasing.ProductVendor.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Purchasing.Vendor because Purchasing.ProductVendor exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Purchasing.Trigger_3077 ON Purchasing.Vendor FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Vendor */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.BusinessEntity  Purchasing.Vendor on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001a8e7", PARENT_OWNER="Person", PARENT_TABLE="BusinessEntity"
    CHILD_OWNER="Purchasing", CHILD_TABLE="Vendor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_BusinessEntity_Vendor", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,Person.BusinessEntity
      WHERE
        /* %JoinFKPK(deleted,Person.BusinessEntity," = "," AND") */
        deleted.BusinessEntityID = Person.BusinessEntity.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Purchasing.Vendor
          WHERE
            /* %JoinFKPK(Purchasing.Vendor,Person.BusinessEntity," = "," AND") */
            Purchasing.Vendor.BusinessEntityID = Person.BusinessEntity.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Purchasing.Vendor because Person.BusinessEntity exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Purchasing.Trigger_3107 ON Purchasing.Vendor FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Vendor */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Purchasing.Vendor  Purchasing.PurchaseOrdrHeader on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000158a3", PARENT_OWNER="Purchasing", PARENT_TABLE="Vendor"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Vendor_PurchaseOrdrHeader", FK_COLUMNS="VendorID" */
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.PurchaseOrdrHeader
      WHERE
        /*  %JoinFKPK(Purchasing.PurchaseOrdrHeader,deleted," = "," AND") */
        Purchasing.PurchaseOrdrHeader.VendorID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Purchasing.Vendor because Purchasing.PurchaseOrdrHeader exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tD_ContactType ON Person.ContactTyp FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ContactTyp */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.ContactTyp  Person.BusinessEntityContact on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00015537", PARENT_OWNER="Person", PARENT_TABLE="ContactTyp"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityContact"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.ContactTyp_Person.Bu", FK_COLUMNS="ContactTypID" */
    IF EXISTS (
      SELECT * FROM deleted,Person.BusinessEntityContact
      WHERE
        /*  %JoinFKPK(Person.BusinessEntityContact,deleted," = "," AND") */
        Person.BusinessEntityContact.ContactTypID = deleted.ContactTypID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.ContactTyp because Person.BusinessEntityContact exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tU_ContactType ON Person.ContactTyp FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ContactTyp */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insContactTypID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.ContactTyp  Person.BusinessEntityContact on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00017718", PARENT_OWNER="Person", PARENT_TABLE="ContactTyp"
    CHILD_OWNER="Person", CHILD_TABLE="BusinessEntityContact"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.ContactTyp_Person.Bu", FK_COLUMNS="ContactTypID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ContactTypID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Person.BusinessEntityContact
      WHERE
        /*  %JoinFKPK(Person.BusinessEntityContact,deleted," = "," AND") */
        Person.BusinessEntityContact.ContactTypID = deleted.ContactTypID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.ContactTyp because Person.BusinessEntityContact exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_CountryRegionCurrency ON Sales.CountryRgnCurrency FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on CountryRgnCurrency */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.Currency  Sales.CountryRgnCurrency on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0003286b", PARENT_OWNER="Sales", PARENT_TABLE="Currency"
    CHILD_OWNER="Sales", CHILD_TABLE="CountryRgnCurrency"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Currency_Sales.Countr", FK_COLUMNS="CurrencyCd" */
    IF EXISTS (SELECT * FROM deleted,Sales.Currency
      WHERE
        /* %JoinFKPK(deleted,Sales.Currency," = "," AND") */
        deleted.CurrencyCd = Sales.Currency.CurrencyCd AND
        NOT EXISTS (
          SELECT * FROM Sales.CountryRgnCurrency
          WHERE
            /* %JoinFKPK(Sales.CountryRgnCurrency,Sales.Currency," = "," AND") */
            Sales.CountryRgnCurrency.CurrencyCd = Sales.Currency.CurrencyCd
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.CountryRgnCurrency because Sales.Currency exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.CountryRgn  Sales.CountryRgnCurrency on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="CountryRgn"
    CHILD_OWNER="Sales", CHILD_TABLE="CountryRgnCurrency"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.CountryRgn_Sales.Cou", FK_COLUMNS="CountryRgnCd" */
    IF EXISTS (SELECT * FROM deleted,Person.CountryRgn
      WHERE
        /* %JoinFKPK(deleted,Person.CountryRgn," = "," AND") */
        deleted.CountryRgnCd = Person.CountryRgn.CountryRgnCd AND
        NOT EXISTS (
          SELECT * FROM Sales.CountryRgnCurrency
          WHERE
            /* %JoinFKPK(Sales.CountryRgnCurrency,Person.CountryRgn," = "," AND") */
            Sales.CountryRgnCurrency.CountryRgnCd = Person.CountryRgn.CountryRgnCd
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.CountryRgnCurrency because Person.CountryRgn exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_CountryRegionCurrency ON Sales.CountryRgnCurrency FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on CountryRgnCurrency */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCountryRgnCd nvarchar(3), 
           @insCurrencyCd nchar(3),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.Currency  Sales.CountryRgnCurrency on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00031612", PARENT_OWNER="Sales", PARENT_TABLE="Currency"
    CHILD_OWNER="Sales", CHILD_TABLE="CountryRgnCurrency"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Currency_Sales.Countr", FK_COLUMNS="CurrencyCd" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CurrencyCd)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.Currency
        WHERE
          /* %JoinFKPK(inserted,Sales.Currency) */
          inserted.CurrencyCd = Sales.Currency.CurrencyCd
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.CountryRgnCurrency because Sales.Currency does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.CountryRgn  Sales.CountryRgnCurrency on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="CountryRgn"
    CHILD_OWNER="Sales", CHILD_TABLE="CountryRgnCurrency"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.CountryRgn_Sales.Cou", FK_COLUMNS="CountryRgnCd" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CountryRgnCd)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.CountryRgn
        WHERE
          /* %JoinFKPK(inserted,Person.CountryRgn) */
          inserted.CountryRgnCd = Person.CountryRgn.CountryRgnCd
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.CountryRgnCurrency because Person.CountryRgn does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tD_CountryRegion ON Person.CountryRgn FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on CountryRgn */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.CountryRgn  Sales.CountryRgnCurrency on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00038b90", PARENT_OWNER="Person", PARENT_TABLE="CountryRgn"
    CHILD_OWNER="Sales", CHILD_TABLE="CountryRgnCurrency"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.CountryRgn_Sales.Cou", FK_COLUMNS="CountryRgnCd" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.CountryRgnCurrency
      WHERE
        /*  %JoinFKPK(Sales.CountryRgnCurrency,deleted," = "," AND") */
        Sales.CountryRgnCurrency.CountryRgnCd = deleted.CountryRgnCd
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.CountryRgn because Sales.CountryRgnCurrency exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.CountryRgn  Person.StProvince on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="CountryRgn"
    CHILD_OWNER="Person", CHILD_TABLE="StProvince"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.CountryRgn_Person.St", FK_COLUMNS="CountryRgnCd" */
    IF EXISTS (
      SELECT * FROM deleted,Person.StProvince
      WHERE
        /*  %JoinFKPK(Person.StProvince,deleted," = "," AND") */
        Person.StProvince.CountryRgnCd = deleted.CountryRgnCd
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.CountryRgn because Person.StProvince exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.CountryRgn  Sales.SlsTerritory on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="CountryRgn"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTerritory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.CountryRgn_Sales.Sls", FK_COLUMNS="CountryRgnCd" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsTerritory
      WHERE
        /*  %JoinFKPK(Sales.SlsTerritory,deleted," = "," AND") */
        Sales.SlsTerritory.CountryRgnCd = deleted.CountryRgnCd
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Person.CountryRgn because Sales.SlsTerritory exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tU_CountryRegion ON Person.CountryRgn FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on CountryRgn */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCountryRgnCd nvarchar(3),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.CountryRgn  Sales.CountryRgnCurrency on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003dac8", PARENT_OWNER="Person", PARENT_TABLE="CountryRgn"
    CHILD_OWNER="Sales", CHILD_TABLE="CountryRgnCurrency"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.CountryRgn_Sales.Cou", FK_COLUMNS="CountryRgnCd" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CountryRgnCd)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.CountryRgnCurrency
      WHERE
        /*  %JoinFKPK(Sales.CountryRgnCurrency,deleted," = "," AND") */
        Sales.CountryRgnCurrency.CountryRgnCd = deleted.CountryRgnCd
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.CountryRgn because Sales.CountryRgnCurrency exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.CountryRgn  Person.StProvince on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="CountryRgn"
    CHILD_OWNER="Person", CHILD_TABLE="StProvince"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.CountryRgn_Person.St", FK_COLUMNS="CountryRgnCd" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CountryRgnCd)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Person.StProvince
      WHERE
        /*  %JoinFKPK(Person.StProvince,deleted," = "," AND") */
        Person.StProvince.CountryRgnCd = deleted.CountryRgnCd
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.CountryRgn because Person.StProvince exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.CountryRgn  Sales.SlsTerritory on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="CountryRgn"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsTerritory"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.CountryRgn_Sales.Sls", FK_COLUMNS="CountryRgnCd" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CountryRgnCd)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsTerritory
      WHERE
        /*  %JoinFKPK(Sales.SlsTerritory,deleted," = "," AND") */
        Sales.SlsTerritory.CountryRgnCd = deleted.CountryRgnCd
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Person.CountryRgn because Sales.SlsTerritory exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER [iWorkOrder] ON WorkOrdr
   WITH 
 EXECUTE AS CALLER  AFTER INSERT 
  
  AS

BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [Production].[TransactionHistory](
            [ProductID]
            ,[ReferenceOrderID]
            ,[TransactionType]
            ,[TransactionDate]
            ,[Quantity]
            ,[ActualCost])
        SELECT 
            inserted.[ProductID]
            ,inserted.[WorkOrderID]
            ,'W'
            ,GETDATE()
            ,inserted.[OrderQty]
            ,0
        FROM inserted;
    END TRY
    BEGIN CATCH
        EXECUTE [dbo].[uspPrintError];

        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;

 
go


ENABLE TRIGGER [iWorkOrder] ON WorkOrdr
go

CREATE TRIGGER [uWorkOrder] ON WorkOrdr
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        IF UPDATE([ProductID]) OR UPDATE([OrderQty])
        BEGIN
            INSERT INTO [Production].[TransactionHistory](
                [ProductID]
                ,[ReferenceOrderID]
                ,[TransactionType]
                ,[TransactionDate]
                ,[Quantity])
            SELECT 
                inserted.[ProductID]
                ,inserted.[WorkOrderID]
                ,'W'
                ,GETDATE()
                ,inserted.[OrderQty]
            FROM inserted;
        END;
    END TRY
    BEGIN CATCH
        EXECUTE [dbo].[uspPrintError];

        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;

 
go


ENABLE TRIGGER [uWorkOrder] ON WorkOrdr
go

CREATE TRIGGER Production.tD_WorkOrder ON Production.WorkOrdr FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on WorkOrdr */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.WorkOrdr  Production.WorkOrdrRouting on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00045339", PARENT_OWNER="Production", PARENT_TABLE="WorkOrdr"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdrRouting"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.WorkOrdr_Product", FK_COLUMNS="WorkOrdrID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.WorkOrdrRouting
      WHERE
        /*  %JoinFKPK(Production.WorkOrdrRouting,deleted," = "," AND") */
        Production.WorkOrdrRouting.WorkOrdrID = deleted.WorkOrdrID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.WorkOrdr because Production.WorkOrdrRouting exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.ScrapReason  Production.WorkOrdr on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="ScrapReason"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ScrapReason_Prod", FK_COLUMNS="ScrapReasonID" */
    IF EXISTS (SELECT * FROM deleted,Production.ScrapReason
      WHERE
        /* %JoinFKPK(deleted,Production.ScrapReason," = "," AND") */
        deleted.ScrapReasonID = Production.ScrapReason.ScrapReasonID AND
        NOT EXISTS (
          SELECT * FROM Production.WorkOrdr
          WHERE
            /* %JoinFKPK(Production.WorkOrdr,Production.ScrapReason," = "," AND") */
            Production.WorkOrdr.ScrapReasonID = Production.ScrapReason.ScrapReasonID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.WorkOrdr because Production.ScrapReason exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Production.WorkOrdr on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
    IF EXISTS (SELECT * FROM deleted,Production.Product
      WHERE
        /* %JoinFKPK(deleted,Production.Product," = "," AND") */
        deleted.ProductID = Production.Product.ProductID AND
        NOT EXISTS (
          SELECT * FROM Production.WorkOrdr
          WHERE
            /* %JoinFKPK(Production.WorkOrdr,Production.Product," = "," AND") */
            Production.WorkOrdr.ProductID = Production.Product.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.WorkOrdr because Production.Product exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_WorkOrder ON Production.WorkOrdr FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on WorkOrdr */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insWorkOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Product  Production.WorkOrdr on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001a50f", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Producti", FK_COLUMNS="ProductID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Product
        WHERE
          /* %JoinFKPK(inserted,Production.Product) */
          inserted.ProductID = Production.Product.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.WorkOrdr because Production.Product does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.Trigger_3090 ON Production.WorkOrdr FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on WorkOrdr */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insWorkOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.ScrapReason  Production.WorkOrdr on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001cda6", PARENT_OWNER="Production", PARENT_TABLE="ScrapReason"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.ScrapReason_Prod", FK_COLUMNS="ScrapReasonID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ScrapReasonID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.ScrapReason
        WHERE
          /* %JoinFKPK(inserted,Production.ScrapReason) */
          inserted.ScrapReasonID = Production.ScrapReason.ScrapReasonID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.ScrapReasonID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.WorkOrdr because Production.ScrapReason does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.Trigger_3103 ON Production.WorkOrdr FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on WorkOrdr */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insWorkOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.WorkOrdr  Production.WorkOrdrRouting on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00015f64", PARENT_OWNER="Production", PARENT_TABLE="WorkOrdr"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdrRouting"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.WorkOrdr_Product", FK_COLUMNS="WorkOrdrID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(WorkOrdrID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.WorkOrdrRouting
      WHERE
        /*  %JoinFKPK(Production.WorkOrdrRouting,deleted," = "," AND") */
        Production.WorkOrdrRouting.WorkOrdrID = deleted.WorkOrdrID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.WorkOrdr because Production.WorkOrdrRouting exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER [iPurchaseOrderDetail] ON PurchaseOrdrDetail
   WITH 
 EXECUTE AS CALLER  AFTER INSERT 
  
  AS

BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO [Production].[TransactionHistory]
            ([ProductID]
            ,[ReferenceOrderID]
            ,[ReferenceOrderLineID]
            ,[TransactionType]
            ,[TransactionDate]
            ,[Quantity]
            ,[ActualCost])
        SELECT 
            inserted.[ProductID]
            ,inserted.[PurchaseOrderID]
            ,inserted.[PurchaseOrderDetailID]
            ,'P'
            ,GETDATE()
            ,inserted.[OrderQty]
            ,inserted.[UnitPrice]
        FROM inserted 
            INNER JOIN [Purchasing].[PurchaseOrderHeader] 
            ON inserted.[PurchaseOrderID] = [Purchasing].[PurchaseOrderHeader].[PurchaseOrderID];

        -- Update SubTotal in PurchaseOrderHeader record. Note that this causes the 
        -- PurchaseOrderHeader trigger to fire which will update the RevisionNumber.
        UPDATE [Purchasing].[PurchaseOrderHeader]
        SET [Purchasing].[PurchaseOrderHeader].[SubTotal] = 
            (SELECT SUM([Purchasing].[PurchaseOrderDetail].[LineTotal])
                FROM [Purchasing].[PurchaseOrderDetail]
                WHERE [Purchasing].[PurchaseOrderHeader].[PurchaseOrderID] = [Purchasing].[PurchaseOrderDetail].[PurchaseOrderID])
        WHERE [Purchasing].[PurchaseOrderHeader].[PurchaseOrderID] IN (SELECT inserted.[PurchaseOrderID] FROM inserted);
    END TRY
    BEGIN CATCH
        EXECUTE [dbo].[uspPrintError];

        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;

 
go


ENABLE TRIGGER [iPurchaseOrderDetail] ON PurchaseOrdrDetail
go

CREATE TRIGGER [uPurchaseOrderDetail] ON PurchaseOrdrDetail
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        IF UPDATE([ProductID]) OR UPDATE([OrderQty]) OR UPDATE([UnitPrice])
        -- Insert record into TransactionHistory 
        BEGIN
            INSERT INTO [Production].[TransactionHistory]
                ([ProductID]
                ,[ReferenceOrderID]
                ,[ReferenceOrderLineID]
                ,[TransactionType]
                ,[TransactionDate]
                ,[Quantity]
                ,[ActualCost])
            SELECT 
                inserted.[ProductID]
                ,inserted.[PurchaseOrderID]
                ,inserted.[PurchaseOrderDetailID]
                ,'P'
                ,GETDATE()
                ,inserted.[OrderQty]
                ,inserted.[UnitPrice]
            FROM inserted 
                INNER JOIN [Purchasing].[PurchaseOrderDetail] 
                ON inserted.[PurchaseOrderID] = [Purchasing].[PurchaseOrderDetail].[PurchaseOrderID];

            -- Update SubTotal in PurchaseOrderHeader record. Note that this causes the 
            -- PurchaseOrderHeader trigger to fire which will update the RevisionNumber.
            UPDATE [Purchasing].[PurchaseOrderHeader]
            SET [Purchasing].[PurchaseOrderHeader].[SubTotal] = 
                (SELECT SUM([Purchasing].[PurchaseOrderDetail].[LineTotal])
                    FROM [Purchasing].[PurchaseOrderDetail]
                    WHERE [Purchasing].[PurchaseOrderHeader].[PurchaseOrderID] 
                        = [Purchasing].[PurchaseOrderDetail].[PurchaseOrderID])
            WHERE [Purchasing].[PurchaseOrderHeader].[PurchaseOrderID] 
                IN (SELECT inserted.[PurchaseOrderID] FROM inserted);

            UPDATE [Purchasing].[PurchaseOrderDetail]
            SET [Purchasing].[PurchaseOrderDetail].[ModifiedDate] = GETDATE()
            FROM inserted
            WHERE inserted.[PurchaseOrderID] = [Purchasing].[PurchaseOrderDetail].[PurchaseOrderID]
                AND inserted.[PurchaseOrderDetailID] = [Purchasing].[PurchaseOrderDetail].[PurchaseOrderDetailID];
        END;
    END TRY
    BEGIN CATCH
        EXECUTE [dbo].[uspPrintError];

        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;

 
go


ENABLE TRIGGER [uPurchaseOrderDetail] ON PurchaseOrdrDetail
go

CREATE TRIGGER Purchasing.tD_PurchaseOrderDetail ON Purchasing.PurchaseOrdrDetail FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on PurchaseOrdrDetail */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Purchasing.PurchaseOrdrHeader  Purchasing.PurchaseOrdrDetail on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000360fd", PARENT_OWNER="Purchasing", PARENT_TABLE="PurchaseOrdrHeader"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchasing.PurchaseOrdrHead", FK_COLUMNS="PurchaseOrdrID" */
    IF EXISTS (SELECT * FROM deleted,Purchasing.PurchaseOrdrHeader
      WHERE
        /* %JoinFKPK(deleted,Purchasing.PurchaseOrdrHeader," = "," AND") */
        deleted.PurchaseOrdrID = Purchasing.PurchaseOrdrHeader.PurchaseOrdrID AND
        NOT EXISTS (
          SELECT * FROM Purchasing.PurchaseOrdrDetail
          WHERE
            /* %JoinFKPK(Purchasing.PurchaseOrdrDetail,Purchasing.PurchaseOrdrHeader," = "," AND") */
            Purchasing.PurchaseOrdrDetail.PurchaseOrdrID = Purchasing.PurchaseOrdrHeader.PurchaseOrdrID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Purchasing.PurchaseOrdrDetail because Purchasing.PurchaseOrdrHeader exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Product  Purchasing.PurchaseOrdrDetail on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Purchasi", FK_COLUMNS="ProductID" */
    IF EXISTS (SELECT * FROM deleted,Production.Product
      WHERE
        /* %JoinFKPK(deleted,Production.Product," = "," AND") */
        deleted.ProductID = Production.Product.ProductID AND
        NOT EXISTS (
          SELECT * FROM Purchasing.PurchaseOrdrDetail
          WHERE
            /* %JoinFKPK(Purchasing.PurchaseOrdrDetail,Production.Product," = "," AND") */
            Purchasing.PurchaseOrdrDetail.ProductID = Production.Product.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Purchasing.PurchaseOrdrDetail because Production.Product exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Purchasing.tU_PurchaseOrderDetail ON Purchasing.PurchaseOrdrDetail FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on PurchaseOrdrDetail */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPurchaseOrdrID int, 
           @insPurchaseOrdrDetailID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Product  Purchasing.PurchaseOrdrDetail on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001a566", PARENT_OWNER="Production", PARENT_TABLE="Product"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Product_Purchasi", FK_COLUMNS="ProductID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ProductID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Product
        WHERE
          /* %JoinFKPK(inserted,Production.Product) */
          inserted.ProductID = Production.Product.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Purchasing.PurchaseOrdrDetail because Production.Product does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Purchasing.Trigger_3098 ON Purchasing.PurchaseOrdrDetail FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on PurchaseOrdrDetail */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPurchaseOrdrID int, 
           @insPurchaseOrdrDetailID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Purchasing.PurchaseOrdrHeader  Purchasing.PurchaseOrdrDetail on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001bd81", PARENT_OWNER="Purchasing", PARENT_TABLE="PurchaseOrdrHeader"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchasing.PurchaseOrdrHead", FK_COLUMNS="PurchaseOrdrID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(PurchaseOrdrID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Purchasing.PurchaseOrdrHeader
        WHERE
          /* %JoinFKPK(inserted,Purchasing.PurchaseOrdrHeader) */
          inserted.PurchaseOrdrID = Purchasing.PurchaseOrdrHeader.PurchaseOrdrID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Purchasing.PurchaseOrdrDetail because Purchasing.PurchaseOrdrHeader does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_CreditCard ON Sales.CrdCard FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on CrdCard */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.CrdCard  Sales.SlsOrdrHeader on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000252d1", PARENT_OWNER="Sales", PARENT_TABLE="CrdCard"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.CrdCard_Sales.SlsOrdr", FK_COLUMNS="CrdCardID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.CrdCardID = deleted.CrdCardID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.CrdCard because Sales.SlsOrdrHeader exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.CrdCard  Sales.PersonCrdCard on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="CrdCard"
    CHILD_OWNER="Sales", CHILD_TABLE="PersonCrdCard"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.CrdCard_Sales.PersonC", FK_COLUMNS="CrdCardID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.PersonCrdCard
      WHERE
        /*  %JoinFKPK(Sales.PersonCrdCard,deleted," = "," AND") */
        Sales.PersonCrdCard.CrdCardID = deleted.CrdCardID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.CrdCard because Sales.PersonCrdCard exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_CreditCard ON Sales.CrdCard FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on CrdCard */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCrdCardID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.CrdCard  Sales.SlsOrdrHeader on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002936a", PARENT_OWNER="Sales", PARENT_TABLE="CrdCard"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.CrdCard_Sales.SlsOrdr", FK_COLUMNS="CrdCardID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CrdCardID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.CrdCardID = deleted.CrdCardID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.CrdCard because Sales.SlsOrdrHeader exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.CrdCard  Sales.PersonCrdCard on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="CrdCard"
    CHILD_OWNER="Sales", CHILD_TABLE="PersonCrdCard"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.CrdCard_Sales.PersonC", FK_COLUMNS="CrdCardID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CrdCardID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.PersonCrdCard
      WHERE
        /*  %JoinFKPK(Sales.PersonCrdCard,deleted," = "," AND") */
        Sales.PersonCrdCard.CrdCardID = deleted.CrdCardID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.CrdCard because Sales.PersonCrdCard exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_Culture ON Production.Culture FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Culture */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.Culture  Production.ProductModelProductDescCulture on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00017021", PARENT_OWNER="Production", PARENT_TABLE="Culture"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelProductDescCulture"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Culture_Producti", FK_COLUMNS="CultureID" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductModelProductDescCulture
      WHERE
        /*  %JoinFKPK(Production.ProductModelProductDescCulture,deleted," = "," AND") */
        Production.ProductModelProductDescCulture.CultureID = deleted.CultureID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Culture because Production.ProductModelProductDescCulture exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_Culture ON Production.Culture FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Culture */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCultureID nchar(6),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Culture  Production.ProductModelProductDescCulture on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00018e7f", PARENT_OWNER="Production", PARENT_TABLE="Culture"
    CHILD_OWNER="Production", CHILD_TABLE="ProductModelProductDescCulture"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Culture_Producti", FK_COLUMNS="CultureID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CultureID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductModelProductDescCulture
      WHERE
        /*  %JoinFKPK(Production.ProductModelProductDescCulture,deleted," = "," AND") */
        Production.ProductModelProductDescCulture.CultureID = deleted.CultureID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Culture because Production.ProductModelProductDescCulture exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_WorkOrderRouting ON Production.WorkOrdrRouting FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on WorkOrdrRouting */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.WorkOrdr  Production.WorkOrdrRouting on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00033eb8", PARENT_OWNER="Production", PARENT_TABLE="WorkOrdr"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdrRouting"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.WorkOrdr_Product", FK_COLUMNS="WorkOrdrID" */
    IF EXISTS (SELECT * FROM deleted,Production.WorkOrdr
      WHERE
        /* %JoinFKPK(deleted,Production.WorkOrdr," = "," AND") */
        deleted.WorkOrdrID = Production.WorkOrdr.WorkOrdrID AND
        NOT EXISTS (
          SELECT * FROM Production.WorkOrdrRouting
          WHERE
            /* %JoinFKPK(Production.WorkOrdrRouting,Production.WorkOrdr," = "," AND") */
            Production.WorkOrdrRouting.WorkOrdrID = Production.WorkOrdr.WorkOrdrID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.WorkOrdrRouting because Production.WorkOrdr exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Production.Location  Production.WorkOrdrRouting on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Location"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdrRouting"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Location_Product", FK_COLUMNS="LocationID" */
    IF EXISTS (SELECT * FROM deleted,Production.Location
      WHERE
        /* %JoinFKPK(deleted,Production.Location," = "," AND") */
        deleted.LocationID = Production.Location.LocationID AND
        NOT EXISTS (
          SELECT * FROM Production.WorkOrdrRouting
          WHERE
            /* %JoinFKPK(Production.WorkOrdrRouting,Production.Location," = "," AND") */
            Production.WorkOrdrRouting.LocationID = Production.Location.LocationID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.WorkOrdrRouting because Production.Location exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_WorkOrderRouting ON Production.WorkOrdrRouting FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on WorkOrdrRouting */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insWorkOrdrID int, 
           @insProductID int, 
           @insOperationSeq smallint,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.WorkOrdr  Production.WorkOrdrRouting on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00033044", PARENT_OWNER="Production", PARENT_TABLE="WorkOrdr"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdrRouting"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.WorkOrdr_Product", FK_COLUMNS="WorkOrdrID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(WorkOrdrID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.WorkOrdr
        WHERE
          /* %JoinFKPK(inserted,Production.WorkOrdr) */
          inserted.WorkOrdrID = Production.WorkOrdr.WorkOrdrID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.WorkOrdrRouting because Production.WorkOrdr does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Production.Location  Production.WorkOrdrRouting on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Production", PARENT_TABLE="Location"
    CHILD_OWNER="Production", CHILD_TABLE="WorkOrdrRouting"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Location_Product", FK_COLUMNS="LocationID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(LocationID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Production.Location
        WHERE
          /* %JoinFKPK(inserted,Production.Location) */
          inserted.LocationID = Production.Location.LocationID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.WorkOrdrRouting because Production.Location does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_Currency ON Sales.Currency FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Currency */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.Currency  Sales.CurrencyRate on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00038833", PARENT_OWNER="Sales", PARENT_TABLE="Currency"
    CHILD_OWNER="Sales", CHILD_TABLE="CurrencyRate"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Currency_Sales.Curren", FK_COLUMNS="ToCurrencyCd" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.CurrencyRate
      WHERE
        /*  %JoinFKPK(Sales.CurrencyRate,deleted," = "," AND") */
        Sales.CurrencyRate.ToCurrencyCd = deleted.CurrencyCd
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.Currency because Sales.CurrencyRate exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.Currency  Sales.CurrencyRate on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="Currency"
    CHILD_OWNER="Sales", CHILD_TABLE="CurrencyRate"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Currency_Sales.Curren", FK_COLUMNS="FromCurrencyCd" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.CurrencyRate
      WHERE
        /*  %JoinFKPK(Sales.CurrencyRate,deleted," = "," AND") */
        Sales.CurrencyRate.FromCurrencyCd = deleted.CurrencyCd
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.Currency because Sales.CurrencyRate exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.Currency  Sales.CountryRgnCurrency on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="Currency"
    CHILD_OWNER="Sales", CHILD_TABLE="CountryRgnCurrency"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Currency_Sales.Countr", FK_COLUMNS="CurrencyCd" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.CountryRgnCurrency
      WHERE
        /*  %JoinFKPK(Sales.CountryRgnCurrency,deleted," = "," AND") */
        Sales.CountryRgnCurrency.CurrencyCd = deleted.CurrencyCd
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.Currency because Sales.CountryRgnCurrency exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_Currency ON Sales.Currency FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Currency */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCurrencyCd nchar(3),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.Currency  Sales.CurrencyRate on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003d71b", PARENT_OWNER="Sales", PARENT_TABLE="Currency"
    CHILD_OWNER="Sales", CHILD_TABLE="CurrencyRate"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Currency_Sales.Curren", FK_COLUMNS="ToCurrencyCd" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CurrencyCd)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.CurrencyRate
      WHERE
        /*  %JoinFKPK(Sales.CurrencyRate,deleted," = "," AND") */
        Sales.CurrencyRate.ToCurrencyCd = deleted.CurrencyCd
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.Currency because Sales.CurrencyRate exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.Currency  Sales.CurrencyRate on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="Currency"
    CHILD_OWNER="Sales", CHILD_TABLE="CurrencyRate"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Currency_Sales.Curren", FK_COLUMNS="FromCurrencyCd" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CurrencyCd)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.CurrencyRate
      WHERE
        /*  %JoinFKPK(Sales.CurrencyRate,deleted," = "," AND") */
        Sales.CurrencyRate.FromCurrencyCd = deleted.CurrencyCd
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.Currency because Sales.CurrencyRate exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.Currency  Sales.CountryRgnCurrency on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="Currency"
    CHILD_OWNER="Sales", CHILD_TABLE="CountryRgnCurrency"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Currency_Sales.Countr", FK_COLUMNS="CurrencyCd" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CurrencyCd)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.CountryRgnCurrency
      WHERE
        /*  %JoinFKPK(Sales.CountryRgnCurrency,deleted," = "," AND") */
        Sales.CountryRgnCurrency.CurrencyCd = deleted.CurrencyCd
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.Currency because Sales.CountryRgnCurrency exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER [uPurchaseOrderHeader] ON PurchaseOrdrHeader
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        -- Update RevisionNumber for modification of any field EXCEPT the Status.
        IF NOT UPDATE([Status])
        BEGIN
            UPDATE [Purchasing].[PurchaseOrderHeader]
            SET [Purchasing].[PurchaseOrderHeader].[RevisionNumber] = 
                [Purchasing].[PurchaseOrderHeader].[RevisionNumber] + 1
            WHERE [Purchasing].[PurchaseOrderHeader].[PurchaseOrderID] IN 
                (SELECT inserted.[PurchaseOrderID] FROM inserted);
        END;
    END TRY
    BEGIN CATCH
        EXECUTE [dbo].[uspPrintError];

        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;

 
go


ENABLE TRIGGER [uPurchaseOrderHeader] ON PurchaseOrdrHeader
go

CREATE TRIGGER Purchasing.tD_PurchaseOrderHeader ON Purchasing.PurchaseOrdrHeader FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on PurchaseOrdrHeader */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Purchasing.PurchaseOrdrHeader  Purchasing.PurchaseOrdrDetail on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00062457", PARENT_OWNER="Purchasing", PARENT_TABLE="PurchaseOrdrHeader"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchasing.PurchaseOrdrHead", FK_COLUMNS="PurchaseOrdrID" */
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.PurchaseOrdrDetail
      WHERE
        /*  %JoinFKPK(Purchasing.PurchaseOrdrDetail,deleted," = "," AND") */
        Purchasing.PurchaseOrdrDetail.PurchaseOrdrID = deleted.PurchaseOrdrID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Purchasing.PurchaseOrdrHeader because Purchasing.PurchaseOrdrDetail exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Purchasing.ShipMethod  Purchasing.PurchaseOrdrHeader on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Purchasing", PARENT_TABLE="ShipMethod"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchasing.ShipMethod_Purch", FK_COLUMNS="ShipMethodID" */
    IF EXISTS (SELECT * FROM deleted,Purchasing.ShipMethod
      WHERE
        /* %JoinFKPK(deleted,Purchasing.ShipMethod," = "," AND") */
        deleted.ShipMethodID = Purchasing.ShipMethod.ShipMethodID AND
        NOT EXISTS (
          SELECT * FROM Purchasing.PurchaseOrdrHeader
          WHERE
            /* %JoinFKPK(Purchasing.PurchaseOrdrHeader,Purchasing.ShipMethod," = "," AND") */
            Purchasing.PurchaseOrdrHeader.ShipMethodID = Purchasing.ShipMethod.ShipMethodID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Purchasing.PurchaseOrdrHeader because Purchasing.ShipMethod exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Purchasing.Vendor  Purchasing.PurchaseOrdrHeader on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Purchasing", PARENT_TABLE="Vendor"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Vendor_PurchaseOrdrHeader", FK_COLUMNS="VendorID" */
    IF EXISTS (SELECT * FROM deleted,Purchasing.Vendor
      WHERE
        /* %JoinFKPK(deleted,Purchasing.Vendor," = "," AND") */
        deleted.VendorID = Purchasing.Vendor.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Purchasing.PurchaseOrdrHeader
          WHERE
            /* %JoinFKPK(Purchasing.PurchaseOrdrHeader,Purchasing.Vendor," = "," AND") */
            Purchasing.PurchaseOrdrHeader.VendorID = Purchasing.Vendor.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Purchasing.PurchaseOrdrHeader because Purchasing.Vendor exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* HumanResources.Emp  Purchasing.PurchaseOrdrHeader on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_PurchaseOrdrHeader", FK_COLUMNS="EmpID" */
    IF EXISTS (SELECT * FROM deleted,HumanResources.Emp
      WHERE
        /* %JoinFKPK(deleted,HumanResources.Emp," = "," AND") */
        deleted.EmpID = HumanResources.Emp.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Purchasing.PurchaseOrdrHeader
          WHERE
            /* %JoinFKPK(Purchasing.PurchaseOrdrHeader,HumanResources.Emp," = "," AND") */
            Purchasing.PurchaseOrdrHeader.EmpID = HumanResources.Emp.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Purchasing.PurchaseOrdrHeader because HumanResources.Emp exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Purchasing.tU_PurchaseOrderHeader ON Purchasing.PurchaseOrdrHeader FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on PurchaseOrdrHeader */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPurchaseOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Purchasing.PurchaseOrdrHeader  Purchasing.PurchaseOrdrDetail on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00017a6c", PARENT_OWNER="Purchasing", PARENT_TABLE="PurchaseOrdrHeader"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchasing.PurchaseOrdrHead", FK_COLUMNS="PurchaseOrdrID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(PurchaseOrdrID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.PurchaseOrdrDetail
      WHERE
        /*  %JoinFKPK(Purchasing.PurchaseOrdrDetail,deleted," = "," AND") */
        Purchasing.PurchaseOrdrDetail.PurchaseOrdrID = deleted.PurchaseOrdrID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Purchasing.PurchaseOrdrHeader because Purchasing.PurchaseOrdrDetail exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Purchasing.Trigger_3106 ON Purchasing.PurchaseOrdrHeader FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on PurchaseOrdrHeader */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPurchaseOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* HumanResources.Emp  Purchasing.PurchaseOrdrHeader on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00019b81", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_PurchaseOrdrHeader", FK_COLUMNS="EmpID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(EmpID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,HumanResources.Emp
        WHERE
          /* %JoinFKPK(inserted,HumanResources.Emp) */
          inserted.EmpID = HumanResources.Emp.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Purchasing.PurchaseOrdrHeader because HumanResources.Emp does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Purchasing.Trigger_3108 ON Purchasing.PurchaseOrdrHeader FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on PurchaseOrdrHeader */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPurchaseOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Purchasing.Vendor  Purchasing.PurchaseOrdrHeader on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001a348", PARENT_OWNER="Purchasing", PARENT_TABLE="Vendor"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Vendor_PurchaseOrdrHeader", FK_COLUMNS="VendorID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(VendorID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Purchasing.Vendor
        WHERE
          /* %JoinFKPK(inserted,Purchasing.Vendor) */
          inserted.VendorID = Purchasing.Vendor.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Purchasing.PurchaseOrdrHeader because Purchasing.Vendor does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Purchasing.Trigger_3112 ON Purchasing.PurchaseOrdrHeader FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on PurchaseOrdrHeader */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPurchaseOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Purchasing.ShipMethod  Purchasing.PurchaseOrdrHeader on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001b010", PARENT_OWNER="Purchasing", PARENT_TABLE="ShipMethod"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchasing.ShipMethod_Purch", FK_COLUMNS="ShipMethodID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ShipMethodID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Purchasing.ShipMethod
        WHERE
          /* %JoinFKPK(inserted,Purchasing.ShipMethod) */
          inserted.ShipMethodID = Purchasing.ShipMethod.ShipMethodID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Purchasing.PurchaseOrdrHeader because Purchasing.ShipMethod does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_CurrencyRate ON Sales.CurrencyRate FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on CurrencyRate */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.CurrencyRate  Sales.SlsOrdrHeader on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000432c9", PARENT_OWNER="Sales", PARENT_TABLE="CurrencyRate"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.CurrencyRate_Sales.Sl", FK_COLUMNS="CurrencyRateID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.CurrencyRateID = deleted.CurrencyRateID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.CurrencyRate because Sales.SlsOrdrHeader exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.Currency  Sales.CurrencyRate on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="Currency"
    CHILD_OWNER="Sales", CHILD_TABLE="CurrencyRate"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Currency_Sales.Curren", FK_COLUMNS="ToCurrencyCd" */
    IF EXISTS (SELECT * FROM deleted,Sales.Currency
      WHERE
        /* %JoinFKPK(deleted,Sales.Currency," = "," AND") */
        deleted.ToCurrencyCd = Sales.Currency.CurrencyCd AND
        NOT EXISTS (
          SELECT * FROM Sales.CurrencyRate
          WHERE
            /* %JoinFKPK(Sales.CurrencyRate,Sales.Currency," = "," AND") */
            Sales.CurrencyRate.ToCurrencyCd = Sales.Currency.CurrencyCd
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.CurrencyRate because Sales.Currency exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.Currency  Sales.CurrencyRate on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="Currency"
    CHILD_OWNER="Sales", CHILD_TABLE="CurrencyRate"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Currency_Sales.Curren", FK_COLUMNS="FromCurrencyCd" */
    IF EXISTS (SELECT * FROM deleted,Sales.Currency
      WHERE
        /* %JoinFKPK(deleted,Sales.Currency," = "," AND") */
        deleted.FromCurrencyCd = Sales.Currency.CurrencyCd AND
        NOT EXISTS (
          SELECT * FROM Sales.CurrencyRate
          WHERE
            /* %JoinFKPK(Sales.CurrencyRate,Sales.Currency," = "," AND") */
            Sales.CurrencyRate.FromCurrencyCd = Sales.Currency.CurrencyCd
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.CurrencyRate because Sales.Currency exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_CurrencyRate ON Sales.CurrencyRate FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on CurrencyRate */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCurrencyRateID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.CurrencyRate  Sales.SlsOrdrHeader on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00045552", PARENT_OWNER="Sales", PARENT_TABLE="CurrencyRate"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.CurrencyRate_Sales.Sl", FK_COLUMNS="CurrencyRateID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CurrencyRateID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.CurrencyRateID = deleted.CurrencyRateID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.CurrencyRate because Sales.SlsOrdrHeader exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.Currency  Sales.CurrencyRate on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="Currency"
    CHILD_OWNER="Sales", CHILD_TABLE="CurrencyRate"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Currency_Sales.Curren", FK_COLUMNS="ToCurrencyCd" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ToCurrencyCd)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.Currency
        WHERE
          /* %JoinFKPK(inserted,Sales.Currency) */
          inserted.ToCurrencyCd = Sales.Currency.CurrencyCd
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.CurrencyRate because Sales.Currency does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.Currency  Sales.CurrencyRate on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="Currency"
    CHILD_OWNER="Sales", CHILD_TABLE="CurrencyRate"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Currency_Sales.Curren", FK_COLUMNS="FromCurrencyCd" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(FromCurrencyCd)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.Currency
        WHERE
          /* %JoinFKPK(inserted,Sales.Currency) */
          inserted.FromCurrencyCd = Sales.Currency.CurrencyCd
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.CurrencyRate because Sales.Currency does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tD_Customer ON Sales.Cust FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Cust */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.Cust  Sales.SlsOrdrHeader on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00050e3c", PARENT_OWNER="Sales", PARENT_TABLE="Cust"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Cust_Sales.SlsOrdrHea", FK_COLUMNS="CustID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.CustID = deleted.CustID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Sales.Cust because Sales.SlsOrdrHeader exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsTerritory  Sales.Cust on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="Cust"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Cu", FK_COLUMNS="TerritoryID" */
    IF EXISTS (SELECT * FROM deleted,Sales.SlsTerritory
      WHERE
        /* %JoinFKPK(deleted,Sales.SlsTerritory," = "," AND") */
        deleted.TerritoryID = Sales.SlsTerritory.TerritoryID AND
        NOT EXISTS (
          SELECT * FROM Sales.Cust
          WHERE
            /* %JoinFKPK(Sales.Cust,Sales.SlsTerritory," = "," AND") */
            Sales.Cust.TerritoryID = Sales.SlsTerritory.TerritoryID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.Cust because Sales.SlsTerritory exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.Stor  Sales.Cust on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="Stor"
    CHILD_OWNER="Sales", CHILD_TABLE="Cust"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Stor_Cust", FK_COLUMNS="StorID" */
    IF EXISTS (SELECT * FROM deleted,Sales.Stor
      WHERE
        /* %JoinFKPK(deleted,Sales.Stor," = "," AND") */
        deleted.StorID = Sales.Stor.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Sales.Cust
          WHERE
            /* %JoinFKPK(Sales.Cust,Sales.Stor," = "," AND") */
            Sales.Cust.StorID = Sales.Stor.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.Cust because Sales.Stor exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Person  Sales.Cust on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Sales", CHILD_TABLE="Cust"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_Cust", FK_COLUMNS="PersonID" */
    IF EXISTS (SELECT * FROM deleted,Person.Person
      WHERE
        /* %JoinFKPK(deleted,Person.Person," = "," AND") */
        deleted.PersonID = Person.Person.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Sales.Cust
          WHERE
            /* %JoinFKPK(Sales.Cust,Person.Person," = "," AND") */
            Sales.Cust.PersonID = Person.Person.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.Cust because Person.Person exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_Customer ON Sales.Cust FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Cust */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCustID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.Cust  Sales.SlsOrdrHeader on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0005bfa8", PARENT_OWNER="Sales", PARENT_TABLE="Cust"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Cust_Sales.SlsOrdrHea", FK_COLUMNS="CustID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CustID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeader,deleted," = "," AND") */
        Sales.SlsOrdrHeader.CustID = deleted.CustID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.Cust because Sales.SlsOrdrHeader exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SlsTerritory  Sales.Cust on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="Cust"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Cu", FK_COLUMNS="TerritoryID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(TerritoryID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.SlsTerritory
        WHERE
          /* %JoinFKPK(inserted,Sales.SlsTerritory) */
          inserted.TerritoryID = Sales.SlsTerritory.TerritoryID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.TerritoryID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.Cust because Sales.SlsTerritory does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.Stor  Sales.Cust on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="Stor"
    CHILD_OWNER="Sales", CHILD_TABLE="Cust"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Stor_Cust", FK_COLUMNS="StorID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(StorID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.Stor
        WHERE
          /* %JoinFKPK(inserted,Sales.Stor) */
          inserted.StorID = Sales.Stor.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.StorID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.Cust because Sales.Stor does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.Person  Sales.Cust on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Sales", CHILD_TABLE="Cust"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_Cust", FK_COLUMNS="PersonID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(PersonID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.Person
        WHERE
          /* %JoinFKPK(inserted,Person.Person) */
          inserted.PersonID = Person.Person.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.PersonID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.Cust because Person.Person does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.tD_Department ON HumanResources.Department FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Department */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* HumanResources.Department  HumanResources.EmpDepartmentHist on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00016978", PARENT_OWNER="HumanResources", PARENT_TABLE="Department"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpDepartmentHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_HumanResources.Department_H", FK_COLUMNS="DepartmentID" */
    IF EXISTS (
      SELECT * FROM deleted,HumanResources.EmpDepartmentHist
      WHERE
        /*  %JoinFKPK(HumanResources.EmpDepartmentHist,deleted," = "," AND") */
        HumanResources.EmpDepartmentHist.DepartmentID = deleted.DepartmentID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete HumanResources.Department because HumanResources.EmpDepartmentHist exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.tU_Department ON HumanResources.Department FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Department */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insDepartmentID smallint,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* HumanResources.Department  HumanResources.EmpDepartmentHist on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000181ac", PARENT_OWNER="HumanResources", PARENT_TABLE="Department"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpDepartmentHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_HumanResources.Department_H", FK_COLUMNS="DepartmentID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(DepartmentID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,HumanResources.EmpDepartmentHist
      WHERE
        /*  %JoinFKPK(HumanResources.EmpDepartmentHist,deleted," = "," AND") */
        HumanResources.EmpDepartmentHist.DepartmentID = deleted.DepartmentID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update HumanResources.Department because HumanResources.EmpDepartmentHist exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tD_Document ON Production.Document FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Document */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Production.Document  Production.ProductDocument on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002bb4b", PARENT_OWNER="Production", PARENT_TABLE="Document"
    CHILD_OWNER="Production", CHILD_TABLE="ProductDocument"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Document_Product", FK_COLUMNS="DocumentNode" */
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductDocument
      WHERE
        /*  %JoinFKPK(Production.ProductDocument,deleted," = "," AND") */
        Production.ProductDocument.DocumentNode = deleted.DocumentNode
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Production.Document because Production.ProductDocument exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* HumanResources.Emp  Production.Document on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="Production", CHILD_TABLE="Document"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_Document", FK_COLUMNS="Owner" */
    IF EXISTS (SELECT * FROM deleted,HumanResources.Emp
      WHERE
        /* %JoinFKPK(deleted,HumanResources.Emp," = "," AND") */
        deleted.Owner = HumanResources.Emp.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Production.Document
          WHERE
            /* %JoinFKPK(Production.Document,HumanResources.Emp," = "," AND") */
            Production.Document.Owner = HumanResources.Emp.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Production.Document because HumanResources.Emp exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Production.tU_Document ON Production.Document FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Document */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insDocumentNode hierarchyid,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Production.Document  Production.ProductDocument on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002f9b7", PARENT_OWNER="Production", PARENT_TABLE="Document"
    CHILD_OWNER="Production", CHILD_TABLE="ProductDocument"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Production.Document_Product", FK_COLUMNS="DocumentNode" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(DocumentNode)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.ProductDocument
      WHERE
        /*  %JoinFKPK(Production.ProductDocument,deleted," = "," AND") */
        Production.ProductDocument.DocumentNode = deleted.DocumentNode
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Production.Document because Production.ProductDocument exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* HumanResources.Emp  Production.Document on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="Production", CHILD_TABLE="Document"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_Document", FK_COLUMNS="Owner" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Owner)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,HumanResources.Emp
        WHERE
          /* %JoinFKPK(inserted,HumanResources.Emp) */
          inserted.Owner = HumanResources.Emp.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Production.Document because HumanResources.Emp does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER [iduSalesOrderDetail] ON SlsOrdrDetail
   WITH 
 EXECUTE AS CALLER  AFTER DELETE,INSERT,UPDATE 
  
  AS

BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        -- If inserting or updating these columns
        IF UPDATE([ProductID]) OR UPDATE([OrderQty]) OR UPDATE([UnitPrice]) OR UPDATE([UnitPriceDiscount]) 
        -- Insert record into TransactionHistory
        BEGIN
            INSERT INTO [Production].[TransactionHistory]
                ([ProductID]
                ,[ReferenceOrderID]
                ,[ReferenceOrderLineID]
                ,[TransactionType]
                ,[TransactionDate]
                ,[Quantity]
                ,[ActualCost])
            SELECT 
                inserted.[ProductID]
                ,inserted.[SalesOrderID]
                ,inserted.[SalesOrderDetailID]
                ,'S'
                ,GETDATE()
                ,inserted.[OrderQty]
                ,inserted.[UnitPrice]
            FROM inserted 
                INNER JOIN [Sales].[SalesOrderHeader] 
                ON inserted.[SalesOrderID] = [Sales].[SalesOrderHeader].[SalesOrderID];

            UPDATE [Person].[Person] 
            SET [Demographics].modify('declare default element namespace 
                "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
                replace value of (/IndividualSurvey/TotalPurchaseYTD)[1] 
                with data(/IndividualSurvey/TotalPurchaseYTD)[1] + sql:column ("inserted.LineTotal")') 
            FROM inserted 
                INNER JOIN [Sales].[SalesOrderHeader] AS SOH
                ON inserted.[SalesOrderID] = SOH.[SalesOrderID] 
                INNER JOIN [Sales].[Customer] AS C
                ON SOH.[CustomerID] = C.[CustomerID]
            WHERE C.[PersonID] = [Person].[Person].[BusinessEntityID];
        END;

        -- Update SubTotal in SalesOrderHeader record. Note that this causes the 
        -- SalesOrderHeader trigger to fire which will update the RevisionNumber.
        UPDATE [Sales].[SalesOrderHeader]
        SET [Sales].[SalesOrderHeader].[SubTotal] = 
            (SELECT SUM([Sales].[SalesOrderDetail].[LineTotal])
                FROM [Sales].[SalesOrderDetail]
                WHERE [Sales].[SalesOrderHeader].[SalesOrderID] = [Sales].[SalesOrderDetail].[SalesOrderID])
        WHERE [Sales].[SalesOrderHeader].[SalesOrderID] IN (SELECT inserted.[SalesOrderID] FROM inserted);

        UPDATE [Person].[Person] 
        SET [Demographics].modify('declare default element namespace 
            "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
            replace value of (/IndividualSurvey/TotalPurchaseYTD)[1] 
            with data(/IndividualSurvey/TotalPurchaseYTD)[1] - sql:column("deleted.LineTotal")') 
        FROM deleted 
            INNER JOIN [Sales].[SalesOrderHeader] 
            ON deleted.[SalesOrderID] = [Sales].[SalesOrderHeader].[SalesOrderID] 
            INNER JOIN [Sales].[Customer]
            ON [Sales].[Customer].[CustomerID] = [Sales].[SalesOrderHeader].[CustomerID]
        WHERE [Sales].[Customer].[PersonID] = [Person].[Person].[BusinessEntityID];
    END TRY
    BEGIN CATCH
        EXECUTE [dbo].[uspPrintError];

        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;

 
go


ENABLE TRIGGER [iduSalesOrderDetail] ON SlsOrdrDetail
go

CREATE TRIGGER Sales.tD_SalesOrderDetail ON Sales.SlsOrdrDetail FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on SlsOrdrDetail */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.SpecialOfferProduct  Sales.SlsOrdrDetail on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00038535", PARENT_OWNER="Sales", PARENT_TABLE="SpecialOfferProduct"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SpecialOfferProduct_S", FK_COLUMNS="SpecialOfferID""ProductID" */
    IF EXISTS (SELECT * FROM deleted,Sales.SpecialOfferProduct
      WHERE
        /* %JoinFKPK(deleted,Sales.SpecialOfferProduct," = "," AND") */
        deleted.SpecialOfferID = Sales.SpecialOfferProduct.SpecialOfferID AND
        deleted.ProductID = Sales.SpecialOfferProduct.ProductID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsOrdrDetail
          WHERE
            /* %JoinFKPK(Sales.SlsOrdrDetail,Sales.SpecialOfferProduct," = "," AND") */
            Sales.SlsOrdrDetail.SpecialOfferID = Sales.SpecialOfferProduct.SpecialOfferID AND
            Sales.SlsOrdrDetail.ProductID = Sales.SpecialOfferProduct.ProductID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsOrdrDetail because Sales.SpecialOfferProduct exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsOrdrHeader  Sales.SlsOrdrDetail on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsOrdrHeader"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsOrdrHeader_Sales.S", FK_COLUMNS="SlsOrdrID" */
    IF EXISTS (SELECT * FROM deleted,Sales.SlsOrdrHeader
      WHERE
        /* %JoinFKPK(deleted,Sales.SlsOrdrHeader," = "," AND") */
        deleted.SlsOrdrID = Sales.SlsOrdrHeader.SlsOrdrID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsOrdrDetail
          WHERE
            /* %JoinFKPK(Sales.SlsOrdrDetail,Sales.SlsOrdrHeader," = "," AND") */
            Sales.SlsOrdrDetail.SlsOrdrID = Sales.SlsOrdrHeader.SlsOrdrID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsOrdrDetail because Sales.SlsOrdrHeader exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_SalesOrderDetail ON Sales.SlsOrdrDetail FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsOrdrDetail */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSlsOrdrID int, 
           @insSlsOrdrDetailID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.SpecialOfferProduct  Sales.SlsOrdrDetail on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00035ce3", PARENT_OWNER="Sales", PARENT_TABLE="SpecialOfferProduct"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SpecialOfferProduct_S", FK_COLUMNS="SpecialOfferID""ProductID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(SpecialOfferID) OR
    UPDATE(ProductID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.SpecialOfferProduct
        WHERE
          /* %JoinFKPK(inserted,Sales.SpecialOfferProduct) */
          inserted.SpecialOfferID = Sales.SpecialOfferProduct.SpecialOfferID and
          inserted.ProductID = Sales.SpecialOfferProduct.ProductID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsOrdrDetail because Sales.SpecialOfferProduct does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Sales.SlsOrdrHeader  Sales.SlsOrdrDetail on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsOrdrHeader"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsOrdrHeader_Sales.S", FK_COLUMNS="SlsOrdrID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(SlsOrdrID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.SlsOrdrHeader
        WHERE
          /* %JoinFKPK(inserted,Sales.SlsOrdrHeader) */
          inserted.SlsOrdrID = Sales.SlsOrdrHeader.SlsOrdrID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsOrdrDetail because Sales.SlsOrdrHeader does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tD_EmailAddress ON Person.EmailAddr FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on EmailAddr */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.Person  Person.EmailAddr on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00018322", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="EmailAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_EmailAddr", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,Person.Person
      WHERE
        /* %JoinFKPK(deleted,Person.Person," = "," AND") */
        deleted.BusinessEntityID = Person.Person.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Person.EmailAddr
          WHERE
            /* %JoinFKPK(Person.EmailAddr,Person.Person," = "," AND") */
            Person.EmailAddr.BusinessEntityID = Person.Person.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Person.EmailAddr because Person.Person exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Person.tU_EmailAddress ON Person.EmailAddr FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on EmailAddr */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int, 
           @insEmailAddrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.Person  Person.EmailAddr on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00018c68", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="Person", CHILD_TABLE="EmailAddr"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_EmailAddr", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.Person
        WHERE
          /* %JoinFKPK(inserted,Person.Person) */
          inserted.BusinessEntityID = Person.Person.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Person.EmailAddr because Person.Person does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER [dEmployee] ON Emp
   WITH 
 EXECUTE AS CALLER  INSTEAD OF DELETE 
 
 NOT FOR REPLICATION 
  AS

BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN
        RAISERROR
            (N'Employees cannot be deleted. They can only be marked as not current.', -- Message
            10, -- Severity.
            1); -- State.

        -- Rollback any active or uncommittable transactions
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
    END;
END;

 
go


ENABLE TRIGGER [dEmployee] ON Emp
go

CREATE TRIGGER HumanResources.tU_Employee ON HumanResources.Emp FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Emp */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* HumanResources.Emp  HumanResources.EmpDepartmentHist on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0009740d", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpDepartmentHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_EmpDepartmentHist", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,HumanResources.EmpDepartmentHist
      WHERE
        /*  %JoinFKPK(HumanResources.EmpDepartmentHist,deleted," = "," AND") */
        HumanResources.EmpDepartmentHist.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update HumanResources.Emp because HumanResources.EmpDepartmentHist exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* HumanResources.Emp  Production.Document on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="Production", CHILD_TABLE="Document"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_Document", FK_COLUMNS="Owner" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Production.Document
      WHERE
        /*  %JoinFKPK(Production.Document,deleted," = "," AND") */
        Production.Document.Owner = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update HumanResources.Emp because Production.Document exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* HumanResources.Emp  Purchasing.PurchaseOrdrHeader on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_PurchaseOrdrHeader", FK_COLUMNS="EmpID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.PurchaseOrdrHeader
      WHERE
        /*  %JoinFKPK(Purchasing.PurchaseOrdrHeader,deleted," = "," AND") */
        Purchasing.PurchaseOrdrHeader.EmpID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update HumanResources.Emp because Purchasing.PurchaseOrdrHeader exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* HumanResources.Emp  HumanResources.JobCandiDt on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="HumanResources", CHILD_TABLE="JobCandiDt"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_JobCandiDt", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,HumanResources.JobCandiDt
      WHERE
        /*  %JoinFKPK(HumanResources.JobCandiDt,deleted," = "," AND") */
        HumanResources.JobCandiDt.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update HumanResources.Emp because HumanResources.JobCandiDt exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* HumanResources.Emp  Sales.SlsPerson on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsPerson"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_SlsPerson", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsPerson
      WHERE
        /*  %JoinFKPK(Sales.SlsPerson,deleted," = "," AND") */
        Sales.SlsPerson.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update HumanResources.Emp because Sales.SlsPerson exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* HumanResources.Emp  HumanResources.EmpPayHist on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpPayHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_EmpPayHist", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,HumanResources.EmpPayHist
      WHERE
        /*  %JoinFKPK(HumanResources.EmpPayHist,deleted," = "," AND") */
        HumanResources.EmpPayHist.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update HumanResources.Emp because HumanResources.EmpPayHist exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Person.Person  HumanResources.Emp on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="HumanResources", CHILD_TABLE="Emp"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_Emp", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.Person
        WHERE
          /* %JoinFKPK(inserted,Person.Person) */
          inserted.BusinessEntityID = Person.Person.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update HumanResources.Emp because Person.Person does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.Trigger_2977 ON HumanResources.Emp FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Emp */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* HumanResources.Emp  HumanResources.EmpPayHist on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000152f2", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpPayHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_EmpPayHist", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,HumanResources.EmpPayHist
      WHERE
        /*  %JoinFKPK(HumanResources.EmpPayHist,deleted," = "," AND") */
        HumanResources.EmpPayHist.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete HumanResources.Emp because HumanResources.EmpPayHist exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.Trigger_2990 ON HumanResources.Emp FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Emp */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* HumanResources.Emp  Sales.SlsPerson on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000134a3", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsPerson"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_SlsPerson", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsPerson
      WHERE
        /*  %JoinFKPK(Sales.SlsPerson,deleted," = "," AND") */
        Sales.SlsPerson.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete HumanResources.Emp because Sales.SlsPerson exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.Trigger_2991 ON HumanResources.Emp FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Emp */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* HumanResources.Emp  HumanResources.JobCandiDt on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00015558", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="HumanResources", CHILD_TABLE="JobCandiDt"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_JobCandiDt", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,HumanResources.JobCandiDt
      WHERE
        /*  %JoinFKPK(HumanResources.JobCandiDt,deleted," = "," AND") */
        HumanResources.JobCandiDt.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete HumanResources.Emp because HumanResources.JobCandiDt exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.Trigger_3105 ON HumanResources.Emp FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Emp */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* HumanResources.Emp  Purchasing.PurchaseOrdrHeader on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000152ad", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="Purchasing", CHILD_TABLE="PurchaseOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_PurchaseOrdrHeader", FK_COLUMNS="EmpID" */
    IF EXISTS (
      SELECT * FROM deleted,Purchasing.PurchaseOrdrHeader
      WHERE
        /*  %JoinFKPK(Purchasing.PurchaseOrdrHeader,deleted," = "," AND") */
        Purchasing.PurchaseOrdrHeader.EmpID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete HumanResources.Emp because Purchasing.PurchaseOrdrHeader exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.Trigger_3116 ON HumanResources.Emp FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Emp */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* HumanResources.Emp  Production.Document on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00012d22", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="Production", CHILD_TABLE="Document"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_Document", FK_COLUMNS="Owner" */
    IF EXISTS (
      SELECT * FROM deleted,Production.Document
      WHERE
        /*  %JoinFKPK(Production.Document,deleted," = "," AND") */
        Production.Document.Owner = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete HumanResources.Emp because Production.Document exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.Trigger_3121 ON HumanResources.Emp FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Emp */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Person.Person  HumanResources.Emp on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000173fd", PARENT_OWNER="Person", PARENT_TABLE="Person"
    CHILD_OWNER="HumanResources", CHILD_TABLE="Emp"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person_Emp", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,Person.Person
      WHERE
        /* %JoinFKPK(deleted,Person.Person," = "," AND") */
        deleted.BusinessEntityID = Person.Person.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM HumanResources.Emp
          WHERE
            /* %JoinFKPK(HumanResources.Emp,Person.Person," = "," AND") */
            HumanResources.Emp.BusinessEntityID = Person.Person.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last HumanResources.Emp because Person.Person exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.Trigger_3130 ON HumanResources.Emp FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Emp */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* HumanResources.Emp  HumanResources.EmpDepartmentHist on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00016359", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpDepartmentHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_EmpDepartmentHist", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (
      SELECT * FROM deleted,HumanResources.EmpDepartmentHist
      WHERE
        /*  %JoinFKPK(HumanResources.EmpDepartmentHist,deleted," = "," AND") */
        HumanResources.EmpDepartmentHist.BusinessEntityID = deleted.BusinessEntityID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete HumanResources.Emp because HumanResources.EmpDepartmentHist exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER [uSalesOrderHeader] ON SlsOrdrHeader
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
 
 NOT FOR REPLICATION 
  AS

BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        -- Update RevisionNumber for modification of any field EXCEPT the Status.
        IF NOT UPDATE([Status])
        BEGIN
            UPDATE [Sales].[SalesOrderHeader]
            SET [Sales].[SalesOrderHeader].[RevisionNumber] = 
                [Sales].[SalesOrderHeader].[RevisionNumber] + 1
            WHERE [Sales].[SalesOrderHeader].[SalesOrderID] IN 
                (SELECT inserted.[SalesOrderID] FROM inserted);
        END;

        -- Update the SalesPerson SalesYTD when SubTotal is updated
        IF UPDATE([SubTotal])
        BEGIN
            DECLARE @StartDate datetime,
                    @EndDate datetime

            SET @StartDate = [dbo].[ufnGetAccountingStartDate]();
            SET @EndDate = [dbo].[ufnGetAccountingEndDate]();

            UPDATE [Sales].[SalesPerson]
            SET [Sales].[SalesPerson].[SalesYTD] = 
                (SELECT SUM([Sales].[SalesOrderHeader].[SubTotal])
                FROM [Sales].[SalesOrderHeader] 
                WHERE [Sales].[SalesPerson].[BusinessEntityID] = [Sales].[SalesOrderHeader].[SalesPersonID]
                    AND ([Sales].[SalesOrderHeader].[Status] = 5) -- Shipped
                    AND [Sales].[SalesOrderHeader].[OrderDate] BETWEEN @StartDate AND @EndDate)
            WHERE [Sales].[SalesPerson].[BusinessEntityID] 
                IN (SELECT DISTINCT inserted.[SalesPersonID] FROM inserted 
                    WHERE inserted.[OrderDate] BETWEEN @StartDate AND @EndDate);

            -- Update the SalesTerritory SalesYTD when SubTotal is updated
            UPDATE [Sales].[SalesTerritory]
            SET [Sales].[SalesTerritory].[SalesYTD] = 
                (SELECT SUM([Sales].[SalesOrderHeader].[SubTotal])
                FROM [Sales].[SalesOrderHeader] 
                WHERE [Sales].[SalesTerritory].[TerritoryID] = [Sales].[SalesOrderHeader].[TerritoryID]
                    AND ([Sales].[SalesOrderHeader].[Status] = 5) -- Shipped
                    AND [Sales].[SalesOrderHeader].[OrderDate] BETWEEN @StartDate AND @EndDate)
            WHERE [Sales].[SalesTerritory].[TerritoryID] 
                IN (SELECT DISTINCT inserted.[TerritoryID] FROM inserted 
                    WHERE inserted.[OrderDate] BETWEEN @StartDate AND @EndDate);
        END;
    END TRY
    BEGIN CATCH
        EXECUTE [dbo].[uspPrintError];

        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;

 
go


ENABLE TRIGGER [uSalesOrderHeader] ON SlsOrdrHeader
go

CREATE TRIGGER Sales.tD_SalesOrderHeader ON Sales.SlsOrdrHeader FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on SlsOrdrHeader */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Sales.SlsOrdrHeader  Sales.SlsOrdrDetail on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="000d84d7", PARENT_OWNER="Sales", PARENT_TABLE="SlsOrdrHeader"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsOrdrHeader_Sales.S", FK_COLUMNS="SlsOrdrID" */
    DELETE Sales.SlsOrdrDetail
      FROM Sales.SlsOrdrDetail,deleted
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrDetail,deleted," = "," AND") */
        Sales.SlsOrdrDetail.SlsOrdrID = deleted.SlsOrdrID

    /* erwin Builtin Trigger */
    /* Sales.SlsOrdrHeader  Sales.SlsOrdrHeaderSlsReason on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsOrdrHeader"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeaderSlsReason"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsOrdrHeader_Sales.S", FK_COLUMNS="SlsOrdrID" */
    DELETE Sales.SlsOrdrHeaderSlsReason
      FROM Sales.SlsOrdrHeaderSlsReason,deleted
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeaderSlsReason,deleted," = "," AND") */
        Sales.SlsOrdrHeaderSlsReason.SlsOrdrID = deleted.SlsOrdrID

    /* erwin Builtin Trigger */
    /* Sales.SlsTerritory  Sales.SlsOrdrHeader on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Sl", FK_COLUMNS="TerritoryID" */
    IF EXISTS (SELECT * FROM deleted,Sales.SlsTerritory
      WHERE
        /* %JoinFKPK(deleted,Sales.SlsTerritory," = "," AND") */
        deleted.TerritoryID = Sales.SlsTerritory.TerritoryID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsOrdrHeader
          WHERE
            /* %JoinFKPK(Sales.SlsOrdrHeader,Sales.SlsTerritory," = "," AND") */
            Sales.SlsOrdrHeader.TerritoryID = Sales.SlsTerritory.TerritoryID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsOrdrHeader because Sales.SlsTerritory exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Purchasing.ShipMethod  Sales.SlsOrdrHeader on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Purchasing", PARENT_TABLE="ShipMethod"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchasing.ShipMethod_Sales", FK_COLUMNS="ShipMethodID" */
    IF EXISTS (SELECT * FROM deleted,Purchasing.ShipMethod
      WHERE
        /* %JoinFKPK(deleted,Purchasing.ShipMethod," = "," AND") */
        deleted.ShipMethodID = Purchasing.ShipMethod.ShipMethodID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsOrdrHeader
          WHERE
            /* %JoinFKPK(Sales.SlsOrdrHeader,Purchasing.ShipMethod," = "," AND") */
            Sales.SlsOrdrHeader.ShipMethodID = Purchasing.ShipMethod.ShipMethodID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsOrdrHeader because Purchasing.ShipMethod exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.SlsPerson  Sales.SlsOrdrHeader on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_SlsOrdrHeader", FK_COLUMNS="SlsPersonID" */
    IF EXISTS (SELECT * FROM deleted,Sales.SlsPerson
      WHERE
        /* %JoinFKPK(deleted,Sales.SlsPerson," = "," AND") */
        deleted.SlsPersonID = Sales.SlsPerson.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsOrdrHeader
          WHERE
            /* %JoinFKPK(Sales.SlsOrdrHeader,Sales.SlsPerson," = "," AND") */
            Sales.SlsOrdrHeader.SlsPersonID = Sales.SlsPerson.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsOrdrHeader because Sales.SlsPerson exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.Cust  Sales.SlsOrdrHeader on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="Cust"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Cust_Sales.SlsOrdrHea", FK_COLUMNS="CustID" */
    IF EXISTS (SELECT * FROM deleted,Sales.Cust
      WHERE
        /* %JoinFKPK(deleted,Sales.Cust," = "," AND") */
        deleted.CustID = Sales.Cust.CustID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsOrdrHeader
          WHERE
            /* %JoinFKPK(Sales.SlsOrdrHeader,Sales.Cust," = "," AND") */
            Sales.SlsOrdrHeader.CustID = Sales.Cust.CustID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsOrdrHeader because Sales.Cust exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.CurrencyRate  Sales.SlsOrdrHeader on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="CurrencyRate"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.CurrencyRate_Sales.Sl", FK_COLUMNS="CurrencyRateID" */
    IF EXISTS (SELECT * FROM deleted,Sales.CurrencyRate
      WHERE
        /* %JoinFKPK(deleted,Sales.CurrencyRate," = "," AND") */
        deleted.CurrencyRateID = Sales.CurrencyRate.CurrencyRateID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsOrdrHeader
          WHERE
            /* %JoinFKPK(Sales.SlsOrdrHeader,Sales.CurrencyRate," = "," AND") */
            Sales.SlsOrdrHeader.CurrencyRateID = Sales.CurrencyRate.CurrencyRateID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsOrdrHeader because Sales.CurrencyRate exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Sales.CrdCard  Sales.SlsOrdrHeader on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Sales", PARENT_TABLE="CrdCard"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.CrdCard_Sales.SlsOrdr", FK_COLUMNS="CrdCardID" */
    IF EXISTS (SELECT * FROM deleted,Sales.CrdCard
      WHERE
        /* %JoinFKPK(deleted,Sales.CrdCard," = "," AND") */
        deleted.CrdCardID = Sales.CrdCard.CrdCardID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsOrdrHeader
          WHERE
            /* %JoinFKPK(Sales.SlsOrdrHeader,Sales.CrdCard," = "," AND") */
            Sales.SlsOrdrHeader.CrdCardID = Sales.CrdCard.CrdCardID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsOrdrHeader because Sales.CrdCard exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Addr  Sales.SlsOrdrHeader on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Addr"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.Addr_Sales.SlsOrdrHe", FK_COLUMNS="ShipToAddrID" */
    IF EXISTS (SELECT * FROM deleted,Person.Addr
      WHERE
        /* %JoinFKPK(deleted,Person.Addr," = "," AND") */
        deleted.ShipToAddrID = Person.Addr.AddrID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsOrdrHeader
          WHERE
            /* %JoinFKPK(Sales.SlsOrdrHeader,Person.Addr," = "," AND") */
            Sales.SlsOrdrHeader.ShipToAddrID = Person.Addr.AddrID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsOrdrHeader because Person.Addr exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Person.Addr  Sales.SlsOrdrHeader on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="Person", PARENT_TABLE="Addr"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.Addr_Sales.SlsOrdrHe", FK_COLUMNS="BillToAddrID" */
    IF EXISTS (SELECT * FROM deleted,Person.Addr
      WHERE
        /* %JoinFKPK(deleted,Person.Addr," = "," AND") */
        deleted.BillToAddrID = Person.Addr.AddrID AND
        NOT EXISTS (
          SELECT * FROM Sales.SlsOrdrHeader
          WHERE
            /* %JoinFKPK(Sales.SlsOrdrHeader,Person.Addr," = "," AND") */
            Sales.SlsOrdrHeader.BillToAddrID = Person.Addr.AddrID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Sales.SlsOrdrHeader because Person.Addr exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.tU_SalesOrderHeader ON Sales.SlsOrdrHeader FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsOrdrHeader */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSlsOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.SlsOrdrHeader  Sales.SlsOrdrHeaderSlsReason on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00017703", PARENT_OWNER="Sales", PARENT_TABLE="SlsOrdrHeader"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeaderSlsReason"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsOrdrHeader_Sales.S", FK_COLUMNS="SlsOrdrID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(SlsOrdrID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrHeaderSlsReason
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrHeaderSlsReason,deleted," = "," AND") */
        Sales.SlsOrdrHeaderSlsReason.SlsOrdrID = deleted.SlsOrdrID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.SlsOrdrHeader because Sales.SlsOrdrHeaderSlsReason exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.Trigger_3117 ON Sales.SlsOrdrHeader FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsOrdrHeader */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSlsOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.SlsOrdrHeader  Sales.SlsOrdrDetail on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00015fa7", PARENT_OWNER="Sales", PARENT_TABLE="SlsOrdrHeader"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrDetail"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsOrdrHeader_Sales.S", FK_COLUMNS="SlsOrdrID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(SlsOrdrID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Sales.SlsOrdrDetail
      WHERE
        /*  %JoinFKPK(Sales.SlsOrdrDetail,deleted," = "," AND") */
        Sales.SlsOrdrDetail.SlsOrdrID = deleted.SlsOrdrID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Sales.SlsOrdrHeader because Sales.SlsOrdrDetail exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.Trigger_3122 ON Sales.SlsOrdrHeader FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsOrdrHeader */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSlsOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.Addr  Sales.SlsOrdrHeader on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00018d00", PARENT_OWNER="Person", PARENT_TABLE="Addr"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.Addr_Sales.SlsOrdrHe", FK_COLUMNS="BillToAddrID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BillToAddrID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.Addr
        WHERE
          /* %JoinFKPK(inserted,Person.Addr) */
          inserted.BillToAddrID = Person.Addr.AddrID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsOrdrHeader because Person.Addr does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.Trigger_3123 ON Sales.SlsOrdrHeader FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsOrdrHeader */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSlsOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Person.Addr  Sales.SlsOrdrHeader on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001899d", PARENT_OWNER="Person", PARENT_TABLE="Addr"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Person.Addr_Sales.SlsOrdrHe", FK_COLUMNS="ShipToAddrID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ShipToAddrID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Person.Addr
        WHERE
          /* %JoinFKPK(inserted,Person.Addr) */
          inserted.ShipToAddrID = Person.Addr.AddrID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsOrdrHeader because Person.Addr does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.Trigger_3124 ON Sales.SlsOrdrHeader FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsOrdrHeader */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSlsOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.CrdCard  Sales.SlsOrdrHeader on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001b1f1", PARENT_OWNER="Sales", PARENT_TABLE="CrdCard"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.CrdCard_Sales.SlsOrdr", FK_COLUMNS="CrdCardID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CrdCardID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.CrdCard
        WHERE
          /* %JoinFKPK(inserted,Sales.CrdCard) */
          inserted.CrdCardID = Sales.CrdCard.CrdCardID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.CrdCardID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsOrdrHeader because Sales.CrdCard does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.Trigger_3125 ON Sales.SlsOrdrHeader FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsOrdrHeader */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSlsOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.CurrencyRate  Sales.SlsOrdrHeader on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001cfc4", PARENT_OWNER="Sales", PARENT_TABLE="CurrencyRate"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.CurrencyRate_Sales.Sl", FK_COLUMNS="CurrencyRateID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CurrencyRateID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.CurrencyRate
        WHERE
          /* %JoinFKPK(inserted,Sales.CurrencyRate) */
          inserted.CurrencyRateID = Sales.CurrencyRate.CurrencyRateID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.CurrencyRateID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsOrdrHeader because Sales.CurrencyRate does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.Trigger_3126 ON Sales.SlsOrdrHeader FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsOrdrHeader */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSlsOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.Cust  Sales.SlsOrdrHeader on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000176f3", PARENT_OWNER="Sales", PARENT_TABLE="Cust"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.Cust_Sales.SlsOrdrHea", FK_COLUMNS="CustID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CustID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.Cust
        WHERE
          /* %JoinFKPK(inserted,Sales.Cust) */
          inserted.CustID = Sales.Cust.CustID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsOrdrHeader because Sales.Cust does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.Trigger_3127 ON Sales.SlsOrdrHeader FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsOrdrHeader */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSlsOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.SlsPerson  Sales.SlsOrdrHeader on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001b3e4", PARENT_OWNER="Sales", PARENT_TABLE="SlsPerson"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_SlsPerson_SlsOrdrHeader", FK_COLUMNS="SlsPersonID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(SlsPersonID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.SlsPerson
        WHERE
          /* %JoinFKPK(inserted,Sales.SlsPerson) */
          inserted.SlsPersonID = Sales.SlsPerson.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.SlsPersonID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsOrdrHeader because Sales.SlsPerson does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.Trigger_3128 ON Sales.SlsOrdrHeader FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsOrdrHeader */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSlsOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Purchasing.ShipMethod  Sales.SlsOrdrHeader on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00019de7", PARENT_OWNER="Purchasing", PARENT_TABLE="ShipMethod"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Purchasing.ShipMethod_Sales", FK_COLUMNS="ShipMethodID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ShipMethodID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Purchasing.ShipMethod
        WHERE
          /* %JoinFKPK(inserted,Purchasing.ShipMethod) */
          inserted.ShipMethodID = Purchasing.ShipMethod.ShipMethodID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsOrdrHeader because Purchasing.ShipMethod does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER Sales.Trigger_3129 ON Sales.SlsOrdrHeader FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on SlsOrdrHeader */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insSlsOrdrID int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Sales.SlsTerritory  Sales.SlsOrdrHeader on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0001b132", PARENT_OWNER="Sales", PARENT_TABLE="SlsTerritory"
    CHILD_OWNER="Sales", CHILD_TABLE="SlsOrdrHeader"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Sales.SlsTerritory_Sales.Sl", FK_COLUMNS="TerritoryID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(TerritoryID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Sales.SlsTerritory
        WHERE
          /* %JoinFKPK(inserted,Sales.SlsTerritory) */
          inserted.TerritoryID = Sales.SlsTerritory.TerritoryID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.TerritoryID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Sales.SlsOrdrHeader because Sales.SlsTerritory does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.tD_EmployeeDepartmentHistory ON HumanResources.EmpDepartmentHist FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on EmpDepartmentHist */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* HumanResources.Shift  HumanResources.EmpDepartmentHist on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00051c50", PARENT_OWNER="HumanResources", PARENT_TABLE="Shift"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpDepartmentHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_HumanResources.Shift_HumanR", FK_COLUMNS="ShiftID" */
    IF EXISTS (SELECT * FROM deleted,HumanResources.Shift
      WHERE
        /* %JoinFKPK(deleted,HumanResources.Shift," = "," AND") */
        deleted.ShiftID = HumanResources.Shift.ShiftID AND
        NOT EXISTS (
          SELECT * FROM HumanResources.EmpDepartmentHist
          WHERE
            /* %JoinFKPK(HumanResources.EmpDepartmentHist,HumanResources.Shift," = "," AND") */
            HumanResources.EmpDepartmentHist.ShiftID = HumanResources.Shift.ShiftID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last HumanResources.EmpDepartmentHist because HumanResources.Shift exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* HumanResources.Emp  HumanResources.EmpDepartmentHist on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpDepartmentHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_EmpDepartmentHist", FK_COLUMNS="BusinessEntityID" */
    IF EXISTS (SELECT * FROM deleted,HumanResources.Emp
      WHERE
        /* %JoinFKPK(deleted,HumanResources.Emp," = "," AND") */
        deleted.BusinessEntityID = HumanResources.Emp.BusinessEntityID AND
        NOT EXISTS (
          SELECT * FROM HumanResources.EmpDepartmentHist
          WHERE
            /* %JoinFKPK(HumanResources.EmpDepartmentHist,HumanResources.Emp," = "," AND") */
            HumanResources.EmpDepartmentHist.BusinessEntityID = HumanResources.Emp.BusinessEntityID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last HumanResources.EmpDepartmentHist because HumanResources.Emp exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* HumanResources.Department  HumanResources.EmpDepartmentHist on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="HumanResources", PARENT_TABLE="Department"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpDepartmentHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_HumanResources.Department_H", FK_COLUMNS="DepartmentID" */
    IF EXISTS (SELECT * FROM deleted,HumanResources.Department
      WHERE
        /* %JoinFKPK(deleted,HumanResources.Department," = "," AND") */
        deleted.DepartmentID = HumanResources.Department.DepartmentID AND
        NOT EXISTS (
          SELECT * FROM HumanResources.EmpDepartmentHist
          WHERE
            /* %JoinFKPK(HumanResources.EmpDepartmentHist,HumanResources.Department," = "," AND") */
            HumanResources.EmpDepartmentHist.DepartmentID = HumanResources.Department.DepartmentID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last HumanResources.EmpDepartmentHist because HumanResources.Department exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER HumanResources.tU_EmployeeDepartmentHistory ON HumanResources.EmpDepartmentHist FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on EmpDepartmentHist */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insBusinessEntityID int, 
           @insDepartmentID smallint, 
           @insShiftID tinyint, 
           @insStartDt date,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* HumanResources.Shift  HumanResources.EmpDepartmentHist on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0004e9fe", PARENT_OWNER="HumanResources", PARENT_TABLE="Shift"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpDepartmentHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_HumanResources.Shift_HumanR", FK_COLUMNS="ShiftID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ShiftID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,HumanResources.Shift
        WHERE
          /* %JoinFKPK(inserted,HumanResources.Shift) */
          inserted.ShiftID = HumanResources.Shift.ShiftID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update HumanResources.EmpDepartmentHist because HumanResources.Shift does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* HumanResources.Emp  HumanResources.EmpDepartmentHist on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="HumanResources", PARENT_TABLE="Emp"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpDepartmentHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Emp_EmpDepartmentHist", FK_COLUMNS="BusinessEntityID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BusinessEntityID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,HumanResources.Emp
        WHERE
          /* %JoinFKPK(inserted,HumanResources.Emp) */
          inserted.BusinessEntityID = HumanResources.Emp.BusinessEntityID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update HumanResources.EmpDepartmentHist because HumanResources.Emp does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* HumanResources.Department  HumanResources.EmpDepartmentHist on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="HumanResources", PARENT_TABLE="Department"
    CHILD_OWNER="HumanResources", CHILD_TABLE="EmpDepartmentHist"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_HumanResources.Department_H", FK_COLUMNS="DepartmentID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(DepartmentID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,HumanResources.Department
        WHERE
          /* %JoinFKPK(inserted,HumanResources.Department) */
          inserted.DepartmentID = HumanResources.Department.DepartmentID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update HumanResources.EmpDepartmentHist because HumanResources.Department does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go



