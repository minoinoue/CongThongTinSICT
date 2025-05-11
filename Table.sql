-- Create Database
CREATE DATABASE SICT_HAUI;
GO

USE SICT_HAUI;
GO

-- Table 0: Admin
CREATE TABLE Admin (
    AdminID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    NgayDangKy DATETIME
);
GO

-- Table 1: TheLoai (Main categories)
CREATE TABLE TheLoai (
    MaTheLoai INT PRIMARY KEY, -- Assuming MaTheLoai is a unique identifier
    TenTheLoai NVARCHAR(50) NOT NULL,
    VisibleTheLoai BIT DEFAULT 0, -- 0: hidden, 1: visible on menu
    VisibleTheLoai1 BIT DEFAULT 0, -- 0: hidden, 1: visible on data group
    SapXep INT, -- Sorting order
    Url VARCHAR(255), -- URL for redirection
    Target VARCHAR(15), -- Window target (_blank, _self, etc.)
    LinkNgoai BIT DEFAULT 0 -- 0: internal, 1: external link
);
GO

-- Table 2: TheLoaiTin (Subcategories)
CREATE TABLE TheLoaiTin (
    MaTheLoaiTin INT PRIMARY KEY, -- Assuming MaTheLoaiTin is a unique identifier
    TenTheLoaiTin NVARCHAR(50) NOT NULL,
    VisibleTheLoaiTin BIT DEFAULT 0, -- 0: hidden, 1: visible on menu
    VisibleTheLoaiTin1 BIT DEFAULT 0, -- 0: hidden, 1: visible on data group
    SapXep INT, -- Sorting order
    Url VARCHAR(255), -- URL for redirection
    Target VARCHAR(15), -- Window target
    LinkNgoai BIT DEFAULT 0, -- 0: internal, 1: external link
    MaTheLoai INT, -- Foreign key to TheLoai
    CONSTRAINT FK_TheLoaiTin_TheLoai FOREIGN KEY (MaTheLoai) REFERENCES TheLoai(MaTheLoai)
);
GO

-- Table 3: PhanLoaiTin
CREATE TABLE PhanLoaiTin (
    MaPhanLoaiTin INT PRIMARY KEY, -- Assuming MaPhanLoaiTin is a unique identifier
    TenPhanLoaiTin NVARCHAR(50) NOT NULL,
    SapXep INT, -- Sorting order
    NgayCapNhat DATETIME
);
GO
-- Table 4: TinTuc
CREATE TABLE TinTuc (
    MaTinTuc INT PRIMARY KEY, -- Assuming MaTinTuc is a unique identifier
    TieuDeTinTuc NVARCHAR(255) NOT NULL,
    UrlAnh VARCHAR(100), -- Image URL
    TrichDanTin NVARCHAR(MAX), -- Summary
    NoiDungTin NVARCHAR(MAX), -- Full content (using TEXT for longtext compatibility)
    NgayCapNhat DATETIME,
    SoLanDoc INT, -- View count
    Tag VARCHAR(255), -- Tags
    MaTheLoai INT, -- Foreign key to TheLoai
    MaTheLoaiTin INT, -- Foreign key to TheLoaiTin
    MaPhanLoaiTin INT, -- Foreign key to PhanLoaiTin
    MaThanhVien INT, -- Foreign key to Admin
    CONSTRAINT FK_TinTuc_TheLoai FOREIGN KEY (MaTheLoai) REFERENCES TheLoai(MaTheLoai),
    CONSTRAINT FK_TinTuc_TheLoaiTin FOREIGN KEY (MaTheLoaiTin) REFERENCES TheLoaiTin(MaTheLoaiTin),
    CONSTRAINT FK_TinTuc_PhanLoaiTin FOREIGN KEY (MaPhanLoaiTin) REFERENCES PhanLoaiTin(MaPhanLoaiTin),
    CONSTRAINT FK_TinTuc_Admin FOREIGN KEY (MaThanhVien) REFERENCES Admin(AdminID)
);
GO

-- Table 5: QuangCao
CREATE TABLE QuangCao (
    MaQuangCao INT PRIMARY KEY, -- Assuming MaQuangCao is a unique identifier
    TieuDe NVARCHAR(255), -- Ad title
    TinQuangCao VARCHAR(100), -- File path for ad (jpg, gif)
    UrlQuangCao VARCHAR(255), -- Ad URL
    Target VARCHAR(45), -- Window target
    SapXep INT, -- Sorting order
    VisibleQC BIT DEFAULT 0, -- 0: hidden, 1: visible
    ViTri VARCHAR(45) -- Ad position
);
GO

-- Table 6: VideoClip
CREATE TABLE VideoClip (
    MaVideo INT PRIMARY KEY, -- Assuming MaVideo is a unique identifier
    TenVideo NVARCHAR(255) NOT NULL,
    Url VARCHAR(255), -- Video URL
    NgayCapNhat DATETIME
);
GO

CREATE TABLE CauLacBo (
    MaCauLacBo INT PRIMARY KEY, 
    TenCauLacBo NVARCHAR(255) NOT NULL, 
    MoTaNgan NVARCHAR(MAX), 
    NoiDung NVARCHAR(MAX),
    NgayCapNhat DATETIME,
    UrlAnh VARCHAR(100), 
    MaTheLoai INT, 
    MaThanhVien INT, 
    CONSTRAINT FK_CauLacBo_TheLoai FOREIGN KEY (MaTheLoai) REFERENCES TheLoai(MaTheLoai),
    CONSTRAINT FK_CauLacBo_Admin FOREIGN KEY (MaThanhVien) REFERENCES Admin(AdminID)
);
