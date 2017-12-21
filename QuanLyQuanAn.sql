use QuanLyQuanAn
 --Tạo bảng
CREATE TABLE Account
(
	ID		varchar(50),
	Password	varchar(50),
	Note		varchar(100),
	MaQuyen		int
	CONSTRAINT PK_Account
	PRIMARY KEY (ID)
)
	
CREATE TABLE PhanQuyen
(
	MaQuyen		int,
	TenQuyen	varchar(50)
	CONSTRAINT PK_PhanQuyen
	PRIMARY KEY (MaQuyen)
)

CREATE TABLE MonAn
(
	ID			varchar(10),
	Ten			varchar(50),
	Danhmuc		varchar(10),
	Gia			decimal
	CONSTRAINT PK_MonAn
	PRIMARY KEY (ID)
)

CREATE TABLE ChiNhanh
(
	ID				varchar(10),
	TenChiNhanh		varchar(20),
	DiaChi			varchar(50),
	Tinh			varchar(50),
	Sdt				int,
	ThongTinBan		varchar(50)
	CONSTRAINT PK_ChiNhanh
	PRIMARY KEY (ID)
)

CREATE TABLE MenuChiNhanh
(
	IDChiNhanh	varchar(10),
	IDMonAn		varchar(10),
	Gia			decimal
	CONSTRAINT PK_MenuChiNhanh
	PRIMARY KEY (IDChiNhanh, IDMonAn)
)

CREATE TABLE DonHang
(
	ID			varchar(10),
	IDChiNhanh	varchar(10),
	TongCong	decimal,
	NgayThang	date,
	CONSTRAINT PK_DonHang
	PRIMARY KEY (ID)
)


CREATE TABLE ChiTietDonHang
(
	ID			varchar(10),
	IDChiNhanh	varchar(10),
	IDMenu		varchar(10),
	SoBan		int,
	SoLuong		int,
	Gia			decimal,
	NgayThang	date,
	CONSTRAINT PK_ChiTietDonHang
	PRIMARY KEY (ID, IDMenu)
)

--Tạo ràng buộc
ALTER TABLE MenuChiNhanh
ADD CONSTRAINT FK_MenuChiNhanh_MonAn
FOREIGN KEY (IDMonAn)
REFERENCES MonAn

ALTER TABLE MenuChiNhanh
ADD CONSTRAINT FK_MenuChiNhanh_ChiNhanh
FOREIGN KEY (IDChiNhanh)
REFERENCES ChiNhanh

--Thêm dữ liệu
INSERT INTO Account
VALUES	('HoangKhang', '123456', null, 1),
	('MinhHieu', '123456', null, 2),
	('TuanKhoi', '123456', null, 3),
	('NhatHuy', '123456', null, 4),
	('LyHuynh', '123456', null, 4)

INSERT INTO PhanQuyen
VALUES	(1, N'Nhân viên Milf1'), (2, N'Nhân viên Milf2'), (3, N'Nhân viên Milf3'),
	(4, N'Quản lý')

INSERT INTO MonAn
VALUES 	('1', N'Beefsteak', N'Bò', 60),
	('2', N'Cánh gà chiên nước mắm', N'Gà', 60),
	('3', N'Cơm chiên dương châu', N'Cơm', 30),
	('4', N'Mực xào dòn', N'Mực', 60),
	('5', N'Nước suối', N'Giải khát', 10),
	('6', N'Cơm sườn', N'Cơm', 25),
	('7', N'Thỏ nướng', N'Thỏ', 60)

INSERT INTO ChiNhanh
VALUES 	('1', N'Milf 1', N'51/1b Ấp Hậu Lân, Hóc Môn', N'Tp.Hồ Chí Minh', '123456', 10),
	('2', N'Milf 2', N'252 Hậu Nghĩa', N'Long An', '123456', 20),
	('3', N'Milf 3', N'111 Bình Thới, Quận 11', N'Đồng Tháp', '123456', 15)

INSERT INTO MenuChiNhanh
VALUES	('1','1', 50), ('1','2', 50), ('1','3', 50),
	('2','3', 40), ('2','4', 40), ('2','5', 40),
	('3','5', 30), ('3','6', 30), ('3','7', 30)

--Strore Procedure
CREATE PROC sp_FindMaMonAn
@ID varchar(10),
@Outputt int out
AS BEGIN
	IF(@ID NOT IN(SELECT ID
				  FROM MonAn))
	BEGIN 
		SET @Outputt = 1
	END
	ELSE
		SET @Outputt = 0
END

CREATE PROC sp_AddMonAn
@ID			varchar(10),
@Ten		varchar(10),
@Danhmuc	varchar(10),
@Gia		decimal
AS BEGIN
	INSERT INTO MonAn 
	VALUES (@ID, @Ten, @Danhmuc, @Gia)
END

CREATE PROC sp_DelMonAn
@ID varchar(10)
AS BEGIN
	DELETE FROM MonAn
		   WHERE @ID = ID
END

CREATE PROC sp_UpdateMonAn
@ID			varchar(10),
@Ten		varchar(10) = NULL,
@Danhmuc	varchar(10) = NULL,
@Gia		decimal = NULL
AS BEGIN
	IF (@Ten IS NOT NULL)
	BEGIN
		UPDATE MonAn
		SET Ten = @Ten
		WHERE @ID = ID
	END
	IF (@Danhmuc IS NOT NULL)
	BEGIN
		UPDATE MonAn
		SET Danhmuc = @Danhmuc
		WHERE @ID = ID
	END
	IF (@Gia IS NOT NULL)
	BEGIN
		UPDATE MonAn
		SET Gia = @Gia
		WHERE @ID = ID
	END
END

CREATE PROC sp_FindMaChiNhanh
@ID			varchar(10),
@Outputt	int out
AS BEGIN
	IF(@ID NOT IN(SELECT ID
				  FROM ChiNhanh))
	BEGIN 
		SET @Outputt = 1
	END
	ELSE
		SET @Outputt = 0
END

CREATE PROC sp_AddChiNhanh
@ID				varchar(10),
@Ten			varchar(20),
@DiaChi			varchar(50),
@Tinh			varchar(50),
@Sdt			int,
@ThongTinBan	varchar(50)
AS BEGIN
	INSERT INTO ChiNhanh VALUES (@ID, @Ten, @DiaChi, @Tinh, @Sdt, @ThongTinBan)
END

CREATE PROC sp_DelChiNhanh
@ID varchar(10)
AS BEGIN
	DELETE FROM ChiNhanh
	WHERE ID = @ID
END

CREATE PROC sp_UpdateChiNhanh
@ID varchar(10),
@Ten varchar(20) = NULL,
@DiaChi varchar(50) = NULL,
@Tinh varchar(50) = NULL,
@Sdt int = NULL,
@ThongTinBan varchar(50) = NULL
AS BEGIN
	IF(@Ten IS NOT NULL)
	BEGIN
		UPDATE ChiNhanh
		SET TenChiNhanh = @Ten
		WHERE ID = @ID
	END
	IF(@DiaChi IS NOT NULL)
	BEGIN
		UPDATE ChiNhanh
		SET DiaChi = @DiaChi
		WHERE ID = @ID
	END
	IF(@Tinh IS NOT NULL)
	BEGIN
		UPDATE ChiNhanh
		SET Tinh = @Tinh
		WHERE ID = @ID
	END
	IF(@Sdt IS NOT NULL)
	BEGIN
		UPDATE ChiNhanh
		SET Sdt = @Sdt
		WHERE ID = @ID
	END
	IF(@ThongTinBan IS NOT NULL)
	BEGIN
		UPDATE ChiNhanh
		SET ThongTinBan = @ThongTinBan
		WHERE ID = @ID
	END
END

CREATE PROC sp_AddMenuChiNhanh
@ID		varchar(10),
@IDMenu	varchar(10),
@Gia	decimal
AS BEGIN
	INSERT INTO MenuChiNhanh
	VALUES (@ID, @IDMenu, @Gia)
END


CREATE PROC sp_UpdateGia
@ID			varchar(10),
@IDMenu		varchar(10),
@Gia		decimal
AS BEGIN
	UPDATE MenuChiNhanh
	SET Gia = @Gia
	WHERE @ID = IDChiNhanh AND @IDMenu = IDMonAn
END

CREATE PROC sp_DelMenuChiNhanh
@ID			varchar(10),
@IDMenu		varchar(10)
AS BEGIN
	DELETE FROM MenuChiNhanh
		   WHERE @ID = IDChiNhanh AND @IDMenu = IDMonAn
END

CREATE PROC sp_FindIDMenuChiNhanh
@ID		varchar(10),
@IDMenu	varchar(10),
@output int out
AS BEGIN
	IF(@IDMenu NOT IN (SELECT IDMonAn
					   FROM MenuChiNhanh
					   WHERE @ID = IDChiNhanh))
	BEGIN
		SET @output = 1
	END
	ELSE
		SET @output = 0
END

CREATE PROC sp_FindIDMenuChiNhanh1
@ID		varchar(10),
@Ten	varchar(50),
@IDMenu	varchar(10) out
AS BEGIN
	SELECT @IDMenu = m.ID
	FROM MonAn m, MenuChiNhanh me
	WHERE m.Ten = @Ten ANd me.IDChiNhanh = @ID
END

CREATE PROC sp_FindID
@ID			varchar(50),
@Output		int
AS BEGIN
	IF(@ID NOT IN (SELECT ID
				   FROM Account))
	BEGIN
		SET @Output = 0
	END
	ELSE
		SET @Output = 1
END

CREATE PROC sp_FindAccount
@ID			varchar(50),
@Password	varchar(50),
@Output		int
AS BEGIN
	IF(@Password NOT IN (SELECT Password
						 FROM Account
						 WHERE @ID = ID))
	BEGIN
		SET @Output = 0
	END
	ELSE
		SELECT @Output = MaQuyen
		FROM Account
		WHERE @ID = ID
END

CREATE PROC sp_AddDonHang
@ID				varchar(10),
@IDChiNhanh		varchar(10),
@TongCong		decimal,
@NgayThang		date
AS BEGIN
	INSERT INTO DonHang
	VALUES (@ID, @IDChiNhanh, @TongCong, @NgayThang)
END

CREATE PROC sp_AddChiTietDonHang
@ID				varchar(10),
@IDChiNhanh		varchar(10),
@IDMenu			varchar(10),
@SoBan			int,
@SoLuong		int,
@Gia			decimal,
@NgayThang		date
AS BEGIN
	INSERT INTO ChiTietDonHang
	VALUES (@ID, @IDChiNhanh, @IDMenu, @SoBan, @SoLuong, @Gia, @NgayThang)
END
