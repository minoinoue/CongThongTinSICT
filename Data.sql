USE SICT_HAUI;
GO
-- Insert into Admin table
INSERT INTO Admin (Username, PasswordHash, FullName, NgayDangKy)
VALUES
    ('ad1', '123', N'Bùi Minh Hiếu', '2025-01-01 10:00:00'),
    ('ad2', '123', N'Phùng Tuấn Đạt', '2025-02-15 09:30:00'),
    ('ad3', '123', N'Hoàng Việt Long', '2025-03-20 14:20:00');
GO

INSERT INTO CauLacBo (MaCauLacBo, TenCauLacBo, MoTaNgan, NoiDung, NgayCapNhat, UrlAnh, MaTheLoai, MaThanhVien)
VALUES
    (
        1, 
        N'Câu lạc bộ Truyền thông FIT Media',
        N'Câu lạc bộ Truyền thông của Trường Công nghệ thông tin và Truyền thông, chuyên tổ chức các hoạt động truyền thông và sự kiện.',
        N'Câu lạc bộ Truyền thông FIT Media thuộc Trường Công nghệ thông tin và Truyền thông (FIT) được thành lập với mục tiêu thúc đẩy các hoạt động truyền thông, quảng bá hình ảnh nhà trường, và tổ chức các sự kiện văn hóa, học thuật. CLB hoạt động trong các lĩnh vực như sản xuất nội dung truyền thông, quay dựng video, thiết kế đồ họa, và quản lý các kênh truyền thông xã hội. Tham gia FIT Media, sinh viên có cơ hội phát triển kỹ năng sáng tạo, làm việc nhóm, và xây dựng mạng lưới quan hệ.',
        GETDATE(),
        'https://example.com/fit-media-logo.jpg',
        15,
        1
    ),
    (
        2,
        N'Câu lạc bộ Thể thao điện tử Trường Công nghệ thông tin và Truyền thông HEC',
        N'CLB dành cho những người yêu thích thể thao điện tử.',
        N'CLB HEC được thành lập với mục đích mang bộ môn Esports đến gần hơn với sinh viên Trường Công nghệ thông tin và Truyền thông nói riêng và trường Đại học Công nghiệp nói chung. Phòng máy Esports Training Room của HEC được trang bị đầy đủ thiết bị thi đấu phục vụ cho các giải đấu esports chuyên nghiệp.',
        GETDATE(),
        'https://sict.haui.edu.vn/media/77/t77821.jpg',
        15,
        1
    );
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
    (4, N'CÁN BỘ GIẢNG VIÊN', 1, 0, 4, NULL, NULL, 0, 3),
    (5, N'CƠ SỞ VẬT CHẤT', 1, 0, 5, NULL, NULL, 0, 3),
    (6, N'LIÊN HỆ', 1, 0, 6, NULL, NULL, 0, 3);
GO

-- Subcategories for 'ĐÀO TẠO' (MaTheLoai = 4)
INSERT INTO TheLoaiTin (MaTheLoaiTin, TenTheLoaiTin, VisibleTheLoaiTin, VisibleTheLoaiTin1, SapXep, Url, Target, LinkNgoai, MaTheLoai)
VALUES
    (7, N'ĐẠI HỌC', 1, 0, 1, NULL, NULL, 0, 4),
    (8, N'SAU ĐẠI HỌC', 1, 0, 2, NULL, NULL, 0, 4),
    (9, N'KẾ HOẠCH', 1, 0, 3, NULL, NULL, 0, 4),
    (10, N'TIẾN ĐỘ', 1, 0, 4, NULL, NULL, 0, 4),
    (11, N'QUY CHẾ, BIỂU MẪU', 1, 0, 5, NULL, NULL, 0, 4);
GO

-- Subcategories for 'TUYỂN SINH' (MaTheLoai = 5)
INSERT INTO TheLoaiTin (MaTheLoaiTin, TenTheLoaiTin, VisibleTheLoaiTin, VisibleTheLoaiTin1, SapXep, Url, Target, LinkNgoai, MaTheLoai)
VALUES
    (12, N'ĐẠI HỌC', 1, 0, 1, NULL, NULL, 0, 5),
    (13, N'SAU ĐẠI HỌC', 1, 0, 2, NULL, NULL, 0, 5);
GO

-- Subcategories for 'KHOA' (MaTheLoai = 6)
INSERT INTO TheLoaiTin (MaTheLoaiTin, TenTheLoaiTin, VisibleTheLoaiTin, VisibleTheLoaiTin1, SapXep, Url, Target, LinkNgoai, MaTheLoai)
VALUES
    (14, N'KHOA CÔNG NGHỆ THÔNG TIN', 1, 0, 1, NULL, NULL, 0, 6),
    (15, N'KHOA CÔNG NGHỆ PHẦN MỀM', 1, 0, 2, NULL, NULL, 0, 6),
    (16, N'KHOA KHOA HỌC MÁY TÍNH', 1, 0, 3, NULL, NULL, 0, 6),
    (17, N'KHOA MẠNG MÁY TÍNH VÀ TRUYỀN THÔNG', 1, 0, 4, NULL, NULL, 0, 6);
GO

-- Subcategories for 'PHÒNG/TRUNG TÂM' (MaTheLoai = 7)
INSERT INTO TheLoaiTin (MaTheLoaiTin, TenTheLoaiTin, VisibleTheLoaiTin, VisibleTheLoaiTin1, SapXep, Url, Target, LinkNgoai, MaTheLoai)
VALUES
    (18, N'PHÒNG TỔNG HỢP', 1, 0, 1, NULL, NULL, 0, 7),
    (19, N'TRUNG TÂM HỢP TÁC PHÁT TRIỂN', 1, 0, 2, NULL, NULL, 0, 7),
    (20, N'TRUNG TÂM NGHIÊN CỨU CÔNG NGHỆ TIÊN TIẾN ICT', 1, 0, 3, NULL, NULL, 0, 7);
GO

-- Subcategories for 'KHOA HỌC - CÔNG NGHỆ' (MaTheLoai = 8)
INSERT INTO TheLoaiTin (MaTheLoaiTin, TenTheLoaiTin, VisibleTheLoaiTin, VisibleTheLoaiTin1, SapXep, Url, Target, LinkNgoai, MaTheLoai)
VALUES
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

INSERT INTO VideoClip (MaVideo, TenVideo, Url, NgayCapNhat)
VALUES
    (1, N'Video giới thiệu', 'https://www.youtube.com/watch?v=mpIyV4xFf2o', '2025-03-10 08:00:00');
GO

INSERT INTO GuongSangSV (MaGuongSang, TenSinhVien, MoTaNgan, NoiDung, NgayCapNhat, UrlAnh, MaTheLoai, MaThanhVien)
VALUES 
    (
        1,
        N'Nguyễn Văn An', 
        N'Sinh viên xuất sắc với thành tích học tập và nghiên cứu khoa học.',
        N'Nguyễn Văn An là sinh viên năm cuối Trường Công nghệ thông tin và Truyền thông (FIT), Đại học Công nghiệp Hà Nội. An đã đạt giải Nhất cuộc thi nghiên cứu khoa học sinh viên cấp quốc gia năm 2024 với dự án về trí tuệ nhân tạo. Ngoài ra, An còn tích cực tham gia các hoạt động tình nguyện và là thành viên năng động của Câu lạc bộ Truyền thông FIT Media.', -- NoiDung
        GETDATE(),
        'https://sict.haui.edu.vn/media/80/t80123.jpg', 
        16, 
        1
    ),
    (
        2, 
        N'Trần Thị Bình', 
        N'Nữ sinh viên tiêu biểu với nhiều giải thưởng trong các cuộc thi công nghệ.',
        N'Trần Thị Bình là sinh viên Trường Công nghệ thông tin và Truyền thông (FIT), nổi bật với thành tích giành giải Nhì cuộc thi lập trình quốc tế ACM-ICPC 2024. Bình cũng là trưởng nhóm dự án phát triển ứng dụng hỗ trợ học tập, được triển khai tại nhiều trường đại học. Với tinh thần học hỏi và cống hiến, Bình là nguồn cảm hứng cho nhiều sinh viên khác.', -- NoiDung
        GETDATE(),
        'https://sict.haui.edu.vn/media/81/t81124.jpg',
        16, 
        1
    );
GO
