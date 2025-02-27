USE SneakerManagementIter2;
GO

-- Bảng Users (Không thay đổi)
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL, 
    Role NVARCHAR(20) CHECK (Role IN ('Admin', 'Supervisor', 'Manager', 'Staff')) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Bảng Warehouses (Đã chỉnh sửa - Thêm cột WarehouseCode)
CREATE TABLE Warehouses (
    WarehouseID INT PRIMARY KEY,
    WarehouseCode NVARCHAR(50) NOT NULL UNIQUE, -- Mã ngắn gọn, duy nhất của kho (ví dụ: HN, HCM)
    Name NVARCHAR(100) NOT NULL,
    Location NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Bảng WarehouseSections (Không thay đổi)
CREATE TABLE WarehouseSections (
    SectionID INT PRIMARY KEY,
    WarehouseID INT NOT NULL,
    SectionName NVARCHAR(100) NOT NULL,
    Capacity INT NOT NULL,
    Description NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);

-- Bảng Bins ( BinName theo format mới P/T-[WarehouseCode]-[SectionID]-[BinID])
CREATE TABLE Bins (
    BinID INT PRIMARY KEY,
    SectionID INT NOT NULL,
    BinName NVARCHAR(100) NOT NULL, -- Tên Bin theo format mới P/T-[WarehouseCode]-[SectionID]-[BinID]
    Capacity INT NOT NULL,
    Description NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (SectionID) REFERENCES WarehouseSections(SectionID)
);

-- Bảng Products (Không thay đổi)
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    SKU NVARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

-- Bảng ProductDetails (Không thay đổi)
CREATE TABLE ProductDetails (
    ProductDetailID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    Size NVARCHAR(50),
    Color NVARCHAR(50),
    ImageURL NVARCHAR(255),
    Status NVARCHAR(50) CHECK (Status IN ('Active', 'Inactive', 'Discontinued', 'Sale off')) NOT NULL DEFAULT 'Active',
    Material NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Bảng Stock (Không thay đổi)
CREATE TABLE Stock (
    StockID INT PRIMARY KEY,
    ProductDetailID INT NOT NULL,
    WarehouseID INT NOT NULL,
    BinID INT NOT NULL,
    Quantity INT NOT NULL,
    LastUpdated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductDetailID) REFERENCES ProductDetails(ProductDetailID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID),
    FOREIGN KEY (BinID) REFERENCES Bins(BinID)
);

-- Bảng UserWarehouses (Không thay đổi)
CREATE TABLE UserWarehouses (
    UserID INT NOT NULL,
    WarehouseID INT NOT NULL,
    PRIMARY KEY (UserID, WarehouseID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);

-- Bảng WarehouseManagers (Không thay đổi)
CREATE TABLE WarehouseManagers (
    ManagerID INT PRIMARY KEY,
    WarehouseID INT NOT NULL,
    FOREIGN KEY (ManagerID) REFERENCES Users(UserID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);

-- Bảng ActivityLog (Không thay đổi)
CREATE TABLE ActivityLog (
    LogID INT PRIMARY KEY,
    UserID INT NOT NULL,
    Action NVARCHAR(255) NOT NULL,
    Timestamp DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Bảng SystemSettings (Không thay đổi)
CREATE TABLE SystemSettings (
    SettingID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Value NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Bảng Suppliers (Loại bỏ cột ContactPerson)
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName NVARCHAR(100) NOT NULL,
    ContactEmail NVARCHAR(255),
    ContactPhone NVARCHAR(20),
    Address NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

-- Bảng PurchaseOrders (Không thay đổi)
CREATE TABLE PurchaseOrders (
    PurchaseOrderID INT PRIMARY KEY,
    SupplierID INT NOT NULL,
    WarehouseID INT NOT NULL,
    CreatedByUserID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    PurchaseOrderStatus NVARCHAR(20) CHECK (PurchaseOrderStatus IN ('Draft', 'Approved', 'Ordered', 'Goods Received')) NOT NULL DEFAULT 'Draft',
    TotalAmount DECIMAL(10,2) ,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID),
    FOREIGN KEY (CreatedByUserID) REFERENCES Users(UserID)
);

-- Bảng PurchaseOrderDetails (Không thay đổi)
CREATE TABLE PurchaseOrderDetails (
    PurchaseOrderDetailID INT PRIMARY KEY,
    PurchaseOrderID INT NOT NULL,
    ProductDetailID INT NOT NULL,
    QuantityOrdered INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    TotalPrice AS (QuantityOrdered * UnitPrice),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrders(PurchaseOrderID),
    FOREIGN KEY (ProductDetailID) REFERENCES ProductDetails(ProductDetailID)
);

-- Bảng DeliveryOrders (Không thay đổi)
CREATE TABLE DeliveryOrders (
    DeliveryOrderID INT PRIMARY KEY,
    SupplierID INT NULL,
    WarehouseID INT NOT NULL,
    CreatedByUserID INT NOT NULL,
    DocumentDate DATETIME DEFAULT GETDATE(),
    DocumentStatus NVARCHAR(20) CHECK (DocumentStatus IN ('Draft', 'GoodsReceived', 'Processing', 'Completed')) NOT NULL DEFAULT 'Pending',
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID),
    FOREIGN KEY (CreatedByUserID) REFERENCES Users(UserID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Bảng DeliveryOrderDetails (Không thay đổi)
CREATE TABLE DeliveryOrderDetails (
    DeliveryOrderDetailID INT PRIMARY KEY,
    DeliveryOrderID INT NOT NULL,
    ProductDetailID INT NOT NULL,
    QuantityOrdered INT NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (DeliveryOrderID) REFERENCES DeliveryOrders(DeliveryOrderID),
    FOREIGN KEY (ProductDetailID) REFERENCES ProductDetails(ProductDetailID)
);

-- Bảng InventoryAudits (Không thay đổi)
CREATE TABLE InventoryAudits (
    InventoryAuditID INT PRIMARY KEY,
    WarehouseID INT NOT NULL,
    AuditorUserID INT NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('Pending', 'In Progress', 'Counting', 'Completed', 'Differences Cleared')) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID),
    FOREIGN KEY (AuditorUserID) REFERENCES Users(UserID)
);

-- Bảng InventoryAuditDetails (Không thay đổi)
CREATE TABLE InventoryAuditDetails (
    InventoryAuditDetailID INT PRIMARY KEY,
    InventoryDocID INT NOT NULL,
    ProductDetailID INT NOT NULL,
    ExpectedQuantity INT NOT NULL,
    CountedQuantity INT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('Pending Count', 'Counted', 'Recount Pending', 'Differences Cleared')) NOT NULL DEFAULT 'Pending Count',
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (InventoryDocID) REFERENCES InventoryAudits(InventoryAuditID),
    FOREIGN KEY (ProductDetailID) REFERENCES ProductDetails(ProductDetailID)
);

-- Bảng InventoryAuditRecounts (Không thay đổi)
CREATE TABLE InventoryAuditRecounts (
    RecountID INT PRIMARY KEY,
    InventoryAuditDetailID INT NOT NULL,
    RecountQuantity INT NOT NULL,
    Note NVARCHAR(MAX),
    RecounterUserID INT NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (InventoryAuditDetailID) REFERENCES InventoryAuditDetails(InventoryAuditDetailID),
    FOREIGN KEY (RecounterUserID) REFERENCES Users(UserID)
);

-- Bảng TransferOrders (Không thay đổi)
CREATE TABLE TransferOrders (
    TransferOrderID INT PRIMARY KEY,
    WarehouseID INT NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('Pending', 'Completed', 'Cancelled')) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);

-- Bảng TransferOrderDetails (Không thay đổi)
CREATE TABLE TransferOrderDetails (
    TransferOrderDetailID INT PRIMARY KEY,
    TransferOrderID INT NOT NULL,
    ProductDetailID INT NOT NULL,
    SourceBinID INT NOT NULL,
    DestinationBinID INT NOT NULL,
    Quantity INT NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('Pending', 'Completed', 'Cancelled')) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (TransferOrderID) REFERENCES TransferOrders(TransferOrderID),
    FOREIGN KEY (ProductDetailID) REFERENCES ProductDetails(ProductDetailID),
    FOREIGN KEY (SourceBinID) REFERENCES Bins(BinID),
    FOREIGN KEY (DestinationBinID) REFERENCES Bins(BinID)
);

GO

-- Trigger tự động cập nhật TotalAmount trong PurchaseOrders bảng (Không thay đổi)
CREATE TRIGGER TR_PurchaseOrderDetails_TotalAmount
ON PurchaseOrderDetails
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE PO
    SET PO.TotalAmount = (
        SELECT SUM(PODetail.TotalPrice)
        FROM PurchaseOrderDetails PODetail
        WHERE PODetail.PurchaseOrderID = PO.PurchaseOrderID
    )
    FROM PurchaseOrders PO
    WHERE PO.PurchaseOrderID IN (SELECT DISTINCT PurchaseOrderID FROM inserted UNION ALL SELECT DISTINCT PurchaseOrderID FROM deleted);

    SET NOCOUNT OFF;
END;
GO

-- Bảng Users
INSERT INTO Users (UserID, Username, PasswordHash, Role) VALUES
(1, N'admin', N'123', 'Admin'), -- Password: 123 (SHA1 Hash)
(2, N'supervisor', N'123', 'Supervisor'), -- Password: 123 (SHA1 Hash)
(3, N'manager_tt', N'123', 'Manager'), -- Password: 123 (SHA1 Hash) - Manager Thạch Thất
(4, N'manager_qo', N'123', 'Manager'), -- Password: 123 (SHA1 Hash) - Manager Quốc Oai
(5, N'staff_tt1', N'123', 'Staff'),   -- Password: 123 (SHA1 Hash) - Staff 1 Thạch Thất
(6, N'staff_qo1', N'123', 'Staff');   -- Password: 123 (SHA1 Hash) - Staff 1 Quốc Oai

-- Bảng Warehouses
INSERT INTO Warehouses (WarehouseID, WarehouseCode, Name, Location) VALUES
(1, 'TT', N'Kho Thạch Thất', N'Thạch Thất, Hà Nội'),
(2, 'QO', N'Kho Quốc Oai', N'Quốc Oai, Hà Nội');

-- Bảng WarehouseSections - Kho Thạch Thất
INSERT INTO WarehouseSections (SectionID, WarehouseID, SectionName, Capacity, Description) VALUES
(1, 1, N'Khu A - Thạch Thất', 1000, N'Khu vực chứa hàng hóa thông thường'),
(2, 1, N'Khu B - Thạch Thất', 500, N'Khu vực hàng dễ vỡ');

-- Bảng WarehouseSections - Kho Quốc Oai
INSERT INTO WarehouseSections (SectionID, WarehouseID, SectionName, Capacity, Description) VALUES
(3, 2, N'Khu A - Quốc Oai', 1200, N'Khu vực hàng hóa mùa hè'),
(4, 2, N'Khu B - Quốc Oai', 800, N'Khu vực hàng hóa mùa đông');

-- Bảng Bins - Khu A - Thạch Thất
INSERT INTO Bins (BinID, SectionID, BinName, Capacity, Description) VALUES
(1, 1, 'P-TT-1-1', 50, N'Bin cố định 1 - Khu A - Thạch Thất'), -- Permanent Bin
(2, 1, 'T-TT-1-2', 50, N'Bin tạm thời 2 - Khu A - Thạch Thất'); -- Temporary Bin

-- Bảng Bins - Khu B - Thạch Thất
INSERT INTO Bins (BinID, SectionID, BinName, Capacity, Description) VALUES
(3, 2, 'P-TT-2-1', 40, N'Bin cố định 1 - Khu B - Thạch Thất'), -- Permanent Bin
(4, 2, 'T-TT-2-2', 40, N'Bin tạm thời 2 - Khu B - Thạch Thất'); -- Temporary Bin

-- Bảng Bins - Khu A - Quốc Oai
INSERT INTO Bins (BinID, SectionID, BinName, Capacity, Description) VALUES
(5, 3, 'P-QO-3-1', 60, N'Bin cố định 1 - Khu A - Quốc Oai'), -- Permanent Bin
(6, 3, 'T-QO-3-2', 60, N'Bin tạm thời 2 - Khu A - Quốc Oai'); -- Temporary Bin

-- Bảng Bins - Khu B - Quốc Oai
INSERT INTO Bins (BinID, SectionID, BinName, Capacity, Description) VALUES
(7, 4, 'P-QO-4-1', 50, N'Bin cố định 1 - Khu B - Quốc Oai'), -- Permanent Bin
(8, 4, 'T-QO-4-2', 50, N'Bin tạm thời 2 - Khu B - Quốc Oai'); -- Temporary Bin

-- Bảng Products
INSERT INTO Products (ProductID, Name, Description, SKU, Price, UpdatedAt) VALUES
(1, N'Giày Adidas Ultraboost 22', N'Giày chạy bộ cao cấp của Adidas', 'ADIDAS-UB22', 180.00, GETDATE()),
(2, N'Giày Nike Air Max 90', N'Giày sneaker kinh điển của Nike', 'NIKE-AM90', 130.00, GETDATE()),
(3, N'Giày Puma RS-X', N'Giày sneaker phong cách retro của Puma', 'PUMA-RSX', 110.00, GETDATE()),
(4, N'Giày Vans Old Skool', N'Giày sneaker ván trượt của Vans', 'VANS-OLDSKOOL', 70.00, GETDATE()),
(5, N'Giày Converse Chuck Taylor', N'Giày sneaker cổ điển của Converse', 'CONVERSE-CTAS', 65.00, GETDATE());

-- Bảng ProductDetails - Ví dụ ProductDetails cho ProductID = 1 (Adidas Ultraboost 22)
INSERT INTO ProductDetails (ProductDetailID, ProductID, Size, Color, ImageURL, Status, Material, UpdatedAt) VALUES
(1, 1, '42', N'Đen/Trắng', 'url_adidas_ub22_black_white.jpg', 'Active', N'Primeknit+', GETDATE()),
(2, 1, '43', N'Xanh Navy', 'url_adidas_ub22_navy.jpg', 'Active', N'Primeknit+', GETDATE());

-- Bảng ProductDetails - Ví dụ ProductDetails cho ProductID = 2 (Nike Air Max 90)
INSERT INTO ProductDetails (ProductDetailID, ProductID, Size, Color, ImageURL, Status, Material, UpdatedAt) VALUES
(3, 2, '41', N'Trắng/Đỏ', 'url_nike_am90_white_red.jpg', 'Active', N'Da/Lưới', GETDATE()),
(4, 2, '40', N'Đen/Xám', 'url_nike_am90_black_grey.jpg', 'Sale off', N'Da/Lưới', GETDATE()); -- Ví dụ Sale off

-- Bảng ProductDetails - Ví dụ ProductDetails cho ProductID = 3 (Puma RS-X)
INSERT INTO ProductDetails (ProductDetailID, ProductID, Size, Color, ImageURL, Status, Material, UpdatedAt) VALUES
(5, 3, '40', N'Đen/Vàng', 'url_puma_rsx_black_gold.jpg', 'Active', N'Lưới/Da tổng hợp', GETDATE());

-- Bảng ProductDetails - Ví dụ ProductDetails cho ProductID = 4 (Vans Old Skool)
INSERT INTO ProductDetails (ProductDetailID, ProductID, Size, Color, ImageURL, Status, Material, UpdatedAt) VALUES
(6, 4, '39', N'Đen/Trắng', 'url_vans_oldskool_black_white.jpg', 'Active', N'Canvas/Da lộn', GETDATE());

-- Bảng ProductDetails - Ví dụ ProductDetails cho ProductID = 5 (Converse Chuck Taylor)
INSERT INTO ProductDetails (ProductDetailID, ProductID, Size, Color, ImageURL, Status, Material, UpdatedAt) VALUES
(7, 5, '38', N'Trắng', 'url_converse_ctas_white.jpg', 'Discontinued', N'Canvas', GETDATE()); -- Ví dụ Discontinued

-- Bảng Suppliers
INSERT INTO Suppliers (SupplierID, SupplierName, ContactEmail, ContactPhone, Address) VALUES
(1, N'Công ty TNHH ABC Sport', 'contact@abcsport.com', '0901234567', N'123 Đường XYZ, Hà Nội'),
(2, N'Nhà cung cấp Giày dép XYZ', 'sales@xyzshoes.vn', '0987654321', N'456 Đường UVW, TP.HCM'),
(3, N'Công ty Thời trang Thể thao 123', 'info@123sportfashion.com', '0912345678', N'789 Đường PQR, Đà Nẵng');

-- Bảng UserWarehouses (Phân quyền quản lý kho)
INSERT INTO UserWarehouses (UserID, WarehouseID) VALUES
(2, 1), -- Supervisor quản lý Kho Thạch Thất
(2, 2), -- Supervisor quản lý Kho Quốc Oai
(3, 1), -- Manager Thạch Thất quản lý Kho Thạch Thất
(4, 2), -- Manager Quốc Oai quản lý Kho Quốc Oai
(5, 1), -- Staff 1 Thạch Thất làm việc tại Kho Thạch Thất
(6, 2); -- Staff 1 Quốc Oai làm việc tại Kho Quốc Oai

-- Bảng WarehouseManagers
INSERT INTO WarehouseManagers (ManagerID, WarehouseID) VALUES
(3, 1), -- Manager Thạch Thất quản lý Kho Thạch Thất
(4, 2); -- Manager Quốc Oai quản lý Kho Quốc Oai
