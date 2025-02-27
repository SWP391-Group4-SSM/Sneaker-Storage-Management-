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

-- Bảng Warehouses (Không thay đổi)
CREATE TABLE Warehouses (
    WarehouseID INT PRIMARY KEY,
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

-- Bảng Bins (Không thay đổi)
CREATE TABLE Bins (
    BinID INT PRIMARY KEY,
    SectionID INT NOT NULL,
    BinName NVARCHAR(100) NOT NULL,
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

-- Bảng Suppliers (Không thay đổi)
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName NVARCHAR(100) NOT NULL,
    ContactPerson NVARCHAR(100),
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

-- Bảng DeliveryOrders (bỏ cột DocumentType, RecipientName, ShippingAddress và CreatedAt)
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

-- Trigger tự động cập nhật TotalAmount trong PurchaseOrders 
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