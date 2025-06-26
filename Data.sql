-- Create Database
CREATE DATABASE SICT_HAUI;
GO

USE SICT_HAUI;
GO

-- Table 0: Admin
CREATE TABLE [Admin] (
    AdminID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    NgayDangKy DATETIME
);
GO

-- Table 1: Users (Readers)
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    NgayDangKy DATETIME
);
GO

-- Table 2: TheLoai (Main categories)
CREATE TABLE TheLoai (
    MaTheLoai INT PRIMARY KEY,
    TenTheLoai NVARCHAR(50) NOT NULL,
    VisibleTheLoai BIT DEFAULT 0,
    VisibleTheLoai1 BIT DEFAULT 0,
    SapXep INT,
    Url NVARCHAR(255),
    Target NVARCHAR(15),
    LinkNgoai BIT DEFAULT 0
);
GO

-- Table 3: TheLoaiTin (Subcategories)
CREATE TABLE TheLoaiTin (
    MaTheLoaiTin INT PRIMARY KEY,
    TenTheLoaiTin NVARCHAR(50) NOT NULL,
    VisibleTheLoaiTin BIT DEFAULT 0,
    VisibleTheLoaiTin1 BIT DEFAULT 0,
    SapXep INT,
    Url NVARCHAR(255),
    Target NVARCHAR(15),
    LinkNgoai BIT DEFAULT 0,
    MaTheLoai INT,
    CONSTRAINT FK_TheLoaiTin_TheLoai FOREIGN KEY (MaTheLoai) REFERENCES TheLoai(MaTheLoai)
);
GO

-- Table 5: TinTuc
CREATE TABLE TinTuc (
    MaTinTuc INT PRIMARY KEY,
    TieuDeTinTuc NVARCHAR(255) NOT NULL,
    UrlAnh NVARCHAR(100),
    TrichDanTin NVARCHAR(MAX),
    NoiDungTin NVARCHAR(MAX),
    NgayCapNhat DATETIME DEFAULT GETDATE(),
    SoLanDoc INT,
    Tag NVARCHAR(255),
    MaTheLoai INT,
    MaTheLoaiTin INT,
    MaPhanLoaiTin INT,
    MaThanhVien INT,
    CONSTRAINT FK_TinTuc_TheLoai FOREIGN KEY (MaTheLoai) REFERENCES TheLoai(MaTheLoai),
    CONSTRAINT FK_TinTuc_TheLoaiTin FOREIGN KEY (MaTheLoaiTin) REFERENCES TheLoaiTin(MaTheLoaiTin),
    CONSTRAINT FK_TinTuc_Admin FOREIGN KEY (MaThanhVien) REFERENCES Admin(AdminID)
);
GO

-- Table 6: Comments
CREATE TABLE Comments (
    MaBinhLuan INT IDENTITY(1,1) PRIMARY KEY,
    MaTinTuc INT NOT NULL,
    UserID INT NOT NULL,
    NoiDung NVARCHAR(MAX) NOT NULL,
    NgayBinhLuan DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Comments_TinTuc FOREIGN KEY (MaTinTuc) REFERENCES TinTuc(MaTinTuc),
    CONSTRAINT FK_Comments_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

-- Table 7: VideoClip
CREATE TABLE VideoClip (
    MaVideo INT PRIMARY KEY,
    TenVideo NVARCHAR(255) NOT NULL,
    Url NVARCHAR(255),
    NgayCapNhat DATETIME
);
GO

-- Table 8: LoginHistory
CREATE TABLE LoginHistory (
    LoginID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    LoginTime DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_LoginHistory_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

-- Insert into Admin table
INSERT INTO Admin (Username, PasswordHash, FullName, NgayDangKy)
VALUES
    ('ad1', '123', N'Bùi Minh Hiếu', '2025-01-01 10:00:00'),
    ('ad2', '123', N'Phùng Tuấn Đạt', '2025-02-15 09:30:00'),
    ('ad3', '123', N'Hoàng Việt Long', '2025-03-20 14:20:00');
GO

-- Insert into TheLoai (Main categories)
INSERT INTO TheLoai (MaTheLoai, TenTheLoai, VisibleTheLoai, VisibleTheLoai1, SapXep, Url, Target, LinkNgoai)
VALUES
    (1, N'TRANG SICT', 1, 0, 1, 'https://sict.haui.edu.vn/vn/', '_self', 1),
    (2, N'TRANG HAUI', 1, 0, 2, 'https://www.haui.edu.vn/vn', '_self', 1),
    (3, N'GIỚI THIỆU', 1, 0, 3, NULL, NULL, 0),
    (4, N'ĐÀO TẠO', 1, 0, 4, NULL, NULL, 0),
    (5, N'TUYỂN SINH', 1, 0, 5, NULL, NULL, 0),
    (6, N'KHOA', 1, 0, 6, NULL, NULL, 0),
    (7, N'PHÒNG/TRUNG TÂM', 1, 0, 7, NULL, NULL, 0),
    (8, N'KHOA HỌC - CÔNG NGHỆ', 1, 0, 8, NULL, NULL, 0),
    (9, N'THƯ VIỆN ẢNH', 1, 0, 9, NULL, NULL, 0),
    (10, N'TIN TỨC', 0, 1, 1, NULL, NULL, 0),
    (11, N'THÔNG BÁO', 0, 1, 2, NULL, NULL, 0),
    (12, N'CHUYÊN NGÀNH ĐÀO TẠO', 0, 1, 3, NULL, NULL, 0),
    (13, N'TUYỂN DỤNG', 0, 1, 4, NULL, NULL, 0),
    (14, N'ĐÀO TẠO NGẮN HẠN', 0, 1, 5, NULL, NULL, 0),
    (15, N'CÂU LẠC BỘ', 0, 1, 6, NULL, NULL, 0),
    (16, N'GƯƠNG SÁNG SINH VIÊN', 0, 1, 7, NULL, NULL, 0);
GO

-- Insert into TheLoaiTin (Subcategories)
-- Subcategories for 'GIỚI THIỆU' (MaTheLoai = 3)
INSERT INTO TheLoaiTin (MaTheLoaiTin, TenTheLoaiTin, VisibleTheLoaiTin, VisibleTheLoaiTin1, SapXep, Url, Target, LinkNgoai, MaTheLoai)
VALUES
    (1, N'THÔNG TIN CHUNG', 1, 0, 1, NULL, NULL, 0, 3),
    (2, N'CƠ CẤU TỔ CHỨC', 1, 0, 2, NULL, NULL, 0, 3),
    (3, N'CHIẾN LƯỢC PHÁT TRIỂN', 1, 0, 3, NULL, NULL, 0, 3),
    (4, N'CÁN BỘ GIẢNG VIN', 1, 0, 4, NULL, NULL, 0, 3),
    (5, N'CƠ SỞ V�ẬT CHẤT', 1, 0, 5, NULL, NULL, 0, 3),
    (6, N'LIÊN HỆ', 1, 0, 6, NULL, NULL, 0, 3),
    -- Subcategories for 'ĐÀO TẠO' (MaTheLoai = 4)
    (7, N'ĐẠI HỌC', 1, 0, 1, NULL, NULL, 0, 4),
    (8, N'SAU ĐẠI HỌC', 1, 0, 2, NULL, NULL, 0, 4),
    (9, N'KẾ HOẠCH', 1, 0, 3, NULL, NULL, 0, 4),
    (10, N'TIẾN ĐỘ', 1, 0, 4, NULL, NULL, 0, 4),
    (11, N'QUY CHẾ, BIỂU MẪU', 1, 0, 5, NULL, NULL, 0, 4),
    -- Subcategories for 'TUYỂN SINH' (MaTheLoai = 5)
    (12, N'ĐẠI HỌC', 1, 0, 1, NULL, NULL, 0, 5),
    (13, N'SAU ĐẠI HỌC', 1, 0, 2, NULL, NULL, 0, 5),
    -- Subcategories for 'KHOA' (MaTheLoai = 6)
    (14, N'KHOA CÔNG NGHỆ THÔNG TIN', 1, 0, 1, NULL, NULL, 0, 6),
    (15, N'KHOA CÔNG NGHỆ PHẦN MỀM', 1, 0, 2, NULL, NULL, 0, 6),
    (16, N'KHOA KHOA HỌC MÁY TÍNH', 1, 0, 3, NULL, NULL, 0, 6),
    (17, N'KHOA MẠNG MÁY TÍNH VÀ TRUYỀN THÔNG', 1, 0, 4, NULL, NULL, 0, 6),
    -- Subcategories for 'PHÒNG/TRUNG TÂM' (MaTheLoai = 7)
    (18, N'PHÒNG TỔNG HỢP', 1, 0, 1, NULL, NULL, 0, 7),
    (19, N'TRUNG TÂM HỢP TÁC PHÁT TRIỂN', 1, 0, 2, NULL, NULL, 0, 7),
    (20, N'TRUNG TÂM NGHIÊN CỨU CÔNG NGHỆ TIÊN TIẾN ICT', 1, 0, 3, NULL, NULL, 0, 7),
    -- Subcategories for 'KHOA HỌC - CÔNG NGHỆ' (MaTheLoai = 8)
    (21, N'CÔNG TRÌNH CÔNG BỐ', 1, 0, 1, NULL, NULL, 0, 8),
    (22, N'ĐỀ TÀI, DỰ ÁN', 1, 0, 2, NULL, NULL, 0, 8),
    (23, N'SINH VIÊN NCKH', 1, 0, 3, NULL, NULL, 0, 8),
    (24, N'TIN KHCN', 1, 0, 4, NULL, NULL, 0, 8);
GO

-- Insert into PhanLoaiTin (Classifications)
INSERT INTO PhanLoaiTin (MaPhanLoaiTin, TenPhanLoaiTin, SapXep, NgayCapNhat)
VALUES
    (1, N'Tiêu điểm', 1, '2025-04-01 08:00:00'),
    (2, N'Các bài đăng', 2, '2025-04-02 09:00:00'),
    (3, N'Tags', 3, '2025-04-03 10:00:00'),
    (4, N'Video giới thiệu', 4, '2025-04-03 10:00:00');
GO

-- Insert into VideoClip
INSERT INTO VideoClip (MaVideo, TenVideo, Url, NgayCapNhat)
VALUES
    (1, N'Video giới thiệu', 'https://www.youtube.com/watch?v=mpIyV4xFf2o', '2025-03-10 08:00:00');
GO

-- Insert into TinTuc for CÂU LẠC BỘ (MaTheLoai = 15)
INSERT INTO TinTuc (MaTinTuc, TieuDeTinTuc, UrlAnh, TrichDanTin, NoiDungTin, NgayCapNhat, SoLanDoc, Tag, MaTheLoai, MaTheLoaiTin, MaPhanLoaiTin, MaThanhVien)
VALUES
    (1, N'Đội Olympic Tin học', 'https://sict.haui.edu.vn/media/77/t77832.jpg', 
     N'Là đội tuyển đại diện cho Trường Công nghệ thông tin và Truyền thông - Trường Đại học Công nghiệp Hà Nội ôn luyện và tham gia các kì thi Olympic quốc gia và quốc tế ',
     N'ĐỘI OLYMPIC TIN HỌC\n\n⚡Là đội tuyển đại diện cho Trường Công nghệ thông tin và Truyền thông - Trường Đại học Công nghiệp Hà Nội ôn luyện và tham gia các kì thi Olympic quốc gia và quốc tế .Trải qua gần 20 năm không ngừng phấn đấu và nỗ lực, Đội Olympic Tin học Trường Công nghệ thông tin và Truyền thông - Trường Đại học Công nghiệp Hà Nội tự hào là đơn vị đạt được nhiều thành tích cao trong các cuộc thi trong nước do Hội Tin học Việt Nam tổ chức cũng như các cuộc thi trong khu vực.\n\n🏆 Với sự hướng dẫn tận tình của các thầy cô cùng với tài năng, tinh thần đoàn kết, quyết tâm cao, Đội Olympic tin học đã đạt được nhiều thành tích nổi bật:\n- Vô địch PROCON Việt Nam 2022.\n- Các giải Nhất, Nhì, Ba cuộc thi Olympic Tin học Sinh viên các năm.\n- Đồng giải Ba cuộc thi Lập trình Sinh viên Quốc tế ACM/ICPC Hà Nội - Châu Á.\n\nHiện tại Ban chủ nhiệm đội bao gồm:\n- Đội trưởng: Nguyễn Duy Minh Quân\n- Đội phó: Nguyễn Viết Vượng', 
     GETDATE(), 0, 'tag1,tag2', 15, 1, 1, 1),
    (2, N'Câu lạc bộ Thể thao điện tử Trường Công nghệ thông tin và Truyền thông HEC', 'https://sict.haui.edu.vn/media/77/t77821.jpg', 
     N'CLB HEC được thành lập với mục đích mang bộ môn Esports đến gần hơn với sinh viên Trường Công nghệ thông tin và Truyền thông nói riêng và trường Đại học Công nghiệp nói chung.',
     N'Câu lạc bộ Thể thao điện tử Trường Công nghệ thông tin và Truyền thông HEC\n\n⚡️CLB HEC được thành lập với mục đích mang bộ môn Esports đến gần hơn với sinh viên Trường Công nghệ thông tin và Truyền thông nói riêng và trường Đại học Công nghiệp nói chung.\nPhòng máy Esports Training Room của HEC được trang đầy đủ thiết bị thi đấu phục vụ cho các giải đấu esports chuyên nghiệp.\n\n✨Tại đây, các bạn CTV, thành viên không chỉ được bồi dưỡng các kỹ năng trong lĩnh vực thể thao điện tử như: thiết kế, lên kế hoạch, tổ chức giải đấu, chụp ảnh. Mà còn là nơi giao lưu thể thao điện tử giữa các đội trong trường và được tham gia vô số giải đấu hấp dẫn của HEC cũng như của Trường Đại học Công nghiệp Hà Nội.', 
     GETDATE(), 0, 'tag3,tag4', 15, 1, 1, 1);
GO

-- Insert into TinTuc for GIỚI THIỆU (MaTheLoai = 3)
INSERT INTO TinTuc (MaTinTuc, TieuDeTinTuc, UrlAnh, TrichDanTin, NoiDungTin, NgayCapNhat, SoLanDoc, Tag, MaTheLoai, MaTheLoaiTin, MaPhanLoaiTin, MaThanhVien)
VALUES
    (40, N'Thông Tin Chung', NULL, N'Giới thiệu tổng quan về Trường Công nghệ Thông tin và Truyền thông',
     N'TRƯỜNG CÔNG NGHỆ THÔNG TIN VÀ TRUYỀN THÔNG(SICT)\nTrường Công nghệ Thông tin và Truyền thông là một đơn vị đào tạo hàng đầu thuộc Đại học Công nghiệp Hà Nội, chuyên cung cấp các chương trình giáo dục chất lượng cao trong lĩnh vực Công nghệ Thông tin, Truyền thông và các ngành liên quan.\nSứ mệnh: Đào tạo nguồn nhân lực chất lượng, thúc đẩy nghiên cứu khoa học và đổi mới sáng tạo.\n- Tầm nhìn: Trở thành trung tâm đào tạo CNTT hàng đầu tại Việt Nam vào năm 2030.',
     '2025-05-17 12:14:00', 0, NULL, 3, 1, 1, 1),
    (41, N'Cơ Cấu Tổ Chức', NULL, N'Tổ chức và cơ cấu của Trường Công nghệ Thông tin và Truyền thông',
     N'CƠ CẤU TỔ CHỨC SICT\nTrường Công nghệ Thông tin và Truyền thông (SICT) được tổ chức với các bộ phận chính sau:\n- Ban Lãnh đạo: Bao gồm Hiệu trưởng, các Phó Hiệu trưởng và các phòng ban chức năng.\n- Các Khoa: Gồm Khoa Công nghệ Thông tin, Khoa Công nghệ Phần mềm, v.v.\n- Phòng Hành chính - Tổng hợp: Hỗ trợ quản lý và điều hành.',
     '2025-05-17 12:14:00', 0, NULL, 3, 2, 1, 1),
    (42, N'Chiến Lược Phát Triển', NULL, N'Kế hoạch phát triển dài hạn của SICT',
     N'CHIẾN LƯỢC PHÁT TRIỂN\nSICT đặt mục tiêu trở thành trung tâm đào tạo và nghiên cứu CNTT hàng đầu tại Việt Nam:\n- Giai đoạn 2025-2030: Mở rộng quy mô đào tạo, nâng cao chất lượng giảng dạy.\n- Đầu tư nghiên cứu: Tăng cường hợp tác với các doanh nghiệp công nghệ.\n- Quốc tế hóa: Xây dựng các chương trình liên kết với các trường đại học nước ngoài.',
     '2025-05-17 12:14:00', 0, NULL, 3, 3, 1, 1),
    (43, N'Cán Bộ Giảng Viên', NULL, N'Đội ngũ giảng viên chất lượng cao của SICT',
     N'CÁN BỘ GIẢNG VIÊN\nSICT tự hào sở hữu đội ngũ giảng viên giàu kinh nghiệm và trình độ cao:\n- Số lượng: 150 giảng viên, trong đó 60% có trình độ Tiến sĩ.\n- Chuyên môn: Các lĩnh vực như AI, An toàn thông tin, Kỹ thuật phần mềm.\n- Thành tích: Nhiều giảng viên đạt giải thưởng nghiên cứu khoa học quốc gia.',
     '2025-05-17 12:14:00', 0, NULL, 3, 4, 1, 1),
    (44, N'Cơ Sở Vật Chất', NULL, N'Cơ sở vật chất hiện đại của SICT',
     N'CƠ SỞ VẬT CHẤT\nSICT được trang bị cơ sở vật chất hiện đại:\n- Phòng máy tính: 10 phòng với hơn 500 máy tính cấu hình cao.\n- Thư viện: Thư viện số với hàng nghìn tài liệu chuyên ngành.\n- Phòng thí nghiệm: Phòng nghiên cứu AI, IoT và An ninh mạng.',
     '2025-05-17 12:14:00', 0, NULL, 3, 5, 1, 1),
    (45, N'Liên Hệ', NULL, N'Thông tin liên hệ với SICT',
     N'LIÊN HỆ\n- Địa chỉ: Trường Đại học Công nghiệp Hà Nội, Số 298 Cầu Diễn, Bắc Từ Liêm, Hà Nội.\n- Điện thoại: (024) 1234 5678\n- Email: sict@haui.edu.vn\n- Website: https://sict.haui.edu.vn',
     '2025-05-17 12:14:00', 0, NULL, 3, 6, 1, 1);
GO

-- Insert into TinTuc for ĐÀO TẠO (MaTheLoai = 4)
INSERT INTO TinTuc (MaTinTuc, TieuDeTinTuc, UrlAnh, TrichDanTin, NoiDungTin, NgayCapNhat, SoLanDoc, Tag, MaTheLoai, MaTheLoaiTin, MaPhanLoaiTin, MaThanhVien)
VALUES
    (50, N'Khoa Công nghệ Thông tin', NULL, N'Giới thiệu về Khoa Công nghệ Thông tin',
     N'KHOA CÔNG NGHỆ THÔNG TIN\nKhoa Công nghệ Thông tin là một trong những khoa chủ lực của Trường Công nghệ Thông tin và Truyền thông (SICT), chuyên đào tạo các chuyên ngành như Lập trình, Cơ sở dữ liệu và Hệ thống thông tin.\n- Sứ mệnh: Cung cấp nhân lực chất lượng cao cho ngành CNTT.\n- Đội ngũ: 50 giảng viên, 70% có trình độ Tiến sĩ.\n- Thành tích: Đạt nhiều giải thưởng trong các cuộc thi công nghệ quốc gia.',
     '2025-05-17 12:36:00', 0, N'CNTT, Lập trình', 4, 7, 1, 1),
    (51, N'Khoa Công nghệ Phần mềm', NULL, N'Giới thiệu về Khoa Công nghệ Phần mềm',
     N'KHOA CÔNG NGHỆ PHẦN MỀM\nKhoa Công nghệ Phần mềm tập trung vào phát triển phần mềm, kỹ thuật phần mềm và quản lý dự án CNTT.\n- Chương trình đào tạo: Đáp ứng tiêu chuẩn quốc tế như ACM/IEEE.\n- Cơ sở vật chất: Phòng thực hành với phần mềm hiện đại.\n- Hợp tác: Liên kết với các công ty như FPT, Viettel.',
     '2025-05-17 12:36:00', 0, N'Phần mềm, Kỹ thuật', 4, 8, 1, 1),
    (52, N'Khoa Khoa học Máy tính', NULL, N'Giới thiệu về Khoa Khoa học Máy tính',
     N'KHOA KHOA HỌC MÁY TÍNH\nKhoa Khoa học Máy tính chuyên sâu về trí tuệ nhân tạo, học máy và phân tích dữ liệu.\n- Nghiên cứu: Dẫn đầu trong các dự án AI và Big Data.\n- Giảng viên: 40 giảng viên, 80% có công bố quốc tế.\n- Sinh viên: Tham gia các cuộc thi như ICPC, Hackathon.',
     '2025-05-17 12:36:00', 0, N'AI, Dữ liệu', 4, 9, 1, 1),
    (53, N'Khoa Mạng Máy tính và Truyền thông', NULL, N'Giới thiệu về Khoa Mạng Máy tính và Truyền thông',
     N'KHOA MẠNG MÁY TÍNH VÀ TRUYỀN THÔNG\nKhoa chuyên đào tạo về mạng máy tính, an ninh mạng và truyền thông đa phương tiện.\n- Chương trình: CCNA, CEH, và các chứng chỉ quốc tế.\n- Phòng thí nghiệm: Trang bị thiết bị Cisco, Juniper.\n- Cơ hội việc làm: Hợp tác với các tập đoàn viễn thông.',
     '2025-05-17 12:36:00', 0, N'Mạng, An ninh', 4, 10, 1, 1);
GO

-- Insert into TinTuc for TUYỂN SINH (MaTheLoai = 5)
INSERT INTO TinTuc (MaTinTuc, TieuDeTinTuc, UrlAnh, TrichDanTin, NoiDungTin, NgayCapNhat, SoLanDoc, Tag, MaTheLoai, MaTheLoaiTin, MaPhanLoaiTin, MaThanhVien)
VALUES
    (60, N'Thông Báo Tuyển Sinh Đại Học 2025', 'https://sict.haui.edu.vn/media/78/t78901.jpg',
     N'Trường Công nghệ Thông tin và Truyền thông – Đại học Công nghiệp Hà Nội thông báo tuyển sinh đại học năm 2025 với các ngành: \n Công nghệ Thông tin\nKhoa học Máy tính\nKỹ thuật Phần mềm\n\nPhương thức xét tuyển:\nXét điểm thi THPT Quốc gia\nXét học bạ\nXét tuyển thẳng theo quy định của Bộ GD&ĐT\n\nThời gian nhận hồ sơ: Từ 01/06/2025 đến 30/06/2025.',
     N'THÔNG BÁO TUYỂN SINH ĐẠI HỌC 2025\nTrường Công nghệ Thông tin và Truyền thông – Đại học Công nghiệp Hà Nội thông báo tuyển sinh đại học năm 2025 với các ngành:\n- Công nghệ Thông tin\n- Khoa học Máy tính\n- Kỹ thuật Phần mềm\n\nPhương thức xét tuyển:\n- Xét điểm thi THPT Quốc gia\n- Xét học bạ\n- Xét tuyển thẳng theo quy định của Bộ GD&ĐT\n\nThời gian nhận hồ sơ: Từ 01/06/2025 đến 30/06/2025.',
     GETDATE(), 0, 'tuyensin,daihoc', 5, 12, 1, 1),
    (61, N'Hội Thảo Tư Vấn Tuyển Sinh Đại Học', 'https://sict.haui.edu.vn/media/78/t78902.jpg',
     N'Hội thảo tư vấn tuyển sinh đại học 2025 sẽ được tổ chức vào ngày 15/05/2025.',
     N'HỘI THẢO TƯ VẤN TUYỂN SINH ĐẠI HỌC 2025\n\nTrường Công nghệ Thông tin và Truyền thông tổ chức hội thảo tư vấn tuyển sinh đại học 2025 nhằm cung cấp thông tin chi tiết về:\n- Các ngành đào tạo\n- Phương thức xét tuyển\n- Cơ hội việc làm sau tốt nghiệp\n\nThời gian: 08:00, ngày 15/05/2025\nĐịa điểm: Hội trường A, Đại học Công nghiệp Hà Nội\nĐăng ký tham gia tại: https://sict.haui.edu.vn/dangky',
     GETDATE(), 0, 'tuyensin,hoithao', 5, 12, 1, 1),
    (62, N'Tuyển Sinh Thạc Sĩ 2025', 'https://sict.haui.edu.vn/media/78/t78903.jpg',
     N'Trường Công nghệ Thông tin và Truyền thông – Đại học Công nghiệp Hà Nội thông báo tuyển sinh thạc sĩ năm 2025 với các chuyên ngành:\n- Hệ thống Thông tin\n- Khoa học Dữ liệu\n\nĐiều kiện dự tuyển:\n- Tốt nghiệp đại học đúng ngành hoặc ngành gần\n- Có chứng chỉ ngoại ngữ theo quy định\n\nThời gian nhận hồ sơ: Từ 01/07/2025 đến 31/07/2025.',
     N'TUYỂN SINH THẠC SĨ 2025\n\nTrường Công nghệ Thông tin và Truyền thông – Đại học Công nghiệp Hà Nội thông báo tuyển sinh chương trình thạc sĩ năm 2025 với các chuyên ngành:\n- Hệ thống Thông tin\n- Khoa học Dữ liệu\n\nĐiều kiện dự tuyển:\n- Tốt nghiệp đại học đúng ngành hoặc ngành gần\n- Có chứng chỉ ngoại ngữ theo quy định\n\nThời gian nhận hồ sơ: Từ 01/07/2025 đến 31/07/2025.',
     GETDATE(), 0, 'tuyensin,thacsi', 5, 13, 1, 1),
    (63, N'Hội Thảo Tuyển Sinh Sau Đại Học', 'https://sict.haui.edu.vn/media/78/t78904.jpg',
     N'Hội thảo giới thiệu chương trình thạc sĩ 2025 sẽ diễn ra vào ngày 20/06/2025.',
     N'HỘI THẢO TUYỂN SINH SAU ĐẠI HỌC 2025\n\nTrường Công nghệ Thông tin và Truyền thông tổ chức hội thảo giới thiệu chương trình thạc sĩ 2025, bao gồm:\n- Thông tin chi tiết về chương trình đào tạo\n- Điều kiện dự tuyển\n- Cơ hội học bổng và hỗ trợ tài chính\n\nThời gian: 09:00, ngày 20/06/2025\nĐịa điểm: Phòng họp B, Đại học Công nghiệp Hà Nội\nĐăng ký tham gia tại: https://sict.haui.edu.vn/dangky-thacsi',
     GETDATE(), 0, 'tuyensin,hoithao', 5, 13, 1, 1);
GO

-- Insert into TinTuc for PHÒNG/TRUNG TÂM (MaTheLoai = 7)
INSERT INTO TinTuc (MaTinTuc, TieuDeTinTuc, UrlAnh, TrichDanTin, NoiDungTin, NgayCapNhat, SoLanDoc, Tag, MaTheLoai, MaTheLoaiTin, MaPhanLoaiTin, MaThanhVien)
VALUES
    (70, N'Phòng Tổng hợp', NULL,
     N'Giới thiệu về Phòng Tổng hợp của Trường Công nghệ Thông tin và Truyền thông.',
     N'PHÒNG TỔNG HỢP\n\nPhòng Tổng hợp thuộc Trường Công nghệ Thông tin và Truyền thông (SICT) chịu trách nhiệm quản lý hành chính và hỗ trợ các hoạt động chung của nhà trường.\n\n- Nhiệm vụ chính:\n  - Quản lý hồ sơ sinh viên và giảng viên.\n  - Tổ chức các sự kiện nội bộ và hội thảo.\n  - Hỗ trợ công tác tuyển sinh và đào tạo.\n\n- Nhân sự: Phòng có 20 cán bộ hành chính, luôn sẵn sàng hỗ trợ sinh viên và giảng viên.\n- Liên hệ: Email: tonghop@sict.haui.edu.vn | Điện thoại: (024) 1234 5678.',
     '2025-05-17 13:00:00', 0, N'HanhChinh,TongHop', 7, 18, 1, 1),
    (71, N'Trung tâm Hợp tác Phát triển', NULL,
     N'Trung tâm thúc đẩy hợp tác giữa SICT và các doanh nghiệp, tổ chức trong và ngoài nước.',
     N'TRUNG TÂM HỢP TÁC PHÁT TRIỂN\n\nTrung tâm Hợp tác Phát triển của Trường Công nghệ Thông tin và Truyền thông (SICT) được thành lập nhằm tăng cường mối quan hệ hợp tác với các đối tác trong và ngoài nước.\n\n- Hoạt động nổi bật:\n  - Ký kết biên bản ghi nhớ (MOU) với các công ty công nghệ lớn như FPT, Viettel.\n  - Tổ chức các chương trình trao đổi sinh viên quốc tế.\n  - Hỗ trợ khởi nghiệp và chuyển giao công nghệ cho sinh viên.\n\n- Thành tựu: Đã hợp tác với hơn 50 doanh nghiệp trong 5 năm qua.\n- Liên hệ: Email: hoptac@sict.haui.edu.vn | Điện thoại: (024) 8765 4321.',
     '2025-05-17 13:00:00', 0, N'HopTac,DoanhNghiep', 7, 19, 1, 1),
    (72, N'Trung tâm Nghiên cứu Công nghệ Tiên tiến ICT', NULL,
     N'Trung tâm tập trung nghiên cứu các công nghệ tiên tiến như AI, IoT, và Blockchain.',
     N'TRUNG TÂM NGHIÊN CỨU CÔNG NGHỆ TIÊN TIẾN ICT\n\nTrung tâm Nghiên cứu Công nghệ Tiên tiến ICT của Trường Công nghệ Thông tin và Truyền thông (SICT) là đơn vị dẫn đầu trong nghiên cứu và ứng dụng các công nghệ mới.\n\n- Lĩnh vực nghiên cứu:\n  - Trí tuệ nhân tạo (AI) và học máy (Machine Learning).\n  - Internet vạn vật (IoT) và thành phố thông minh.\n  - Công nghệ Blockchain và bảo mật dữ liệu.\n\n- Thành tựu: Đã công bố 15 bài báo quốc tế trong năm 2024 và triển khai 5 dự án IoT cho các địa phương.\n- Liên hệ: Email: nghien-cuu@sict.haui.edu.vn | Điện thoại: (024) 5678 1234.',
     '2025-05-17 13:00:00', 0, N'NghienCuu,CongNghe', 7, 20, 1, 1);
GO

-- Select statements for verification
SELECT * FROM TheLoai;
SELECT * FROM TinTuc WHERE MaTheLoai = 3;
SELECT * FROM TinTuc WHERE MaTheLoai = 7;
SELECT NoiDungTin FROM TinTuc WHERE MaTheLoaiTin = 1 AND MaTheLoai = 3;
