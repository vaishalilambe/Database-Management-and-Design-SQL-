/*
Created: 09-11-2016
Modified: 28-11-2016
Model: Microsoft SQL Server 2014
Database: MS SQL Server 2014
*/


-- Create tables section -------------------------------------------------

-- Table Customer

CREATE TABLE [Customer]
(
 [CustomerID] Int NOT NULL,
 [CustomerName] Varchar(20) NOT NULL,
 [CustomerEmail] Varchar(30) NOT NULL,
 [Phone] Varchar(11) NOT NULL
)
go

-- Add keys for table Customer

ALTER TABLE [Customer] ADD CONSTRAINT [Key1] PRIMARY KEY ([CustomerID])
go

-- Table Phone

CREATE TABLE [Phone]
(
 [IMEI] Bigint NOT NULL,
 [Year] Int NOT NULL,
 [Month] Int NOT NULL,
 [Maker] Varchar(20) NOT NULL,
 [Model] Varchar(20) NOT NULL,
 [CustomerID] Int NULL,
 [CategoryID] Int NULL
)
go

-- Create indexes for table Phone

CREATE INDEX [IX_Relationship1] ON [Phone] ([CustomerID])
go

CREATE INDEX [IX_Relationship39] ON [Phone] ([CategoryID])
go

-- Add keys for table Phone

ALTER TABLE [Phone] ADD CONSTRAINT [Key2] PRIMARY KEY ([IMEI])
go

-- Table SIM Card

CREATE TABLE [SIM Card]
(
 [SimID] Int NOT NULL,
 [PhoneNumber] Varchar(11) NOT NULL,
 [SimSizeType] Char(5) NOT NULL,
 [CustomerID] Int NULL,
 [CategoryID] Int NULL
)
go

-- Create indexes for table SIM Card

CREATE INDEX [IX_Relationship23] ON [SIM Card] ([CustomerID])
go

CREATE INDEX [IX_Relationship37] ON [SIM Card] ([CategoryID])
go

-- Add keys for table SIM Card

ALTER TABLE [SIM Card] ADD CONSTRAINT [Key3] PRIMARY KEY ([SimID])
go

-- Table Contract

CREATE TABLE [Contract]
(
 [ContractID] Int NOT NULL,
 [CustomerID] Int NOT NULL,
 [SimID] Int NOT NULL,
 [Type] Varchar(20) NOT NULL,
 [ContractText] Int NOT NULL,
 [ContractVoice] Time NOT NULL,
 [ContractData] Float NOT NULL,
 [StartTime] Time NOT NULL,
 [EndTime] Time NOT NULL,
 [CategoryID] Int NULL,
 [EmployeeID] Int NULL
)
go

-- Create indexes for table Contract

CREATE INDEX [IX_Relationship38] ON [Contract] ([CategoryID])
go

CREATE INDEX [IX_Relationship42] ON [Contract] ([EmployeeID])
go

-- Add keys for table Contract

ALTER TABLE [Contract] ADD CONSTRAINT [Key4] PRIMARY KEY ([ContractID],[CustomerID],[SimID])
go

-- Table Text

CREATE TABLE [Text]
(
 [TextID] Int NOT NULL,
 [TextLength] Int NOT NULL,
 [TextDate] Datetime NOT NULL,
 [Beta_PhoneNumber] Varchar(11) NOT NULL,
 [ContractID] Int NOT NULL,
 [BillID] Int NULL,
 [CustomerID] Int NULL,
 [SimID] Int NULL
)
go

-- Create indexes for table Text

CREATE INDEX [IX_Relationship8] ON [Text] ([ContractID],[CustomerID],[SimID])
go

CREATE INDEX [IX_Relationship20] ON [Text] ([BillID])
go

-- Add keys for table Text

ALTER TABLE [Text] ADD CONSTRAINT [Key5] PRIMARY KEY ([TextID])
go

-- Table Voice

CREATE TABLE [Voice]
(
 [VoiceID] Int NOT NULL,
 [VoiceDateStart] Datetime NOT NULL,
 [VoiceDateEnd] Datetime NOT NULL,
 [Beta_PhoneNumber] Varchar(11) NOT NULL,
 [ContractID] Int NOT NULL,
 [BillID] Int NULL,
 [CustomerID] Int NULL,
 [SimID] Int NULL
)
go

-- Create indexes for table Voice

CREATE INDEX [IX_Relationship9] ON [Voice] ([ContractID],[CustomerID],[SimID])
go

CREATE INDEX [IX_Relationship21] ON [Voice] ([BillID])
go

-- Add keys for table Voice

ALTER TABLE [Voice] ADD CONSTRAINT [Key6] PRIMARY KEY ([VoiceID])
go

-- Table Data

CREATE TABLE [Data]
(
 [DataID] Int NOT NULL,
 [DataUsed] Float NOT NULL,
 [DataStartDate] Datetime NOT NULL,
 [DataEndDate] Datetime NULL,
 [ContractID] Int NOT NULL,
 [BillID] Int NULL,
 [CustomerID] Int NULL,
 [SimID] Int NULL
)
go

-- Create indexes for table Data

CREATE INDEX [IX_Relationship10] ON [Data] ([ContractID],[CustomerID],[SimID])
go

CREATE INDEX [IX_Relationship22] ON [Data] ([BillID])
go

-- Add keys for table Data

ALTER TABLE [Data] ADD CONSTRAINT [Key7] PRIMARY KEY ([DataID])
go

-- Table Bill

CREATE TABLE [Bill]
(
 [BillID] Int NOT NULL,
 [Status] Varchar(10) NOT NULL,
 [GrossBillTotal] Money NOT NULL,
 [Discount] Float NOT NULL,
 [Tax] Money NOT NULL,
 [NetBillTotal] Money NOT NULL,
 [ContractID] Int NOT NULL,
 [CustomerID] Int NULL,
 [SimID] Int NULL
)
go

-- Create indexes for table Bill

CREATE INDEX [IX_Relationship41] ON [Bill] ([ContractID],[CustomerID],[SimID])
go

-- Add keys for table Bill

ALTER TABLE [Bill] ADD CONSTRAINT [Key9] PRIMARY KEY ([BillID])
go

-- Table Location

CREATE TABLE [Location]
(
 [Latitude] Float NOT NULL,
 [Longitude] Float NOT NULL
)
go

-- Add keys for table Location

ALTER TABLE [Location] ADD CONSTRAINT [Key10] PRIMARY KEY ([Latitude],[Longitude])
go

-- Table Towers

CREATE TABLE [Towers]
(
 [TowerID] Int NOT NULL
)
go

-- Add keys for table Towers

ALTER TABLE [Towers] ADD CONSTRAINT [Key11] PRIMARY KEY ([TowerID])
go

-- Table Signal

CREATE TABLE [Signal]
(
 [SimID] Int NOT NULL,
 [TowerID] Int NOT NULL,
 [Latitude] Float NOT NULL,
 [Longitude] Float NOT NULL,
 [Frequency] Bigint NOT NULL,
 [Time] Datetime NOT NULL
)
go

-- Add keys for table Signal

ALTER TABLE [Signal] ADD CONSTRAINT [Key12] PRIMARY KEY ([SimID],[TowerID],[Latitude],[Longitude])
go

-- Table Category

CREATE TABLE [Category]
(
 [CategoryID] Int NOT NULL,
 [CategoryType] Varchar(20) NOT NULL
)
go

-- Add keys for table Category

ALTER TABLE [Category] ADD CONSTRAINT [Key13] PRIMARY KEY ([CategoryID])
go

-- Table Employee

CREATE TABLE [Employee]
(
 [EmployeeID] Int NOT NULL,
 [EmployeeName] Varchar(20) NOT NULL,
 [HireDate] Datetime NOT NULL,
 [EmployeeEmail] Varchar(40) NOT NULL,
 [Phone] Varchar(11) NOT NULL
)
go

-- Add keys for table Employee

ALTER TABLE [Employee] ADD CONSTRAINT [Key14] PRIMARY KEY ([EmployeeID])
go

-- Table Address

CREATE TABLE [Address]
(
 [AddressID] Int NOT NULL,
 [StreetAddress] Varchar(40) NOT NULL,
 [City] Varchar(20) NOT NULL,
 [State] Varchar(20) NOT NULL,
 [Country] Varchar(20) NOT NULL,
 [Zipcode] Int NOT NULL
)
go

-- Add keys for table Address

ALTER TABLE [Address] ADD CONSTRAINT [Key15] PRIMARY KEY ([AddressID])
go

-- Table Employee_Adress

CREATE TABLE [Employee_Adress]
(
 [AddressID] Int NOT NULL,
 [EmployeeID] Int NOT NULL
)
go

-- Add keys for table Employee_Adress

ALTER TABLE [Employee_Adress] ADD CONSTRAINT [Key16] PRIMARY KEY ([AddressID],[EmployeeID])
go

-- Table Customer_Address

CREATE TABLE [Customer_Address]
(
 [AddressID] Int NOT NULL,
 [CustomerID] Int NOT NULL
)
go

-- Add keys for table Customer_Address

ALTER TABLE [Customer_Address] ADD CONSTRAINT [Key17] PRIMARY KEY ([AddressID],[CustomerID])
go

-- Table Payment

CREATE TABLE [Payment]
(
 [Payment ID] Int NOT NULL,
 [Payment_Method] Varchar(20) NULL,
 [Payment_Date] Datetime NULL,
 [Paymen_amount] Money NULL
)
go

-- Add keys for table Payment

ALTER TABLE [Payment] ADD CONSTRAINT [Key18] PRIMARY KEY ([Payment ID])
go

-- Table Payment_Bill

CREATE TABLE [Payment_Bill]
(
 [BillID] Int NOT NULL,
 [Payment ID] Int NOT NULL
)
go

-- Add keys for table Payment_Bill

ALTER TABLE [Payment_Bill] ADD CONSTRAINT [Key19] PRIMARY KEY ([BillID],[Payment ID])
go

-- Create relationships section ------------------------------------------------- 

ALTER TABLE [Phone] ADD CONSTRAINT [Customer Phone] FOREIGN KEY ([CustomerID]) REFERENCES [Customer] ([CustomerID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Text] ADD CONSTRAINT [Text Usage under Contract] FOREIGN KEY ([ContractID], [CustomerID], [SimID]) REFERENCES [Contract] ([ContractID], [CustomerID], [SimID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Voice] ADD CONSTRAINT [Voice Usage under Contract] FOREIGN KEY ([ContractID], [CustomerID], [SimID]) REFERENCES [Contract] ([ContractID], [CustomerID], [SimID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Data] ADD CONSTRAINT [Data Usage under Contract] FOREIGN KEY ([ContractID], [CustomerID], [SimID]) REFERENCES [Contract] ([ContractID], [CustomerID], [SimID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Contract] ADD CONSTRAINT [Contract is based on certain SIM Card] FOREIGN KEY ([SimID]) REFERENCES [SIM Card] ([SimID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Text] ADD CONSTRAINT [Text Usage passing to Bill] FOREIGN KEY ([BillID]) REFERENCES [Bill] ([BillID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Voice] ADD CONSTRAINT [Voice Usage passing to Bill] FOREIGN KEY ([BillID]) REFERENCES [Bill] ([BillID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Data] ADD CONSTRAINT [Data Usage passing to Bill] FOREIGN KEY ([BillID]) REFERENCES [Bill] ([BillID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [SIM Card] ADD CONSTRAINT [Customer using SIM Card] FOREIGN KEY ([CustomerID]) REFERENCES [Customer] ([CustomerID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Signal] ADD CONSTRAINT [SIM Connectivity] FOREIGN KEY ([SimID]) REFERENCES [SIM Card] ([SimID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Signal] ADD CONSTRAINT [Tower Communication] FOREIGN KEY ([TowerID]) REFERENCES [Towers] ([TowerID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [SIM Card] ADD CONSTRAINT [SIM Service Type Flag] FOREIGN KEY ([CategoryID]) REFERENCES [Category] ([CategoryID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Contract] ADD CONSTRAINT [Service Type Flag] FOREIGN KEY ([CategoryID]) REFERENCES [Category] ([CategoryID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Phone] ADD CONSTRAINT [Product Type Flag] FOREIGN KEY ([CategoryID]) REFERENCES [Category] ([CategoryID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Bill] ADD CONSTRAINT [Bill Generation required Contract Info] FOREIGN KEY ([ContractID], [CustomerID], [SimID]) REFERENCES [Contract] ([ContractID], [CustomerID], [SimID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Contract] ADD CONSTRAINT [Employee work on Contract] FOREIGN KEY ([EmployeeID]) REFERENCES [Employee] ([EmployeeID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Employee_Adress] ADD CONSTRAINT [Relationship1] FOREIGN KEY ([AddressID]) REFERENCES [Address] ([AddressID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Employee_Adress] ADD CONSTRAINT [Relationship2] FOREIGN KEY ([EmployeeID]) REFERENCES [Employee] ([EmployeeID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Customer_Address] ADD CONSTRAINT [Relationship5] FOREIGN KEY ([AddressID]) REFERENCES [Address] ([AddressID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Customer_Address] ADD CONSTRAINT [Relationship6] FOREIGN KEY ([CustomerID]) REFERENCES [Customer] ([CustomerID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Contract] ADD CONSTRAINT [Relationship9] FOREIGN KEY ([CustomerID]) REFERENCES [Customer] ([CustomerID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Payment_Bill] ADD CONSTRAINT [Relationship12] FOREIGN KEY ([BillID]) REFERENCES [Bill] ([BillID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Payment_Bill] ADD CONSTRAINT [Relationship13] FOREIGN KEY ([Payment ID]) REFERENCES [Payment] ([Payment ID]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Signal] ADD CONSTRAINT [Relationship15] FOREIGN KEY ([Latitude], [Longitude]) REFERENCES [Location] ([Latitude], [Longitude]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



