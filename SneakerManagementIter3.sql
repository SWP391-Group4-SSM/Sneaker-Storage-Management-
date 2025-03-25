
CREATE DATABASE [SneakerManagementIter3]

ALTER DATABASE [SneakerManagementIter3] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SneakerManagementIter3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SneakerManagementIter3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET ARITHABORT OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [SneakerManagementIter3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SneakerManagementIter3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SneakerManagementIter3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SneakerManagementIter3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SneakerManagementIter3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SneakerManagementIter3] SET  MULTI_USER 
GO
ALTER DATABASE [SneakerManagementIter3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SneakerManagementIter3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SneakerManagementIter3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SneakerManagementIter3] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SneakerManagementIter3] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SneakerManagementIter3] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SneakerManagementIter3] SET QUERY_STORE = ON
GO
ALTER DATABASE [SneakerManagementIter3] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SneakerManagementIter3]
GO
/****** Object:  Table [dbo].[ActivityLog]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityLog](
	[LogID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[Action] [nvarchar](255) NOT NULL,
	[Timestamp] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bins]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bins](
	[BinID] [int] NOT NULL,
	[SectionID] [int] NOT NULL,
	[BinName] [nvarchar](100) NOT NULL,
	[Capacity] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedAt] [datetime] NULL,
	[isDeleted] [bit] NULL,
	[isLocked] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BinID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeliveryOrderDetails]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeliveryOrderDetails](
	[DeliveryOrderDetailID] [int] NOT NULL,
	[DeliveryOrderID] [int] NOT NULL,
	[ProductDetailID] [int] NOT NULL,
	[QuantityOrdered] [int] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DeliveryOrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeliveryOrders]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeliveryOrders](
	[DeliveryOrderID] [int] NOT NULL,
	[SupplierID] [int] NULL,
	[WarehouseID] [int] NOT NULL,
	[CreatedByUserID] [int] NOT NULL,
	[DocumentDate] [datetime] NULL,
	[DocumentStatus] [nvarchar](20) NOT NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DeliveryOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryAuditDetails]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryAuditDetails](
	[InventoryAuditDetailID] [int] NOT NULL,
	[InventoryDocID] [int] NOT NULL,
	[ProductDetailID] [int] NOT NULL,
	[ExpectedQuantity] [int] NOT NULL,
	[CountedQuantity] [int] NULL,
	[Status] [nvarchar](20) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryAuditDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryAuditRecounts]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryAuditRecounts](
	[RecountID] [int] NOT NULL,
	[InventoryAuditDetailID] [int] NOT NULL,
	[RecountQuantity] [int] NOT NULL,
	[Note] [nvarchar](max) NULL,
	[RecounterUserID] [int] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RecountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryAudits]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryAudits](
	[InventoryAuditID] [int] NOT NULL,
	[WarehouseID] [int] NOT NULL,
	[AuditorUserID] [int] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryAuditID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductDetails]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDetails](
	[ProductDetailID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Color] [nvarchar](50) NULL,
	[ImageURL] [nvarchar](255) NULL,
	[Status] [nvarchar](50) NOT NULL,
	[Material] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	[isDeleted] [bit] NULL,
	[Size] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[SKU] [nvarchar](50) NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	[isDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseOrderDetails]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseOrderDetails](
	[PurchaseOrderDetailID] [int] NOT NULL,
	[PurchaseOrderID] [int] NOT NULL,
	[ProductDetailID] [int] NOT NULL,
	[QuantityOrdered] [int] NOT NULL,
	[UnitPrice] [decimal](10, 2) NOT NULL,
	[TotalPrice]  AS ([QuantityOrdered]*[UnitPrice]),
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseOrders]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseOrders](
	[PurchaseOrderID] [int] NOT NULL,
	[SupplierID] [int] NOT NULL,
	[WarehouseID] [int] NOT NULL,
	[CreatedByUserID] [int] NOT NULL,
	[OrderDate] [datetime] NULL,
	[PurchaseOrderStatus] [nvarchar](20) NOT NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stock]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stock](
	[StockID] [int] NOT NULL,
	[ProductDetailID] [int] NOT NULL,
	[WarehouseID] [int] NOT NULL,
	[BinID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[LastUpdated] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [int] NOT NULL,
	[SupplierName] [nvarchar](100) NOT NULL,
	[ContactEmail] [nvarchar](255) NULL,
	[ContactPhone] [nvarchar](20) NULL,
	[Address] [nvarchar](255) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemSettings]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemSettings](
	[SettingID] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](255) NOT NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransferOrderDetails]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransferOrderDetails](
	[TransferOrderDetailID] [int] NOT NULL,
	[TransferOrderID] [int] NOT NULL,
	[ProductDetailID] [int] NOT NULL,
	[SourceBinID] [int] NOT NULL,
	[DestinationBinID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TransferOrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransferOrders]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransferOrders](
	[TransferOrderID] [int] NOT NULL,
	[WarehouseID] [int] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TransferOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
	[Role] [nvarchar](20) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[isDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserWarehouses]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserWarehouses](
	[UserID] [int] NOT NULL,
	[WarehouseID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[WarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WarehouseManagers]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WarehouseManagers](
	[ManagerID] [int] NOT NULL,
	[WarehouseID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ManagerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouses]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouses](
	[WarehouseID] [int] NOT NULL,
	[WarehouseCode] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Location] [nvarchar](255) NOT NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[WarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WarehouseSections]    Script Date: 25.03.2025 21:57:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WarehouseSections](
	[SectionID] [int] NOT NULL,
	[WarehouseID] [int] NOT NULL,
	[SectionName] [nvarchar](100) NOT NULL,
	[Capacity] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Bins] ([BinID], [SectionID], [BinName], [Capacity], [Description], [CreatedAt], [isDeleted], [isLocked]) VALUES (1, 1, N'P-TT-1-1', 50, N'Bin cố định 1 - Khu A - Thạch Thất', CAST(N'2025-03-03T10:50:48.107' AS DateTime), 0, 0)
GO
INSERT [dbo].[Bins] ([BinID], [SectionID], [BinName], [Capacity], [Description], [CreatedAt], [isDeleted], [isLocked]) VALUES (2, 1, N'T-TT-1-2', 50, N'Bin tạm thời 2 - Khu A - Thạch Thất', CAST(N'2025-03-03T10:50:48.107' AS DateTime), 0, 0)
GO
INSERT [dbo].[Bins] ([BinID], [SectionID], [BinName], [Capacity], [Description], [CreatedAt], [isDeleted], [isLocked]) VALUES (3, 2, N'P-TT-2-1', 40, N'Bin cố định 1 - Khu B - Thạch Thất', CAST(N'2025-03-03T10:50:48.110' AS DateTime), 0, 0)
GO
INSERT [dbo].[Bins] ([BinID], [SectionID], [BinName], [Capacity], [Description], [CreatedAt], [isDeleted], [isLocked]) VALUES (4, 2, N'T-TT-2-2', 40, N'Bin tạm thời 2 - Khu B - Thạch Thất', CAST(N'2025-03-03T10:50:48.110' AS DateTime), 0, 0)
GO
INSERT [dbo].[Bins] ([BinID], [SectionID], [BinName], [Capacity], [Description], [CreatedAt], [isDeleted], [isLocked]) VALUES (5, 3, N'P-QO-3-1', 60, N'Bin cố định 1 - Khu A - Quốc Oai', CAST(N'2025-03-03T10:50:48.110' AS DateTime), 0, 0)
GO
INSERT [dbo].[Bins] ([BinID], [SectionID], [BinName], [Capacity], [Description], [CreatedAt], [isDeleted], [isLocked]) VALUES (6, 3, N'T-QO-3-2', 60, N'Bin tạm thời 2 - Khu A - Quốc Oai', CAST(N'2025-03-03T10:50:48.110' AS DateTime), 0, 0)
GO
INSERT [dbo].[Bins] ([BinID], [SectionID], [BinName], [Capacity], [Description], [CreatedAt], [isDeleted], [isLocked]) VALUES (7, 4, N'P-QO-4-1', 50, N'Bin cố định 1 - Khu B - Quốc Oai', CAST(N'2025-03-03T10:50:48.110' AS DateTime), 0, 0)
GO
INSERT [dbo].[Bins] ([BinID], [SectionID], [BinName], [Capacity], [Description], [CreatedAt], [isDeleted], [isLocked]) VALUES (8, 4, N'T-QO-4-2', 50, N'Bin tạm thời 2 - Khu B - Quốc Oai', CAST(N'2025-03-03T10:50:48.110' AS DateTime), 0, 0)
GO
INSERT [dbo].[DeliveryOrderDetails] ([DeliveryOrderDetailID], [DeliveryOrderID], [ProductDetailID], [QuantityOrdered], [CreatedAt], [UpdatedAt]) VALUES (1, 1, 1, 10, CAST(N'2025-03-24T11:54:24.873' AS DateTime), CAST(N'2025-03-24T11:54:24.873' AS DateTime))
GO
INSERT [dbo].[DeliveryOrderDetails] ([DeliveryOrderDetailID], [DeliveryOrderID], [ProductDetailID], [QuantityOrdered], [CreatedAt], [UpdatedAt]) VALUES (2, 1, 2, 5, CAST(N'2025-03-24T11:54:24.873' AS DateTime), CAST(N'2025-03-24T11:54:24.873' AS DateTime))
GO
INSERT [dbo].[DeliveryOrderDetails] ([DeliveryOrderDetailID], [DeliveryOrderID], [ProductDetailID], [QuantityOrdered], [CreatedAt], [UpdatedAt]) VALUES (3, 2, 3, 8, CAST(N'2025-03-24T11:54:24.873' AS DateTime), CAST(N'2025-03-24T11:54:24.873' AS DateTime))
GO
INSERT [dbo].[DeliveryOrders] ([DeliveryOrderID], [SupplierID], [WarehouseID], [CreatedByUserID], [DocumentDate], [DocumentStatus], [UpdatedAt]) VALUES (1, NULL, 1, 5, CAST(N'2025-03-24T11:52:27.203' AS DateTime), N'Draft', CAST(N'2025-03-24T11:52:27.203' AS DateTime))
GO
INSERT [dbo].[DeliveryOrders] ([DeliveryOrderID], [SupplierID], [WarehouseID], [CreatedByUserID], [DocumentDate], [DocumentStatus], [UpdatedAt]) VALUES (2, 1, 2, 3, CAST(N'2025-03-24T11:52:27.203' AS DateTime), N'Processing', CAST(N'2025-03-24T11:52:27.203' AS DateTime))
GO
INSERT [dbo].[InventoryAuditDetails] ([InventoryAuditDetailID], [InventoryDocID], [ProductDetailID], [ExpectedQuantity], [CountedQuantity], [Status], [CreatedAt], [UpdatedAt]) VALUES (1, 1, 1, 100, 95, N'Recount Pending', CAST(N'2025-03-03T12:28:00.383' AS DateTime), CAST(N'2025-03-03T12:28:00.383' AS DateTime))
GO
INSERT [dbo].[InventoryAuditDetails] ([InventoryAuditDetailID], [InventoryDocID], [ProductDetailID], [ExpectedQuantity], [CountedQuantity], [Status], [CreatedAt], [UpdatedAt]) VALUES (2, 1, 2, 50, 50, N'Counted', CAST(N'2025-03-03T12:28:00.383' AS DateTime), CAST(N'2025-03-03T12:28:00.383' AS DateTime))
GO
INSERT [dbo].[InventoryAuditDetails] ([InventoryAuditDetailID], [InventoryDocID], [ProductDetailID], [ExpectedQuantity], [CountedQuantity], [Status], [CreatedAt], [UpdatedAt]) VALUES (3, 2, 3, 200, NULL, N'Pending Count', CAST(N'2025-03-03T12:28:00.383' AS DateTime), CAST(N'2025-03-03T12:28:00.383' AS DateTime))
GO
INSERT [dbo].[InventoryAuditRecounts] ([RecountID], [InventoryAuditDetailID], [RecountQuantity], [Note], [RecounterUserID], [CreatedAt], [UpdatedAt]) VALUES (1, 1, 98, N'Chênh lệch do sai sót nhập liệu', 5, CAST(N'2025-03-03T12:28:06.067' AS DateTime), CAST(N'2025-03-03T12:28:06.067' AS DateTime))
GO
INSERT [dbo].[InventoryAudits] ([InventoryAuditID], [WarehouseID], [AuditorUserID], [Status], [CreatedAt], [UpdatedAt]) VALUES (1, 1, 2, N'Counting', CAST(N'2025-03-03T12:27:54.670' AS DateTime), CAST(N'2025-03-03T12:27:54.670' AS DateTime))
GO
INSERT [dbo].[InventoryAudits] ([InventoryAuditID], [WarehouseID], [AuditorUserID], [Status], [CreatedAt], [UpdatedAt]) VALUES (2, 2, 2, N'In Progress', CAST(N'2025-03-03T12:27:54.670' AS DateTime), CAST(N'2025-03-03T12:27:54.670' AS DateTime))
GO
INSERT [dbo].[ProductDetails] ([ProductDetailID], [ProductID], [Color], [ImageURL], [Status], [Material], [CreatedAt], [UpdatedAt], [isDeleted], [Size]) VALUES (1, 1, N'Đen/Trắng', N'url_adidas_ub22_black_white.jpg', N'Active', N'Primeknit+', CAST(N'2025-02-28T13:13:05.180' AS DateTime), CAST(N'2025-02-28T13:13:05.180' AS DateTime), 0, 42)
GO
INSERT [dbo].[ProductDetails] ([ProductDetailID], [ProductID], [Color], [ImageURL], [Status], [Material], [CreatedAt], [UpdatedAt], [isDeleted], [Size]) VALUES (2, 1, N'Xanh Navy', N'url_adidas_ub22_navy.jpg', N'Active', N'Primeknit+', CAST(N'2025-02-28T13:13:05.180' AS DateTime), CAST(N'2025-02-28T13:13:05.180' AS DateTime), 0, 43)
GO
INSERT [dbo].[ProductDetails] ([ProductDetailID], [ProductID], [Color], [ImageURL], [Status], [Material], [CreatedAt], [UpdatedAt], [isDeleted], [Size]) VALUES (3, 2, N'Trắng/Đỏ', N'url_nike_am90_white_red.jpg', N'Active', N'Da/Lưới', CAST(N'2025-02-28T13:13:05.180' AS DateTime), CAST(N'2025-02-28T13:13:05.180' AS DateTime), 0, 41)
GO
INSERT [dbo].[ProductDetails] ([ProductDetailID], [ProductID], [Color], [ImageURL], [Status], [Material], [CreatedAt], [UpdatedAt], [isDeleted], [Size]) VALUES (4, 2, N'Đen/Xám', N'url_nike_am90_black_grey.jpg', N'Sale off', N'Da/Lưới', CAST(N'2025-02-28T13:13:05.180' AS DateTime), CAST(N'2025-02-28T13:13:05.180' AS DateTime), 0, 40)
GO
INSERT [dbo].[ProductDetails] ([ProductDetailID], [ProductID], [Color], [ImageURL], [Status], [Material], [CreatedAt], [UpdatedAt], [isDeleted], [Size]) VALUES (5, 3, N'Đen/Vàng', N'url_puma_rsx_black_gold.jpg', N'Active', N'Lưới/Da tổng hợp', CAST(N'2025-02-28T13:13:05.183' AS DateTime), CAST(N'2025-02-28T13:13:05.183' AS DateTime), 0, 40)
GO
INSERT [dbo].[ProductDetails] ([ProductDetailID], [ProductID], [Color], [ImageURL], [Status], [Material], [CreatedAt], [UpdatedAt], [isDeleted], [Size]) VALUES (6, 4, N'Đen/Trắng', N'url_vans_oldskool_black_white.jpg', N'Active', N'Canvas/Da lộn', CAST(N'2025-02-28T13:13:05.183' AS DateTime), CAST(N'2025-02-28T13:13:05.183' AS DateTime), 0, 39)
GO
INSERT [dbo].[ProductDetails] ([ProductDetailID], [ProductID], [Color], [ImageURL], [Status], [Material], [CreatedAt], [UpdatedAt], [isDeleted], [Size]) VALUES (7, 5, N'Trắng', N'url_converse_ctas_white.jpg', N'Discontinued', N'Canvas', CAST(N'2025-02-28T13:13:05.183' AS DateTime), CAST(N'2025-02-28T13:13:05.183' AS DateTime), 0, 38)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [SKU], [Price], [CreatedAt], [UpdatedAt], [isDeleted]) VALUES (1, N'Giày Adidas Ultraboost 22', N'Giày chạy bộ cao cấp của Adidas', N'ADIDAS-UB22', CAST(180.00 AS Decimal(10, 2)), CAST(N'2025-02-28T13:13:05.180' AS DateTime), CAST(N'2025-02-28T13:13:05.180' AS DateTime), 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [SKU], [Price], [CreatedAt], [UpdatedAt], [isDeleted]) VALUES (2, N'Giày Nike Air Max 90', N'Giày sneaker kinh điển của Nike', N'NIKE-AM90', CAST(130.00 AS Decimal(10, 2)), CAST(N'2025-02-28T13:13:05.180' AS DateTime), CAST(N'2025-02-28T13:13:05.180' AS DateTime), 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [SKU], [Price], [CreatedAt], [UpdatedAt], [isDeleted]) VALUES (3, N'Giày Puma RS-X', N'Giày sneaker phong cách retro của Puma', N'PUMA-RSX', CAST(110.00 AS Decimal(10, 2)), CAST(N'2025-02-28T13:13:05.180' AS DateTime), CAST(N'2025-02-28T13:13:05.180' AS DateTime), 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [SKU], [Price], [CreatedAt], [UpdatedAt], [isDeleted]) VALUES (4, N'Giày Vans Old Skool', N'Giày sneaker ván trượt của Vans', N'VANS-OLDSKOOL', CAST(70.00 AS Decimal(10, 2)), CAST(N'2025-02-28T13:13:05.180' AS DateTime), CAST(N'2025-02-28T13:13:05.180' AS DateTime), 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [SKU], [Price], [CreatedAt], [UpdatedAt], [isDeleted]) VALUES (5, N'Giày Converse Chuck Taylor', N'Giày sneaker cổ điển của Converse', N'CONVERSE-CTAS', CAST(65.00 AS Decimal(10, 2)), CAST(N'2025-02-28T13:13:05.180' AS DateTime), CAST(N'2025-02-28T13:13:05.180' AS DateTime), 1)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [SKU], [Price], [CreatedAt], [UpdatedAt], [isDeleted]) VALUES (7, N'Nike Air Max', N'Running shoes', N'AMX123', CAST(150.00 AS Decimal(10, 2)), CAST(N'2025-03-14T11:02:00.380' AS DateTime), CAST(N'2025-03-14T11:02:00.380' AS DateTime), 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [SKU], [Price], [CreatedAt], [UpdatedAt], [isDeleted]) VALUES (8, N'2', N'sadfsaf', N'1221', CAST(12.00 AS Decimal(10, 2)), CAST(N'2025-03-14T20:14:46.163' AS DateTime), CAST(N'2025-03-14T20:14:46.163' AS DateTime), 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [SKU], [Price], [CreatedAt], [UpdatedAt], [isDeleted]) VALUES (10, N'sdf', N'sda', N'as', CAST(11.00 AS Decimal(10, 2)), CAST(N'2025-03-14T20:15:19.660' AS DateTime), CAST(N'2025-03-14T20:15:19.660' AS DateTime), 0)
GO
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [SKU], [Price], [CreatedAt], [UpdatedAt], [isDeleted]) VALUES (15, N'giay', N'giay chay bo', N'ADIDAS', CAST(12.00 AS Decimal(10, 2)), CAST(N'2025-03-14T11:43:11.647' AS DateTime), CAST(N'2025-03-14T11:43:11.647' AS DateTime), 1)
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductDetailID], [QuantityOrdered], [UnitPrice], [CreatedAt], [UpdatedAt]) VALUES (1, 1, 1, 2, CAST(11.00 AS Decimal(10, 2)), CAST(N'2025-03-03T05:40:36.047' AS DateTime), CAST(N'2025-03-14T10:39:54.293' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductDetailID], [QuantityOrdered], [UnitPrice], [CreatedAt], [UpdatedAt]) VALUES (2, 1, 2, 3, CAST(15.00 AS Decimal(10, 2)), CAST(N'2025-03-03T05:41:00.000' AS DateTime), CAST(N'2025-03-03T05:41:00.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductDetailID], [QuantityOrdered], [UnitPrice], [CreatedAt], [UpdatedAt]) VALUES (3, 1, 3, 7, CAST(12.00 AS Decimal(10, 2)), CAST(N'2025-03-03T05:41:05.000' AS DateTime), CAST(N'2025-03-03T05:41:05.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductDetailID], [QuantityOrdered], [UnitPrice], [CreatedAt], [UpdatedAt]) VALUES (4, 1, 4, 5, CAST(14.00 AS Decimal(10, 2)), CAST(N'2025-03-03T05:41:10.000' AS DateTime), CAST(N'2025-03-03T05:41:10.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductDetailID], [QuantityOrdered], [UnitPrice], [CreatedAt], [UpdatedAt]) VALUES (6, 2, 1, 8, CAST(11.00 AS Decimal(10, 2)), CAST(N'2025-03-03T05:41:20.000' AS DateTime), CAST(N'2025-03-03T05:41:20.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductDetailID], [QuantityOrdered], [UnitPrice], [CreatedAt], [UpdatedAt]) VALUES (7, 2, 2, 1, CAST(14.00 AS Decimal(10, 2)), CAST(N'2025-03-03T05:41:25.000' AS DateTime), CAST(N'2025-03-13T17:42:07.757' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductDetailID], [QuantityOrdered], [UnitPrice], [CreatedAt], [UpdatedAt]) VALUES (8, 2, 3, 4, CAST(13.50 AS Decimal(10, 2)), CAST(N'2025-03-03T05:41:30.000' AS DateTime), CAST(N'2025-03-03T05:41:30.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductDetailID], [QuantityOrdered], [UnitPrice], [CreatedAt], [UpdatedAt]) VALUES (9, 2, 6, 6, CAST(10.00 AS Decimal(10, 2)), CAST(N'2025-03-03T05:41:35.000' AS DateTime), CAST(N'2025-03-03T05:41:35.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductDetailID], [QuantityOrdered], [UnitPrice], [CreatedAt], [UpdatedAt]) VALUES (10, 2, 7, 9, CAST(16.00 AS Decimal(10, 2)), CAST(N'2025-03-03T05:41:40.000' AS DateTime), CAST(N'2025-03-03T05:41:40.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductDetailID], [QuantityOrdered], [UnitPrice], [CreatedAt], [UpdatedAt]) VALUES (12, 3, 2, 7, CAST(21.00 AS Decimal(10, 2)), CAST(N'2025-03-03T05:41:50.000' AS DateTime), CAST(N'2025-03-03T05:41:50.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductDetailID], [QuantityOrdered], [UnitPrice], [CreatedAt], [UpdatedAt]) VALUES (14, 3, 4, 6, CAST(22.00 AS Decimal(10, 2)), CAST(N'2025-03-03T05:42:00.000' AS DateTime), CAST(N'2025-03-03T05:42:00.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductDetailID], [QuantityOrdered], [UnitPrice], [CreatedAt], [UpdatedAt]) VALUES (15, 3, 5, 8, CAST(25.00 AS Decimal(10, 2)), CAST(N'2025-03-03T05:42:05.000' AS DateTime), CAST(N'2025-03-03T05:42:05.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductDetailID], [QuantityOrdered], [UnitPrice], [CreatedAt], [UpdatedAt]) VALUES (23, 1, 1, 3, CAST(12.00 AS Decimal(10, 2)), CAST(N'2025-03-11T23:11:01.800' AS DateTime), CAST(N'2025-03-13T17:08:15.033' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [SupplierID], [WarehouseID], [CreatedByUserID], [OrderDate], [PurchaseOrderStatus], [TotalAmount], [CreatedAt], [UpdatedAt]) VALUES (1, 1, 1, 2, CAST(N'2002-02-01T00:00:00.000' AS DateTime), N'Approved', CAST(257.00 AS Decimal(10, 2)), CAST(N'2002-12-02T00:00:00.000' AS DateTime), CAST(N'2025-03-14T16:45:09.510' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [SupplierID], [WarehouseID], [CreatedByUserID], [OrderDate], [PurchaseOrderStatus], [TotalAmount], [CreatedAt], [UpdatedAt]) VALUES (2, 2, 2, 2, CAST(N'2002-11-01T00:00:00.000' AS DateTime), N'Approved', CAST(360.00 AS Decimal(10, 2)), CAST(N'2025-03-01T21:42:47.683' AS DateTime), CAST(N'2025-03-03T11:43:15.780' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [SupplierID], [WarehouseID], [CreatedByUserID], [OrderDate], [PurchaseOrderStatus], [TotalAmount], [CreatedAt], [UpdatedAt]) VALUES (3, 3, 2, 2, CAST(N'2003-01-15T00:00:00.000' AS DateTime), N'draft', CAST(609.00 AS Decimal(10, 2)), CAST(N'2025-03-02T23:50:00.000' AS DateTime), CAST(N'2025-03-02T23:50:00.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [SupplierID], [WarehouseID], [CreatedByUserID], [OrderDate], [PurchaseOrderStatus], [TotalAmount], [CreatedAt], [UpdatedAt]) VALUES (9, 2, 2, 5, CAST(N'2025-03-21T10:15:00.000' AS DateTime), N'Draft', CAST(123000.00 AS Decimal(10, 2)), CAST(N'2025-03-03T10:15:23.280' AS DateTime), CAST(N'2025-03-03T10:15:23.280' AS DateTime))
GO
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [ContactEmail], [ContactPhone], [Address], [CreatedAt], [UpdatedAt]) VALUES (1, N'Công ty TNHH ABC Sport', N'contact@abcsport.com', N'0901234567', N'123 Đường XYZ, Hà Nội', CAST(N'2025-03-03T10:50:48.110' AS DateTime), CAST(N'2025-03-03T10:50:48.110' AS DateTime))
GO
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [ContactEmail], [ContactPhone], [Address], [CreatedAt], [UpdatedAt]) VALUES (2, N'Nhà cung cấp Giày dép XYZ', N'sales@xyzshoes.vn', N'0987654321', N'456 Đường UVW, TP.HCM', CAST(N'2025-03-03T10:50:48.110' AS DateTime), CAST(N'2025-03-03T10:50:48.110' AS DateTime))
GO
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [ContactEmail], [ContactPhone], [Address], [CreatedAt], [UpdatedAt]) VALUES (3, N'Công ty Thời trang Thể thao 123', N'info@123sportfashion.com', N'0912345678', N'789 Đường PQR, Đà Nẵng', CAST(N'2025-03-03T10:50:48.110' AS DateTime), CAST(N'2025-03-03T10:50:48.110' AS DateTime))
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role], [CreatedAt], [isDeleted]) VALUES (0, N'admin1', N'admin1', N'Admin', CAST(N'2025-03-12T18:51:08.563' AS DateTime), 0)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role], [CreatedAt], [isDeleted]) VALUES (1, N'admin', N'123', N'Admin', CAST(N'2025-03-03T10:50:48.107' AS DateTime), 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role], [CreatedAt], [isDeleted]) VALUES (2, N'supervisor', N'123', N'Supervisor', CAST(N'2025-03-03T10:50:48.107' AS DateTime), 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role], [CreatedAt], [isDeleted]) VALUES (3, N'manager_tt', N'333', N'Manager', CAST(N'2025-03-12T18:11:41.127' AS DateTime), 0)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role], [CreatedAt], [isDeleted]) VALUES (4, N'manager_qo', N'123', N'Manager', CAST(N'2025-03-03T10:50:48.107' AS DateTime), 0)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role], [CreatedAt], [isDeleted]) VALUES (5, N'staff_tt1', N'123', N'Staff', CAST(N'2025-03-03T10:50:48.107' AS DateTime), 0)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role], [CreatedAt], [isDeleted]) VALUES (6, N'staff_qo1', N'123', N'Staff', CAST(N'2025-03-03T10:50:48.107' AS DateTime), 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role], [CreatedAt], [isDeleted]) VALUES (7, N'admin_qo1', N'Admin@123', N'Admin', CAST(N'2025-03-03T11:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role], [CreatedAt], [isDeleted]) VALUES (8, N'supervisor_qo1', N'Sup@123', N'Supervisor', CAST(N'2025-03-03T11:05:00.000' AS DateTime), 0)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role], [CreatedAt], [isDeleted]) VALUES (9, N'manager_qo1', N'Man@123', N'Manager', CAST(N'2025-03-03T11:10:00.000' AS DateTime), 0)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role], [CreatedAt], [isDeleted]) VALUES (10, N'staff_qo2', N'Staff@123', N'Staff', CAST(N'2025-03-03T11:15:00.000' AS DateTime), 0)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role], [CreatedAt], [isDeleted]) VALUES (111, N'admin111', N'admin111', N'Admin', CAST(N'2025-03-12T19:16:11.323' AS DateTime), 0)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role], [CreatedAt], [isDeleted]) VALUES (1111, N'admin1111', N'admin1111', N'Admin', CAST(N'2025-03-12T19:16:49.230' AS DateTime), 0)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role], [CreatedAt], [isDeleted]) VALUES (123456, N'admin123456', N'admin123456', N'Admin', CAST(N'2025-03-14T22:00:31.523' AS DateTime), 0)
GO
INSERT [dbo].[UserWarehouses] ([UserID], [WarehouseID]) VALUES (2, 1)
GO
INSERT [dbo].[UserWarehouses] ([UserID], [WarehouseID]) VALUES (2, 2)
GO
INSERT [dbo].[UserWarehouses] ([UserID], [WarehouseID]) VALUES (3, 1)
GO
INSERT [dbo].[UserWarehouses] ([UserID], [WarehouseID]) VALUES (4, 2)
GO
INSERT [dbo].[UserWarehouses] ([UserID], [WarehouseID]) VALUES (5, 1)
GO
INSERT [dbo].[UserWarehouses] ([UserID], [WarehouseID]) VALUES (6, 2)
GO
INSERT [dbo].[WarehouseManagers] ([ManagerID], [WarehouseID]) VALUES (3, 1)
GO
INSERT [dbo].[WarehouseManagers] ([ManagerID], [WarehouseID]) VALUES (4, 2)
GO
INSERT [dbo].[Warehouses] ([WarehouseID], [WarehouseCode], [Name], [Location], [CreatedAt]) VALUES (1, N'TT', N'Kho Thạch Thất', N'Thạch Thất, Hà Nội', CAST(N'2025-03-03T10:50:48.107' AS DateTime))
GO
INSERT [dbo].[Warehouses] ([WarehouseID], [WarehouseCode], [Name], [Location], [CreatedAt]) VALUES (2, N'QO', N'Kho Quốc Oai', N'Quốc Oai, Hà Nội', CAST(N'2025-03-03T10:50:48.107' AS DateTime))
GO
INSERT [dbo].[WarehouseSections] ([SectionID], [WarehouseID], [SectionName], [Capacity], [Description], [CreatedAt]) VALUES (1, 1, N'Khu A - Thạch Thất', 1000, N'Khu vực chứa hàng hóa thông thường', CAST(N'2025-03-03T10:50:48.107' AS DateTime))
GO
INSERT [dbo].[WarehouseSections] ([SectionID], [WarehouseID], [SectionName], [Capacity], [Description], [CreatedAt]) VALUES (2, 1, N'Khu B - Thạch Thất', 500, N'Khu vực hàng phiên bản giới hạn', CAST(N'2025-03-03T10:50:48.107' AS DateTime))
GO
INSERT [dbo].[WarehouseSections] ([SectionID], [WarehouseID], [SectionName], [Capacity], [Description], [CreatedAt]) VALUES (3, 2, N'Khu A - Quốc Oai', 1200, N'Khu vực hàng hóa mùa hè', CAST(N'2025-03-03T10:50:48.107' AS DateTime))
GO
INSERT [dbo].[WarehouseSections] ([SectionID], [WarehouseID], [SectionName], [Capacity], [Description], [CreatedAt]) VALUES (4, 2, N'Khu B - Quốc Oai', 800, N'Khu vực hàng hóa mùa đông', CAST(N'2025-03-03T10:50:48.107' AS DateTime))
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E4F69B6097]    Script Date: 25.03.2025 21:57:38 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Warehous__1686A056A32901CC]    Script Date: 25.03.2025 21:57:38 ******/
ALTER TABLE [dbo].[Warehouses] ADD UNIQUE NONCLUSTERED 
(
	[WarehouseCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ActivityLog] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Bins] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Bins] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Bins] ADD  DEFAULT ((0)) FOR [isLocked]
GO
ALTER TABLE [dbo].[DeliveryOrderDetails] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[DeliveryOrderDetails] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[DeliveryOrders] ADD  DEFAULT (getdate()) FOR [DocumentDate]
GO
ALTER TABLE [dbo].[DeliveryOrders] ADD  DEFAULT ('Pending') FOR [DocumentStatus]
GO
ALTER TABLE [dbo].[DeliveryOrders] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[InventoryAuditDetails] ADD  DEFAULT ('Pending Count') FOR [Status]
GO
ALTER TABLE [dbo].[InventoryAuditDetails] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[InventoryAuditDetails] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[InventoryAuditRecounts] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[InventoryAuditRecounts] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[InventoryAudits] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[InventoryAudits] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[ProductDetails] ADD  DEFAULT ('Active') FOR [Status]
GO
ALTER TABLE [dbo].[ProductDetails] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[ProductDetails] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[ProductDetails] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[PurchaseOrderDetails] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[PurchaseOrderDetails] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[PurchaseOrders] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[PurchaseOrders] ADD  DEFAULT ('Draft') FOR [PurchaseOrderStatus]
GO
ALTER TABLE [dbo].[PurchaseOrders] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[PurchaseOrders] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Stock] ADD  DEFAULT (getdate()) FOR [LastUpdated]
GO
ALTER TABLE [dbo].[Suppliers] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Suppliers] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[SystemSettings] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[TransferOrderDetails] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[TransferOrderDetails] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[TransferOrders] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[TransferOrders] ADD  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Warehouses] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[WarehouseSections] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[ActivityLog]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Bins]  WITH CHECK ADD FOREIGN KEY([SectionID])
REFERENCES [dbo].[WarehouseSections] ([SectionID])
GO
ALTER TABLE [dbo].[DeliveryOrderDetails]  WITH CHECK ADD FOREIGN KEY([DeliveryOrderID])
REFERENCES [dbo].[DeliveryOrders] ([DeliveryOrderID])
GO
ALTER TABLE [dbo].[DeliveryOrderDetails]  WITH CHECK ADD FOREIGN KEY([ProductDetailID])
REFERENCES [dbo].[ProductDetails] ([ProductDetailID])
GO
ALTER TABLE [dbo].[DeliveryOrders]  WITH CHECK ADD FOREIGN KEY([CreatedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[DeliveryOrders]  WITH CHECK ADD FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[DeliveryOrders]  WITH CHECK ADD FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[InventoryAuditDetails]  WITH CHECK ADD FOREIGN KEY([InventoryDocID])
REFERENCES [dbo].[InventoryAudits] ([InventoryAuditID])
GO
ALTER TABLE [dbo].[InventoryAuditDetails]  WITH CHECK ADD FOREIGN KEY([ProductDetailID])
REFERENCES [dbo].[ProductDetails] ([ProductDetailID])
GO
ALTER TABLE [dbo].[InventoryAuditRecounts]  WITH CHECK ADD FOREIGN KEY([InventoryAuditDetailID])
REFERENCES [dbo].[InventoryAuditDetails] ([InventoryAuditDetailID])
GO
ALTER TABLE [dbo].[InventoryAuditRecounts]  WITH CHECK ADD FOREIGN KEY([RecounterUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[InventoryAudits]  WITH CHECK ADD FOREIGN KEY([AuditorUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[InventoryAudits]  WITH CHECK ADD FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[ProductDetails]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductDetails]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductDetails]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[PurchaseOrderDetails]  WITH CHECK ADD FOREIGN KEY([ProductDetailID])
REFERENCES [dbo].[ProductDetails] ([ProductDetailID])
GO
ALTER TABLE [dbo].[PurchaseOrderDetails]  WITH CHECK ADD FOREIGN KEY([ProductDetailID])
REFERENCES [dbo].[ProductDetails] ([ProductDetailID])
GO
ALTER TABLE [dbo].[PurchaseOrderDetails]  WITH CHECK ADD FOREIGN KEY([ProductDetailID])
REFERENCES [dbo].[ProductDetails] ([ProductDetailID])
GO
ALTER TABLE [dbo].[PurchaseOrderDetails]  WITH CHECK ADD FOREIGN KEY([PurchaseOrderID])
REFERENCES [dbo].[PurchaseOrders] ([PurchaseOrderID])
GO
ALTER TABLE [dbo].[PurchaseOrderDetails]  WITH CHECK ADD FOREIGN KEY([PurchaseOrderID])
REFERENCES [dbo].[PurchaseOrders] ([PurchaseOrderID])
GO
ALTER TABLE [dbo].[PurchaseOrderDetails]  WITH CHECK ADD FOREIGN KEY([PurchaseOrderID])
REFERENCES [dbo].[PurchaseOrders] ([PurchaseOrderID])
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD FOREIGN KEY([CreatedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD FOREIGN KEY([CreatedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD FOREIGN KEY([CreatedByUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD FOREIGN KEY([BinID])
REFERENCES [dbo].[Bins] ([BinID])
GO
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD FOREIGN KEY([ProductDetailID])
REFERENCES [dbo].[ProductDetails] ([ProductDetailID])
GO
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[TransferOrderDetails]  WITH CHECK ADD FOREIGN KEY([DestinationBinID])
REFERENCES [dbo].[Bins] ([BinID])
GO
ALTER TABLE [dbo].[TransferOrderDetails]  WITH CHECK ADD FOREIGN KEY([ProductDetailID])
REFERENCES [dbo].[ProductDetails] ([ProductDetailID])
GO
ALTER TABLE [dbo].[TransferOrderDetails]  WITH CHECK ADD FOREIGN KEY([SourceBinID])
REFERENCES [dbo].[Bins] ([BinID])
GO
ALTER TABLE [dbo].[TransferOrderDetails]  WITH CHECK ADD FOREIGN KEY([TransferOrderID])
REFERENCES [dbo].[TransferOrders] ([TransferOrderID])
GO
ALTER TABLE [dbo].[TransferOrders]  WITH CHECK ADD FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[UserWarehouses]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserWarehouses]  WITH CHECK ADD FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[WarehouseManagers]  WITH CHECK ADD FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[WarehouseManagers]  WITH CHECK ADD FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[WarehouseSections]  WITH CHECK ADD FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[DeliveryOrders]  WITH CHECK ADD CHECK  (([DocumentStatus]='Completed' OR [DocumentStatus]='Processing' OR [DocumentStatus]='GoodsReceived' OR [DocumentStatus]='Draft'))
GO
ALTER TABLE [dbo].[InventoryAuditDetails]  WITH CHECK ADD CHECK  (([Status]='Differences Cleared' OR [Status]='Recount Pending' OR [Status]='Counted' OR [Status]='Pending Count'))
GO
ALTER TABLE [dbo].[InventoryAudits]  WITH CHECK ADD CHECK  (([Status]='Differences Cleared' OR [Status]='Completed' OR [Status]='Counting' OR [Status]='In Progress' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[ProductDetails]  WITH CHECK ADD CHECK  (([Status]='Sale off' OR [Status]='Discontinued' OR [Status]='Inactive' OR [Status]='Active'))
GO
ALTER TABLE [dbo].[ProductDetails]  WITH CHECK ADD CHECK  (([Status]='Sale off' OR [Status]='Discontinued' OR [Status]='Inactive' OR [Status]='Active'))
GO
ALTER TABLE [dbo].[ProductDetails]  WITH CHECK ADD CHECK  (([Status]='Sale off' OR [Status]='Discontinued' OR [Status]='Inactive' OR [Status]='Active'))
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD CHECK  (([PurchaseOrderStatus]='Goods Received' OR [PurchaseOrderStatus]='Ordered' OR [PurchaseOrderStatus]='Approved' OR [PurchaseOrderStatus]='Draft'))
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD CHECK  (([PurchaseOrderStatus]='Goods Received' OR [PurchaseOrderStatus]='Ordered' OR [PurchaseOrderStatus]='Approved' OR [PurchaseOrderStatus]='Draft'))
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD CHECK  (([PurchaseOrderStatus]='Goods Received' OR [PurchaseOrderStatus]='Ordered' OR [PurchaseOrderStatus]='Approved' OR [PurchaseOrderStatus]='Draft'))
GO
ALTER TABLE [dbo].[TransferOrderDetails]  WITH CHECK ADD CHECK  (([Status]='Cancelled' OR [Status]='Completed' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[TransferOrders]  WITH CHECK ADD CHECK  (([Status]='Cancelled' OR [Status]='Completed' OR [Status]='Pending'))
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD CHECK  (([Role]='Staff' OR [Role]='Manager' OR [Role]='Supervisor' OR [Role]='Admin'))
GO
USE [master]
GO
ALTER DATABASE [SneakerManagementIter3] SET  READ_WRITE 
GO
