USE [master]
GO
/****** Object:  Database [SmartCloud]    Script Date: 03/28/2013 10:48:46 ******/
CREATE DATABASE [SmartCloud] ON  PRIMARY 
( NAME = N'SmartCloud', FILENAME = N'D:\SQL_Data\SQL_Data_BTS2\SmartCloud.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'SmartCloud_log', FILENAME = N'D:\SQL_Logs\SQL_Logs_BTS2\SmartCloud_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SmartCloud] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SmartCloud].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SmartCloud] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [SmartCloud] SET ANSI_NULLS OFF
GO
ALTER DATABASE [SmartCloud] SET ANSI_PADDING OFF
GO
ALTER DATABASE [SmartCloud] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [SmartCloud] SET ARITHABORT OFF
GO
ALTER DATABASE [SmartCloud] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [SmartCloud] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [SmartCloud] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [SmartCloud] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [SmartCloud] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [SmartCloud] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [SmartCloud] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [SmartCloud] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [SmartCloud] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [SmartCloud] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [SmartCloud] SET  DISABLE_BROKER
GO
ALTER DATABASE [SmartCloud] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [SmartCloud] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [SmartCloud] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [SmartCloud] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [SmartCloud] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [SmartCloud] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [SmartCloud] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [SmartCloud] SET  READ_WRITE
GO
ALTER DATABASE [SmartCloud] SET RECOVERY FULL
GO
ALTER DATABASE [SmartCloud] SET  MULTI_USER
GO
ALTER DATABASE [SmartCloud] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [SmartCloud] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'SmartCloud', N'ON'
GO
USE [SmartCloud]
GO
/****** Object:  Schema [Security]    Script Date: 03/28/2013 10:48:46 ******/
CREATE SCHEMA [Security] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [Schedule]    Script Date: 03/28/2013 10:48:46 ******/
CREATE SCHEMA [Schedule] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [Logging]    Script Date: 03/28/2013 10:48:46 ******/
CREATE SCHEMA [Logging] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [Eventing]    Script Date: 03/28/2013 10:48:46 ******/
CREATE SCHEMA [Eventing] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [Configuration]    Script Date: 03/28/2013 10:48:46 ******/
CREATE SCHEMA [Configuration] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [BusinessRule]    Script Date: 03/28/2013 10:48:46 ******/
CREATE SCHEMA [BusinessRule] AUTHORIZATION [dbo]
GO
/****** Object:  Table [Schedule].[Zone]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Schedule].[Zone](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Schedule] [int] NOT NULL,
	[Id_Zone] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Configuration].[Zone]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Configuration].[Zone](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DateAdded] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[SmartCloudSerial] [nvarchar](500) NULL,
 CONSTRAINT [PK_Zone] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Security].[UserActivity]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Security].[UserActivity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SecurityToken] [nvarchar](500) NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_UserActivity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Schedule].[PriorityRule]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Schedule].[PriorityRule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Schedule] [int] NOT NULL,
	[Priority] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [BusinessRule].[PriorityRule]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BusinessRule].[PriorityRule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_RuleSet] [int] NOT NULL,
	[Priority] [nvarchar](100) NOT NULL,
	[Id_Rule] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [BusinessRule].[Operator]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BusinessRule].[Operator](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Logging].[LogType]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Logging].[LogType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_LogType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Security].[Role]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Security].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[SmartCloudSerial] [nvarchar](500) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [BusinessRule].[Result]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BusinessRule].[Result](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Configuration].[Status]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Configuration].[Status](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Schedule].[Schedule]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Schedule].[Schedule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[StartTime] [nvarchar](10) NOT NULL,
	[EndTime] [nvarchar](10) NOT NULL,
	[ElapseTime] [int] NOT NULL,
	[DateAdded] [datetime] NOT NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [BusinessRule].[RuleSet]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BusinessRule].[RuleSet](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Version] [nvarchar](10) NOT NULL,
	[DateAdded] [datetime] NOT NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_RuleSet] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Logging].[Log]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Logging].[Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_LogType] [int] NOT NULL,
	[Originator] [nvarchar](100) NOT NULL,
	[Fault] [nvarchar](max) NOT NULL,
	[DateTimeAdded] [datetime] NOT NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [BusinessRule].[Load]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BusinessRule].[Load](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CurrentLoad] [int] NOT NULL,
	[MaximumLoad] [int] NOT NULL,
	[ManualLoad] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Configuration].[DeviceStatus]    Script Date: 03/28/2013 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Configuration].[DeviceStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Device] [int] NOT NULL,
	[Id_Status] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Eventing].[DeviceEvents]    Script Date: 03/28/2013 10:48:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Eventing].[DeviceEvents](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Serial] [nvarchar](500) NOT NULL,
	[Event] [text] NOT NULL,
 CONSTRAINT [PK_DeviceEvents] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Security].[Device]    Script Date: 03/28/2013 10:48:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Security].[Device](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SmartCloudSerial] [nvarchar](500) NOT NULL,
	[SessionToken] [nvarchar](500) NULL,
 CONSTRAINT [PK_Device_3] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Logging].[CurrentStatus]    Script Date: 03/28/2013 10:48:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Logging].[CurrentStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UnitName] [nvarchar](200) NOT NULL,
	[Status] [nvarchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [BusinessRule].[Condition]    Script Date: 03/28/2013 10:48:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BusinessRule].[Condition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [Security].[ClearUserActivity]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [Security].[ClearUserActivity]
AS

DECLARE @CacheInterval INT

SET @CacheInterval = 10

  UPDATE
             [Security].[Device]
  SET
			SessionToken = NULL
  WHERE SessionToken = (SELECT SecurityToken FROM [Security].[UserActivity] WHERE DATEDIFF(minute,LastUpdated,GETDATE()) >= @CacheInterval )

  DELETE FROM 
			  [Security].[UserActivity] 
  WHERE 
			  DATEDIFF(minute,LastUpdated,GETDATE()) >= @CacheInterval
GO
/****** Object:  StoredProcedure [Eventing].[DeleteEvents]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Eventing].[DeleteEvents]
 @Id INT
AS

 DELETE FROM 
		[Eventing].[DeviceEvents] 
 WHERE 
		Id = @Id
GO
/****** Object:  StoredProcedure [Configuration].[DeleteZone]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Delete a Configuration Zone
-- =======================================================
CREATE Procedure [Configuration].[DeleteZone]
	@Id int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	DELETE FROM [Configuration].[Zone] WHERE Id = @Id

COMMIT TRAN
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Schedule].[DeleteSchedule]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Delete a Schedule Schedule
-- =======================================================
CREATE Procedure [Schedule].[DeleteSchedule]
    @Id int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
    DELETE FROM [Schedule].[Schedule] WHERE Id = @Id
    
    DELETE FROM [Schedule].[Zone] WHERE Id_Schedule = @Id
    
COMMIT TRAN
  
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [BusinessRule].[GetResult]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================
-- Author:		Riaan Snyders
-- Create date: 5 January 2012
-- Description:	Get a Business Rule Result
-- ======================================================
Create Procedure [BusinessRule].[GetResult]
 @Id int
As
 SET NOCOUNT ON


	SELECT Id, Value FROM [BusinessRule].[Result] WHERE Id = @Id
GO
/****** Object:  StoredProcedure [Security].[GetLatestUserActivity]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [Security].[GetLatestUserActivity]
 @SecurityToken VARCHAR(500)
AS
  SELECT 
		 LastUpdated 
  FROM 
	    [Security].[UserActivity] 
  WHERE 
		SecurityToken = @SecurityToken
GO
/****** Object:  StoredProcedure [Configuration].[GetDeviceStatus]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 January 2012
-- Description:	Return a Active Device Status
-- ================================================
Create Procedure [Configuration].[GetDeviceStatus]
  @Id_Device int
As
 SET NOCOUNT ON
 
	SELECT devstatus.Id_Status, stat.Description FROM [Configuration].[DeviceStatus] devstatus
	INNER JOIN [Configuration].[Status] stat on stat.ID = devstatus.ID_Status
	WHERE devstatus.ID_Device = @Id_Device
GO
/****** Object:  StoredProcedure [BusinessRule].[GetCondition]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 5 January 2012
-- Description:	Get a Business Rule Condition
-- ================================================
Create Procedure [BusinessRule].[GetCondition]
 @Id int
As
 SET NOCOUNT ON


	SELECT Id, Value, Description FROM [BusinessRule].[Condition] WHERE Id = @Id
GO
/****** Object:  StoredProcedure [Configuration].[GetActiveZone]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 30 December 2011
-- Description:	Return a Spesific Zones
-- ================================================
CREATE Procedure [Configuration].[GetActiveZone]
  @Id int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	SELECT Id, Name, DateAdded, IsActive FROM [Configuration].[Zone] WHERE IsActive = 1
	AND Id = @Id
 
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Schedule].[EnableDisableSchedule]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Enable or Disable a Schedule Schedule
-- =======================================================
CREATE Procedure [Schedule].[EnableDisableSchedule]
    @Id int,
    @IsActive bit
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
    UPDATE [Schedule].[Schedule] Set IsActive = @IsActive WHERE Id = @Id
  
  COMMIT TRAN
  
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [BusinessRule].[EnableDisableRuleSet]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ========================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Enable or Disable a Business Rule RuleSet
-- ========================================================
CREATE Procedure [BusinessRule].[EnableDisableRuleSet]
	@Id int,
	@IsActive bit
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	UPDATE [BusinessRule].[RuleSet] SET IsActive = @IsActive
	WHERE Id = @Id
	
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Configuration].[EnableDisableZone]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Enable or Disable a Configuration Zone
-- =======================================================
CREATE Procedure [Configuration].[EnableDisableZone]
	@Id int,
	@IsActive bit
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	UPDATE [Configuration].[Zone] SET IsActive = @IsActive WHERE Id = @Id
	
COMMIT
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Schedule].[GetActiveSchedule]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a active schedule
-- ================================================
Create Procedure [Schedule].[GetActiveSchedule]
  @Id int
As
 SET NOCOUNT ON
 
	SELECT Id, Name, StartTime, EndTime, ElapseTime, DateAdded FROM [Schedule].[Schedule] 
	WHERE IsActive = 1 And Id = @Id
GO
/****** Object:  StoredProcedure [BusinessRule].[GetActiveRuleSet]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a active rulesets
-- ================================================
CREATE Procedure [BusinessRule].[GetActiveRuleSet]
  @Id int
As
 SET NOCOUNT ON
 
	SELECT Id, Name, Version,DateAdded FROM [BusinessRule].[RuleSet]
	Where IsActive = 1 AND Id = @Id
GO
/****** Object:  StoredProcedure [Configuration].[InsertZone]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Insert a new Configuration Zone
-- =======================================================
CREATE Procedure [Configuration].[InsertZone]
    @Name nvarchar(100),
    @DateAdded datetime,
    @SmartCloudSerial nvarchar(500)
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	INSERT INTO [Configuration].[Zone] VALUES (@Name, @DateAdded, 1,@SmartCloudSerial)
	
COMMIT TRAN
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Schedule].[InsertSchedule]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Insert a new Schedule Schedule
-- =======================================================
CREATE Procedure [Schedule].[InsertSchedule]
	@Name varchar(100),
	@StartTime time,
	@EndTime time,
	@ElapseTime int,
	@DateAdded datetime
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	INSERT INTO [Schedule].[Schedule] VALUES (@Name, @StartTime, @EndTime, @ElapseTime, @DateAdded, 1)		
  
  COMMIT TRAN
  
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [BusinessRule].[InsertRuleSet]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Insert a new Business Rule RuleSet
-- ================================================
CREATE Procedure [BusinessRule].[InsertRuleSet]
	@Name nvarchar(100),
	@Version nvarchar(10),
	@DateAdded datetime
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	INSERT INTO [BusinessRule].[RuleSet] VALUES (@Name, @Version, @DateAdded, 1)
	
COMMIT TRAN
	
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Security].[InsertRole]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Security].[InsertRole]
 @Name VARCHAR(200),
 @Description VARCHAR(500),
 @SmartCloudSerial NVARCHAR(500)
AS
  IF NOT EXISTS(SELECT * FROM [Security].[Role] WHERE Name = @Name)
  BEGIN
     INSERT INTO [Security].[Role] VALUES (@Name,@Description,@SmartCloudSerial)
  END
GO
/****** Object:  StoredProcedure [BusinessRule].[InsertLoad]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 12 February 2012
-- Description:	Insert current and max load
-- ================================================
CREATE Procedure [BusinessRule].[InsertLoad]
  @CurrentLoad int,
  @MaxLoad int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
    DELETE FROM [BusinessRule].[Load]
    
	INSERT INTO [BusinessRule].[Load] VALUES (@CurrentLoad, @MaxLoad,0)
 
 COMMIT TRAN
 
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Eventing].[InsertEvent]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Eventing].[InsertEvent]
 @Serial NVARCHAR(500),
 @Event TEXT
AS

 INSERT INTO [Eventing].[DeviceEvents] VALUES (@Serial,@Event)
GO
/****** Object:  StoredProcedure [Configuration].[InsertDeviceStatus]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Riaan Snyders
-- Create date: 31 January 2012
-- Description:	Insert a new Device status
-- ============================================== P
Create Procedure [Configuration].[InsertDeviceStatus]
    @Id_Unit int,
    @Id_Status int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	INSERT INTO [Configuration].[DeviceStatus] VALUES (@Id_Unit, @Id_Status)
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [BusinessRule].[InsertCondition]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 4 January 2012
-- Description:	Insert a Business Rule Condition
-- ================================================
Create Procedure [BusinessRule].[InsertCondition]
 @Value nvarchar(100),
 @Description nvarchar(100)
As
 SET NOCOUNT ON

 
 BEGIN TRAN
 
	INSERT INTO [BusinessRule].[Condition] VALUES (@Value, @Description)
 
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [BusinessRule].[ListCondition]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================
-- Author:		Riaan Snyders
-- Create date: 5 January 2012
-- Description:	Get a List of Business Rule Conditions
-- ======================================================
Create Procedure [BusinessRule].[ListCondition]
 
As
 SET NOCOUNT ON


	SELECT Id, Value, Description FROM [BusinessRule].[Condition]
GO
/****** Object:  StoredProcedure [Configuration].[ListActiveZone]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 30 December 2011
-- Description:	Return a list of Active Zones
-- ================================================
CREATE Procedure [Configuration].[ListActiveZone]

As
 SET NOCOUNT ON
 
	SELECT Id, Name, DateAdded, IsActive FROM [Configuration].[Zone] 
	--WHERE IsActive = 1
GO
/****** Object:  StoredProcedure [BusinessRule].[ListLoad]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 12 February 2012
-- Description:	Return the current and max loads
-- ================================================
CREATE Procedure [BusinessRule].[ListLoad]
 
As
 SET NOCOUNT ON
 
	SELECT Id, CurrentLoad, MaximumLoad, IsNull(ManualLoad,0) FROM [BusinessRule].[Load]
GO
/****** Object:  StoredProcedure [Eventing].[ListEvents]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Eventing].[ListEvents]
 @Serial NVARCHAR(500)
AS

 SELECT TOP 1
		[Id],
		[Event] 
 FROM 
		[Eventing].[DeviceEvents] 
 WHERE 
		Serial = @Serial
GO
/****** Object:  StoredProcedure [Schedule].[ListActiveSchedule]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a list of active schedules
-- ================================================
CREATE Procedure [Schedule].[ListActiveSchedule]

As
 SET NOCOUNT ON
 
	SELECT Id, Name, StartTime, EndTime, ElapseTime, DateAdded, IsActive FROM [Schedule].[Schedule] 
	--WHERE IsActive = 1
GO
/****** Object:  StoredProcedure [BusinessRule].[ListActiveRuleSet]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a list of active rulesets
-- ================================================
CREATE Procedure [BusinessRule].[ListActiveRuleSet]
 
As
 SET NOCOUNT ON
 
	SELECT Id, Name, Version,DateAdded FROM [BusinessRule].[RuleSet]
	---Where IsActive = 1
GO
/****** Object:  StoredProcedure [BusinessRule].[ListResult]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================
-- Author:		Riaan Snyders
-- Create date: 5 January 2012
-- Description:	Get a List of Business Rule Results
-- ======================================================
Create Procedure [BusinessRule].[ListResult]
 
As
 SET NOCOUNT ON


	SELECT Id, Value FROM [BusinessRule].[Result]
GO
/****** Object:  StoredProcedure [BusinessRule].[ListOperator]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 4 January 2012
-- Description:	List the BusinessRule Operators
-- ================================================
Create Procedure [BusinessRule].[ListOperator]

As
 SET NOCOUNT ON
 
 SELECT Id,Value,Description FROM [BusinessRule].[Operator]
GO
/****** Object:  StoredProcedure [Security].[LoginDevice]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Security].[LoginDevice]
 @SmartCloudSerial NVARCHAR(500)
AS
  IF (SELECT COUNT(*) FROM [Security].[Device] WHERE SmartCloudSerial = @SmartCloudSerial) > 0
  BEGIN
      IF(SELECT COUNT(*) FROM [Security].[Device] WHERE SmartCloudSerial = @SmartCloudSerial AND SessionToken is null) > 0
      BEGIN
         DECLARE @SessionToken VARCHAR(500)
         
         SET @SessionToken = NEWID()
         
         UPDATE 
				[Security].[Device] 
         SET 
				SessionToken = @SessionToken 
		WHERE 
				SmartCloudSerial = @SmartCloudSerial
				
		SELECT @SessionToken
      END
      ELSE
      BEGIN
          Select 
				SessionToken 
          FROM 
				[Security].[Device] 
		  WHERE 
				SmartCloudSerial = @SmartCloudSerial
      END
  END 
  ELSE
  BEGIN
    RAISERROR ('Unauthorized! No matching device identifier found!',16,2)
  END
GO
/****** Object:  Table [BusinessRule].[Rule]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BusinessRule].[Rule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_RuleSet] [int] NOT NULL,
	[Condition] [nvarchar](500) NOT NULL,
	[Result] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_Rule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Security].[RolePermission]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Security].[RolePermission](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Role] [int] NOT NULL,
	[CanManageSchedule] [bit] NOT NULL,
	[CanManageZones] [bit] NOT NULL,
	[CanManageSwitches] [bit] NOT NULL,
	[CanManageUnits] [bit] NOT NULL,
	[CanSwitchOnOff] [bit] NOT NULL,
	[CanManageUsers] [bit] NOT NULL,
 CONSTRAINT [PK_RolePermission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Security].[User]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Security].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Role] [int] NOT NULL,
	[FirstName] [nvarchar](200) NOT NULL,
	[Surname] [nvarchar](300) NOT NULL,
	[Username] [nvarchar](200) NOT NULL,
	[Password] [nvarchar](200) NOT NULL,
	[DateRegistered] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[SessionToken] [nvarchar](500) NULL,
	[SmartCloudSerial] [nvarchar](500) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [Configuration].[UpdateZone]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Update a Configuration Zone
-- =======================================================
CREATE Procedure [Configuration].[UpdateZone]
	@Id int,
    @Name nvarchar(100)
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	UPDATE [Configuration].[Zone] SET Name = @Name WHERE Id = @Id
	
COMMIT TRAN
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Security].[UpdateUserActivity]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [Security].[UpdateUserActivity]
 @SecurityToken VARCHAR(500)
AS
IF NOT EXISTS(SELECT * FROM [Security].[UserActivity] WHERE SecurityToken = @SecurityToken)
BEGIN
  INSERT INTO 
			  [Security].[UserActivity] 
  VALUES (
			  @SecurityToken,
			  GETDATE()
		 )
END
ELSE
BEGIN

  UPDATE
	     [Security].[UserActivity]
	   
  SET    LastUpdated = GETDATE()
  
  WHERE 
		SecurityToken = @SecurityToken

END
GO
/****** Object:  StoredProcedure [Security].[UpdateRole]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Security].[UpdateRole]
 @Name VARCHAR(200),
 @Description VARCHAR(500),
 @SmartCloudSerial NVARCHAR(500)
AS
  UPDATE 
		[Security].[Role] 
  SET 
		Name = @Name, [Description] = @Description 
  WHERE 
		SmartCloudSerial = @SmartCloudSerial
GO
/****** Object:  StoredProcedure [Configuration].[UpdateLoadShedDeviceStatus]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================================
-- Author:		Riaan Snyders
-- Create date: 05 February 2012
-- Description:	Update a device's load shed status
-- ========================================================================
CREATE Procedure [Configuration].[UpdateLoadShedDeviceStatus]
 @Id_Device int,
 @Id_Status int
AS

IF NOT EXISTS (SELECT * FROM [Configuration].[DeviceStatus] WHERE Id_Device = @Id_Device)
BEGIN
 INSERT INTO [Configuration].[DeviceStatus] VALUES (@Id_Device,@Id_Status)
END
ELSE
BEGIN
 UPDATE [Configuration].[DeviceStatus] SET Id_Status = @Id_Status
 WHERE Id_Device = @Id_Device
END
GO
/****** Object:  StoredProcedure [BusinessRule].[UpdateLoad]    Script Date: 03/28/2013 10:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 12 February 2012
-- Description:	Update a current and max loads
-- ================================================
CREATE Procedure [BusinessRule].[UpdateLoad]
	@CurrentLoad int,
	@MaxLoad int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	UPDATE [BusinessRule].[Load] SET CurrentLoad = @CurrentLoad,
	MaximumLoad = @MaxLoad
	
COMMIT TRAN


  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Configuration].[UpdateDeviceStatus]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Riaan Snyders
-- Create date: 31 january 2012
-- Description:	Update a Configuration Device Status
-- ==============================================
CREATE Procedure [Configuration].[UpdateDeviceStatus]
    @Id_Device int,
    @Id_Status int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	UPDATE [Configuration].[DeviceStatus] SET Id_Status = @Id_Status
	WHERE Id_Device = @Id_Device
	
COMMIT TRAN
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Schedule].[UpdateSchedule]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Update a Schedule Schedule
-- =======================================================
CREATE Procedure [Schedule].[UpdateSchedule]
    @Id int,
	@Name varchar(100),
	@StartTime time,
	@EndTime time,
	@ElapseTime int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
    UPDATE [Schedule].[Schedule] SET Name = @Name, StartTime = @StartTime, 
    EndTime = @EndTime, ElapseTime = @ElapseTime
    WHERE Id = @Id
    
 COMMIT TRAN
  
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [BusinessRule].[UpdateRuleSet]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Update a Business Rule RuleSet
-- ================================================
CREATE Procedure [BusinessRule].[UpdateRuleSet]
	@Id int,
	@Name nvarchar(100),
	@Version nvarchar(10)
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	UPDATE [BusinessRule].[RuleSet] SET Name = @Name,
	Version = @Version WHERE Id = @Id
	
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  Table [Configuration].[Unit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Configuration].[Unit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Zone] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DateAdded] [datetime] NOT NULL,
	[Address] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [BusinessRule].[Unit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BusinessRule].[Unit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Unit] [int] NOT NULL,
	[Id_Rule] [int] NULL,
 CONSTRAINT [PK_Unit_2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Schedule].[Unit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Schedule].[Unit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Unit] [int] NOT NULL,
	[Id_Schedule] [int] NOT NULL,
 CONSTRAINT [PK_Unit_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [BusinessRule].[UpdateRule]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Update a Business Rule Rule
-- ================================================
CREATE Procedure [BusinessRule].[UpdateRule]
	@Id int,
	@Id_RuleSet int,
	@Condition nvarchar(500),
	@Result nvarchar(500)
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	UPDATE [BusinessRule].[Rule] SET Id_RuleSet = @Id_RuleSet,
	Condition = @Condition, Result = @Result WHERE Id = @Id

  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Configuration].[UpdateUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Update a Configuration Unit
-- =======================================================
CREATE Procedure [Configuration].[UpdateUnit]
    @Id int,
    @Id_Zone int,
    @Name nvarchar(100),
    @Address nvarchar(50)
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	UPDATE [Configuration].[Unit] SET Id_Zone = @Id_Zone, Name = @Name,
	Address = @Address WHERE Id = @Id

COMMIT TRAN
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Security].[RegisterUser]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Security].[RegisterUser]
 @Firstname NVARCHAR(200),
 @Surname NVARCHAR(200),
 @Username NVARCHAR(200),
 @Password NVARCHAR(200),
 @SmartCloudSerial NVARCHAR(500)
AS

  IF NOT EXISTS(SELECT * FROM [Security].[User] WHERE Username = @Username AND [Password] = @Password)
  BEGIN
     INSERT INTO [Security].[User] VALUES (1,@Firstname,@Surname,@Username,@Password,GETDATE(),1,NULL, @SmartCloudSerial)
  END
GO
/****** Object:  StoredProcedure [Security].[LogoutUser]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Security].[LogoutUser]
 @SecurityToken NVARCHAR(500)
AS
  UPDATE 
		[Security].[User] 
  SET 
		SessionToken = Null 
  WHERE 
		SessionToken = @SecurityToken
GO
/****** Object:  StoredProcedure [Security].[LoginUser]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Security].[LoginUser]
 @Username NVARCHAR(200),
 @Password NVARCHAR(200)
AS
  IF (SELECT COUNT(*) FROM [Security].[User] WHERE Username = @Username AND [Password] = @Password AND IsActive = 1) = 1
  BEGIN
    DECLARE @SessionToken UNIQUEIDENTIFIER
    
    SET @SessionToken = NEWID()
    
    UPDATE 
			[Security].[User] 
    SET 
			SessionToken = @SessionToken 
    WHERE 
			Username = @Username AND [Password] = @Password
  END
GO
/****** Object:  StoredProcedure [Configuration].[ListActiveUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a list of Active Units
-- ================================================
CREATE Procedure [Configuration].[ListActiveUnit]
  @Id_Zone int
As
 SET NOCOUNT ON
 
	SELECT Id, Name, DateAdded, [Address], IsActive FROM [Configuration].[Unit] 
	WHERE Id_Zone = @Id_Zone 
	--AND IsActive = 1
GO
/****** Object:  StoredProcedure [BusinessRule].[ListActiveRule]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a list of active rules
-- ================================================
CREATE Procedure [BusinessRule].[ListActiveRule]
  @Id_RuleSet int
As
 SET NOCOUNT ON
 
	SELECT a.Id,a.Condition, a.Result, b.Priority FROM [BusinessRule].[Rule] a
	inner Join [BusinessRule].[PriorityRule] b on B.Id_Rule = a.Id
	Where a.Id_RuleSet = @Id_RuleSet
GO
/****** Object:  StoredProcedure [Schedule].[ListConfigurationUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 05 February 2012
-- Description:	Return a list of active units
-- ================================================
CREATE Procedure [Schedule].[ListConfigurationUnit]

As
 SET NOCOUNT ON
 
	SELECT Id, Name FROM [Configuration].[Unit] WHERE IsActive = 1
GO
/****** Object:  StoredProcedure [Security].[GetUserRole]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Security].[GetUserRole]
 @Id INT,
 @SmartCloudSerial VARCHAR(500)
AS
	SELECT * FROM [Security].[Role] SecurityRole
	INNER JOIN [Security].[User] SecurityUser on SecurityUser.Id_Role = SecurityRole.Id
	WHERE SecurityUser.Id = @Id AND SecurityUser.SmartCloudSerial = @SmartCloudSerial
GO
/****** Object:  StoredProcedure [BusinessRule].[InsertRule]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2012
-- Description:	Insert a new Business Rule Rule
-- ================================================
CREATE Procedure [BusinessRule].[InsertRule]
	@Id_RuleSet int,
	@Condition nvarchar(500),
	@Result nvarchar(500)
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	INSERT INTO [BusinessRule].[Rule] VALUES (@Id_RuleSet, @Condition, @Result)
	
COMMIT TRAN
 
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Configuration].[InsertUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Insert a Configuration Unit
-- =======================================================
CREATE Procedure [Configuration].[InsertUnit]
    @Id_Zone int,
    @Name nvarchar(100),
    @DateAdded datetime,
    @Address nvarchar(50)
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	INSERT INTO [Configuration].[Unit] VALUES (@Id_Zone, @Name, @DateAdded, @Address, 1)
	
COMMIT TRAN
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Security].[GetRolePermissions]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Security].[GetRolePermissions]
 @Id_Role INT
AS
	SELECT * FROM [Security].[RolePermission]
	WHERE Id_Role = @Id_Role
GO
/****** Object:  StoredProcedure [BusinessRule].[GetActiveRule]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a active rule
-- ================================================
Create Procedure [BusinessRule].[GetActiveRule]
  @Id int
As
 SET NOCOUNT ON
 
	SELECT Condition, Result FROM [BusinessRule].[Rule]
	Where Id = @Id
GO
/****** Object:  StoredProcedure [Configuration].[EnableDisableUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Enable or Disable a Configuration Unit
-- =======================================================
CREATE Procedure [Configuration].[EnableDisableUnit]
    @Id int,
    @IsActive bit
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	UPDATE [Configuration].[Unit] SET IsActive = @IsActive WHERE Id = @Id

COMMIT TRAN
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Security].[EnableUser]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Security].[EnableUser]
 @Id INT
AS
    UPDATE 
		  [Security].[User] 
	SET 
		  IsActive = 1
	WHERE 
		  Id = @Id
GO
/****** Object:  StoredProcedure [Security].[DisableUser]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Security].[DisableUser]
 @Id INT
AS
    UPDATE 
		  [Security].[User] 
	SET 
		  IsActive = 0 
	WHERE 
		  Id = @Id
GO
/****** Object:  StoredProcedure [Configuration].[GetActiveUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a list of Active Units
-- ================================================
CREATE Procedure [Configuration].[GetActiveUnit]
  @Id int
As
 SET NOCOUNT ON
 
	SELECT Id, Name, DateAdded, [Address], IsActive FROM [Configuration].[Unit] 
	WHERE Id = @Id AND IsActive = 1
GO
/****** Object:  StoredProcedure [BusinessRule].[DeleteRuleSet]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Delete a Business Rule RuleSet
-- ================================================
CREATE Procedure [BusinessRule].[DeleteRuleSet]
	@Id int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
    DELETE FROM [BusinessRule].[PriorityRule] WHERE Id_RuleSet = @Id
 
    DELETE FROM [BusinessRule].[Rule] WHERE Id_RuleSet = @Id
    
	DELETE FROM [BusinessRule].[RuleSet] WHERE Id = @Id
	
	
COMMIT TRAN
	
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [BusinessRule].[DeleteRule]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Delete a Business Rule Rule
-- ================================================
CREATE Procedure [BusinessRule].[DeleteRule]
	@Id int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
 DECLARE @RuleID int
 
 DELETE FROM [BusinessRule].[PriorityRule] WHERE Id_Rule = @Id
 
 DELETE FROM [BusinessRule].[Rule] WHERE Id = @Id

COMMIT
 
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Security].[DeleteRole]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Security].[DeleteRole]
 @Id INT
AS
	DELETE FROM [Security].[RolePermission] WHERE Id_Role = @Id
    DELETE FROM [Security].[Role] WHERE Id = @Id
    
    UPDATE [Security].[User] SET Id_Role = 1 WHERE Id_Role = @Id
GO
/****** Object:  StoredProcedure [Configuration].[DeleteUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Delete a Configuration Unit
-- =======================================================
CREATE Procedure [Configuration].[DeleteUnit]
    @Id int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	DELETE FROM [Configuration].[Unit] WHERE Id = @Id
	
COMMIT TRAN
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  Table [Configuration].[Device]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Configuration].[Device](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Unit] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DateAdded] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Switch] [nvarchar](50) NULL,
 CONSTRAINT [PK_Device] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [BusinessRule].[Device]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BusinessRule].[Device](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Device] [int] NOT NULL,
	[Id_RuleUnit] [int] NOT NULL,
 CONSTRAINT [PK_Device_2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [Schedule].[DeleteUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description: Delete a Schedule Unit
-- =======================================================
CREATE Procedure [Schedule].[DeleteUnit]
	@Id int,
	@Id_Schedule int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
   DELETE FROM [Schedule].[Unit] WHERE Id_Unit = @Id
   AND Id_Schedule = @Id_Schedule

 COMMIT TRAN
 
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [BusinessRule].[DeleteUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Delete a Business Rule Unit
-- ==============================================
CREATE Procedure [BusinessRule].[DeleteUnit]
    @Id int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	DELETE FROM [BusinessRule].[UNIT] WHERE Id = @Id
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Configuration].[DeleteDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Delete a Configuration Device
-- ==============================================
CREATE Procedure [Configuration].[DeleteDevice]
    @Id int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	DELETE FROM [Configuration].[Device] WHERE Id = @Id
	
COMMIT TRAN
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  Table [Schedule].[Device]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Schedule].[Device](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Device] [int] NOT NULL,
	[Id_ScheduleUnit] [int] NULL,
	[DeviceOn] [bit] NULL,
 CONSTRAINT [PK_Device_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [Schedule].[GetActiveUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a active unit
-- ================================================
Create Procedure [Schedule].[GetActiveUnit]
  @Id int
As
 SET NOCOUNT ON
 
	SELECT unit.Id, cfunit.Name, cfunit.[Address], cfunit.DateAdded FROM [Schedule].[Unit] unit
	INNER JOIN [Configuration].[Unit] cfunit on cfunit.Id = unit.Id_Unit
	WHERE unit.Id = @Id
GO
/****** Object:  StoredProcedure [Configuration].[GetActiveDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a Active Device
-- ================================================
CREATE Procedure [Configuration].[GetActiveDevice]
  @Id int
As
 SET NOCOUNT ON
 
	SELECT Id, Name, DateAdded, IsActive FROM [Configuration].[Device] 
	WHERE Id = @Id AND IsActive = 1
GO
/****** Object:  StoredProcedure [Configuration].[EnableDisableDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Enable or Disable a Configuration Device
-- =======================================================
CREATE Procedure [Configuration].[EnableDisableDevice]
    @Id int,
    @IsActive bit
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	UPDATE [Configuration].[Device] SET IsActive = @IsActive WHERE Id = @Id

COMMIT TRAN
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Configuration].[ListActiveDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a list of Active Devices
-- ================================================
CREATE Procedure [Configuration].[ListActiveDevice]
  @Id_Unit int
As
 SET NOCOUNT ON
 
	SELECT Id, Name, DateAdded, IsActive, Switch FROM [Configuration].[Device] 
	WHERE Id_Unit = @Id_Unit 
	
	--AND IsActive = 1
GO
/****** Object:  StoredProcedure [Schedule].[InsertUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Insert a new Schedule Unit
-- =======================================================
CREATE Procedure [Schedule].[InsertUnit]
    @Id_Unit int,
    @Id_Schedule int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
 IF NOT EXISTS(SELECT * FROM [Schedule].[Unit] WHERE Id_Unit = @Id_Unit AND Id_Schedule = @Id_Schedule)
 BEGIN
   INSERT INTO [Schedule].[Unit] VALUES (@Id_Unit, @Id_Schedule)
  END
   
  COMMIT
  
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [BusinessRule].[InsertUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Insert a new Business Rule Unit
-- ==============================================
CREATE Procedure [BusinessRule].[InsertUnit]
	@Id_Unit int,
	@Id_Rule int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	INSERT INTO [BusinessRule].[UNIT] VALUES (@Id_Unit, @Id_Rule)
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Configuration].[InsertDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Insert a new Configuration Device
-- ==============================================
CREATE Procedure [Configuration].[InsertDevice]
    @Id_Unit int,
    @Name nvarchar(100),
    @Switch nvarchar(50),
    @DateAdded datetime
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	INSERT INTO [Configuration].[Device] VALUES (@Id_Unit, @Name, @DateAdded, 1, @Switch)

COMMIT TRAN
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Schedule].[ListActiveUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a list of active units
-- ================================================
CREATE Procedure [Schedule].[ListActiveUnit]
  @Id_Schedule int
As
 SET NOCOUNT ON
 
	SELECT cfunit.Id, unit.Id as 'Id_ScheduleUnit', cfunit.Name, cfunit.[Address], cfunit.DateAdded, cfunit.IsActive 
	FROM [Schedule].[Unit] unit
	INNER JOIN [Configuration].[Unit] cfunit on cfunit.Id = unit.Id_Unit
	WHERE unit.Id_Schedule = @Id_Schedule
GO
/****** Object:  StoredProcedure [Configuration].[ListLoadShedDevices]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================================
-- Author:		Riaan Snyders
-- Create date: 05 February 2012
-- Description:	Return a list of Active Devices and loadshedding status
-- ========================================================================
CREATE Procedure [Configuration].[ListLoadShedDevices]
 @Id_Unit int
AS

	SELECT d.Id, d.Name, d.DateAdded, d.IsActive, IsNull(ds.Id_Status,2)As 'Status' FROM [Configuration].[Device] d
	LEFT JOIN [Configuration].[DeviceStatus] ds on ds.Id_Device = d.Id
	WHERE d.Id_Unit = @Id_Unit
GO
/****** Object:  StoredProcedure [BusinessRule].[UpdateUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Update a Business Rule Unit
-- ==============================================
CREATE Procedure [BusinessRule].[UpdateUnit]
    @Id int,
    @Id_Unit int,
    @Id_Rule int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	UPDATE [BusinessRule].[UNIT] SET Id_Unit = @Id_Unit,
	Id_Rule = @Id_Rule WHERE Id = @Id
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Schedule].[UpdateUnit]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description: Update a Schedule Unit
-- =======================================================
CREATE Procedure [Schedule].[UpdateUnit]
	@Id int,
    @Id_Unit int,
    @Id_Schedule int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
   UPDATE [Schedule].[Unit] SET Id_Unit = @Id_Unit,
   Id_Schedule = @Id_Schedule WHERE Id = @Id
  
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Configuration].[UpdateDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Riaan Snyders
-- Create date: 31 january 2012
-- Description:	Update a Configuration Device Status
-- ==============================================
CREATE Procedure [Configuration].[UpdateDevice]
    @Id_Device int,
    @Id_Unit int,
    @Name nvarchar(100)
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	UPDATE [Configuration].[Device] SET Id_Unit = @Id_Unit,
	Name = @Name
	WHERE Id = @Id_Device
	
COMMIT TRAN
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [BusinessRule].[UpdateDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Update a Business Rule Device
-- ================================================
CREATE Procedure [BusinessRule].[UpdateDevice]
  @Id int,
  @Id_Device int,
  @Id_RuleUnit int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	 UPDATE BusinessRule.Device SET Id_Device = @Id_Device, 
	 Id_RuleUnit = @Id_RuleUnit WHERE Id = @Id
	 
COMMIT TRAN
 
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [Schedule].[UpdateDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2012
-- Description:	Update a Schedule Device
-- =======================================================
CREATE Procedure [Schedule].[UpdateDevice]
	@Id int,
	@DeviceOn bit
As
 SET NOCOUNT ON
 
 --BEGIN TRAN
 
	UPDATE [Schedule].[Device] SET DeviceOn = @DeviceOn
	WHERE Id = @Id
	
--COMMIT TRAN
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END


select * from [Schedule].[device]
GO
/****** Object:  StoredProcedure [BusinessRule].[ListRuleUnitAndDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===============================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a list of linked rule units and devices
-- ===============================================================
Create Procedure [BusinessRule].[ListRuleUnitAndDevice]
  @Id_Rule int
As
 SET NOCOUNT ON
 
	SELECT unit.Id, unit.Id_Unit, cfunit.Address, Device.Id, Device.Id_Device FROM [BusinessRule].[Unit] unit
	INNER JOIN [BusinessRule].[Device] device on device.Id_RuleUnit = unit.Id
	INNER JOIN [Configuration].[Unit] cfunit on cfunit.Id = unit.Id_Unit
	WHERE unit.Id_Rule = @Id_Rule
GO
/****** Object:  StoredProcedure [Schedule].[ListActiveDeviceById]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a list of active devices
CREATE  Procedure [Schedule].[ListActiveDeviceById]
  @Id_Unit int,
  @Id_Schedule int
As
 SET NOCOUNT ON
 
    DECLARE @ScheduleUnitId int
    
    SELECT @ScheduleUnitId = Id FROM [Schedule].[Unit]
    WHERE Id_Schedule = @Id_Schedule and Id_Unit = @Id_Unit
    
	SELECT device.Id, cfdevice.Name, cfdevice.DateAdded,device.DeviceOn FROM [Schedule].[Device] device
	INNER JOIN [Configuration].[Device] cfdevice on cfdevice.Id = device.Id_Device
	WHERE device.Id_ScheduleUnit =@ScheduleUnitId
	
	--AND device.Id_ScheduleUnit = @Id_Schedule
GO
/****** Object:  StoredProcedure [Schedule].[ListActiveDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a list of active devices
-- ================================================
CREATE Procedure [Schedule].[ListActiveDevice]
  @Id_Unit int,
  @Id_Schedule int
As
 SET NOCOUNT ON
 
    DECLARE @ScheduleUnitId int
    
    SELECT @ScheduleUnitId = Id FROM [Schedule].[Unit]
    WHERE Id_Schedule = @Id_Schedule and Id_Unit = @Id_Unit
 
	SELECT device.Id, cfdevice.Name, cfdevice.DateAdded,device.DeviceOn FROM [Schedule].[Device] device
	INNER JOIN [Configuration].[Device] cfdevice on cfdevice.Id = device.Id_Device
	WHERE device.Id_ScheduleUnit = @ScheduleUnitId 
	
	--AND device.Id_ScheduleUnit = @Id_Schedule
GO
/****** Object:  StoredProcedure [Schedule].[InsertDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Insert a new Schedule Device
-- =======================================================
CREATE Procedure [Schedule].[InsertDevice]
	@Id_Device int,
	@Id_ScheduleUnit int,
	@Id_Schedule int,
	@On bit
As
 SET NOCOUNT ON
 
    DECLARE @ScheduleUnitId int
    
    SELECT @ScheduleUnitId = Id FROM [Schedule].[Unit]
    WHERE Id_Unit = @Id_ScheduleUnit AND Id_Schedule = @Id_Schedule
     
    IF NOT EXISTS(SELECT * FROM [Schedule].[Device] WHERE Id_Device = @Id_Device AND Id_ScheduleUnit = @ScheduleUnitId)
    BEGIN   
	   INSERT INTO [Schedule].[Device] VALUES (@Id_Device, @ScheduleUnitId,@On)
    END
    ELSE
    BEGIN
       UPDATE [Schedule].[Device] SET DeviceOn = @On WHERE Id_Device = @Id_Device and Id_ScheduleUnit = @ScheduleUnitId
    END
GO
/****** Object:  StoredProcedure [BusinessRule].[InsertDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Insert a new Business Rule Device
-- ================================================
CREATE Procedure [BusinessRule].[InsertDevice]
  @Id_Device int,
  @Id_RuleUnit int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	INSERT INTO BusinessRule.Device VALUES (@Id_Device, @Id_RuleUnit)

COMMIT TRAN
 
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [BusinessRule].[GetRuleUnitAndDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===============================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a linked rule unit and device
-- ===============================================================
Create Procedure [BusinessRule].[GetRuleUnitAndDevice]
  @Id int
As
 SET NOCOUNT ON
 
	SELECT unit.Id, unit.Id_Unit, cfunit.Address, Device.Id, Device.Id_Device FROM [BusinessRule].[Unit] unit
	INNER JOIN [BusinessRule].[Device] device on device.Id_RuleUnit = unit.Id
	INNER JOIN [Configuration].[Unit] cfunit on cfunit.Id = unit.Id_Unit
	WHERE unit.Id = @Id
GO
/****** Object:  StoredProcedure [Schedule].[GetActiveDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 31 December 2011
-- Description:	Return a active device
-- ================================================
Create Procedure [Schedule].[GetActiveDevice]
  @Id int
As
 SET NOCOUNT ON
 
	SELECT device.Id, cfdevice.Name, cfdevice.DateAdded FROM [Schedule].[Device] device
	INNER JOIN [Configuration].[Device] cfdevice on cfdevice.Id = device.Id_Device
	WHERE device.Id = @Id
GO
/****** Object:  StoredProcedure [Schedule].[DeleteDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Delete a Schedule Device
-- =======================================================
CREATE Procedure [Schedule].[DeleteDevice]
	@Id int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	DELETE FROM [Schedule].[Device] WHERE Id = @Id
	
COMMIT TRAN
		
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  StoredProcedure [BusinessRule].[DeleteDevice]    Script Date: 03/28/2013 10:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Riaan Snyders
-- Create date: 29 December 2011
-- Description:	Delete a Business Rule Device
-- ================================================
CREATE Procedure [BusinessRule].[DeleteDevice]
  @Id int
As
 SET NOCOUNT ON
 
 BEGIN TRAN
 
	DELETE FROM BusinessRule.Device WHERE Id = @Id
 
  IF @@ERROR > 0 
  BEGIN
    ROLLBACK TRAN
  END
GO
/****** Object:  ForeignKey [FK_Rule_RuleSet]    Script Date: 03/28/2013 10:48:56 ******/
ALTER TABLE [BusinessRule].[Rule]  WITH CHECK ADD  CONSTRAINT [FK_Rule_RuleSet] FOREIGN KEY([Id_RuleSet])
REFERENCES [BusinessRule].[RuleSet] ([Id])
GO
ALTER TABLE [BusinessRule].[Rule] CHECK CONSTRAINT [FK_Rule_RuleSet]
GO
/****** Object:  ForeignKey [FK_RolePermission_Role]    Script Date: 03/28/2013 10:48:56 ******/
ALTER TABLE [Security].[RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_RolePermission_Role] FOREIGN KEY([Id_Role])
REFERENCES [Security].[Role] ([Id])
GO
ALTER TABLE [Security].[RolePermission] CHECK CONSTRAINT [FK_RolePermission_Role]
GO
/****** Object:  ForeignKey [FK_User_Role]    Script Date: 03/28/2013 10:48:56 ******/
ALTER TABLE [Security].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([Id_Role])
REFERENCES [Security].[Role] ([Id])
GO
ALTER TABLE [Security].[User] CHECK CONSTRAINT [FK_User_Role]
GO
/****** Object:  ForeignKey [FK_Unit_Zone]    Script Date: 03/28/2013 10:48:57 ******/
ALTER TABLE [Configuration].[Unit]  WITH CHECK ADD  CONSTRAINT [FK_Unit_Zone] FOREIGN KEY([Id_Zone])
REFERENCES [Configuration].[Zone] ([Id])
GO
ALTER TABLE [Configuration].[Unit] CHECK CONSTRAINT [FK_Unit_Zone]
GO
/****** Object:  ForeignKey [FK_Unit_Rule]    Script Date: 03/28/2013 10:48:57 ******/
ALTER TABLE [BusinessRule].[Unit]  WITH CHECK ADD  CONSTRAINT [FK_Unit_Rule] FOREIGN KEY([Id_Rule])
REFERENCES [BusinessRule].[Rule] ([Id])
GO
ALTER TABLE [BusinessRule].[Unit] CHECK CONSTRAINT [FK_Unit_Rule]
GO
/****** Object:  ForeignKey [FK_Unit_Unit]    Script Date: 03/28/2013 10:48:57 ******/
ALTER TABLE [BusinessRule].[Unit]  WITH CHECK ADD  CONSTRAINT [FK_Unit_Unit] FOREIGN KEY([Id_Unit])
REFERENCES [Configuration].[Unit] ([Id])
GO
ALTER TABLE [BusinessRule].[Unit] CHECK CONSTRAINT [FK_Unit_Unit]
GO
/****** Object:  ForeignKey [FK_Unit_Schedule]    Script Date: 03/28/2013 10:48:57 ******/
ALTER TABLE [Schedule].[Unit]  WITH CHECK ADD  CONSTRAINT [FK_Unit_Schedule] FOREIGN KEY([Id_Schedule])
REFERENCES [Schedule].[Schedule] ([Id])
GO
ALTER TABLE [Schedule].[Unit] CHECK CONSTRAINT [FK_Unit_Schedule]
GO
/****** Object:  ForeignKey [FK_Unit_Unit]    Script Date: 03/28/2013 10:48:57 ******/
ALTER TABLE [Schedule].[Unit]  WITH CHECK ADD  CONSTRAINT [FK_Unit_Unit] FOREIGN KEY([Id_Unit])
REFERENCES [Configuration].[Unit] ([Id])
GO
ALTER TABLE [Schedule].[Unit] CHECK CONSTRAINT [FK_Unit_Unit]
GO
/****** Object:  ForeignKey [FK_Device_Unit]    Script Date: 03/28/2013 10:48:57 ******/
ALTER TABLE [Configuration].[Device]  WITH CHECK ADD  CONSTRAINT [FK_Device_Unit] FOREIGN KEY([Id_Unit])
REFERENCES [Configuration].[Unit] ([Id])
GO
ALTER TABLE [Configuration].[Device] CHECK CONSTRAINT [FK_Device_Unit]
GO
/****** Object:  ForeignKey [FK_Device_Device]    Script Date: 03/28/2013 10:48:57 ******/
ALTER TABLE [BusinessRule].[Device]  WITH CHECK ADD  CONSTRAINT [FK_Device_Device] FOREIGN KEY([Id_Device])
REFERENCES [Configuration].[Device] ([Id])
GO
ALTER TABLE [BusinessRule].[Device] CHECK CONSTRAINT [FK_Device_Device]
GO
/****** Object:  ForeignKey [FK_Device_Unit]    Script Date: 03/28/2013 10:48:57 ******/
ALTER TABLE [BusinessRule].[Device]  WITH CHECK ADD  CONSTRAINT [FK_Device_Unit] FOREIGN KEY([Id_RuleUnit])
REFERENCES [BusinessRule].[Unit] ([Id])
GO
ALTER TABLE [BusinessRule].[Device] CHECK CONSTRAINT [FK_Device_Unit]
GO
/****** Object:  ForeignKey [FK_Device_Device]    Script Date: 03/28/2013 10:48:57 ******/
ALTER TABLE [Schedule].[Device]  WITH CHECK ADD  CONSTRAINT [FK_Device_Device] FOREIGN KEY([Id_Device])
REFERENCES [Configuration].[Device] ([Id])
GO
ALTER TABLE [Schedule].[Device] CHECK CONSTRAINT [FK_Device_Device]
GO
/****** Object:  ForeignKey [FK_Device_Unit]    Script Date: 03/28/2013 10:48:57 ******/
ALTER TABLE [Schedule].[Device]  WITH CHECK ADD  CONSTRAINT [FK_Device_Unit] FOREIGN KEY([Id_ScheduleUnit])
REFERENCES [Schedule].[Unit] ([Id])
GO
ALTER TABLE [Schedule].[Device] CHECK CONSTRAINT [FK_Device_Unit]
GO
