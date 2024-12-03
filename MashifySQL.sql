create database MashifyDB

use MashifyDB

create schema UserSchema
create schema PostSchema;
create schema CommentSchema;

CREATE TABLE UserSchema.UserTBL (
    UserId INT PRIMARY KEY IDENTITY, -- Auto-incrementing unique identifier
    Email NVARCHAR(320) UNIQUE NOT NULL, -- Updated to support longer email formats and Unicode
    UserName NVARCHAR(255) UNIQUE NOT NULL, -- Username with Unicode support
    UserPass NVARCHAR(255) NOT NULL, -- Password hashed (ensure to use secure hashing during storage)
    FirstName NVARCHAR(100) NOT NULL, -- Shortened length for more realistic usage
    LastName NVARCHAR(100) NOT NULL, -- Shortened length for consistency
    Bio NVARCHAR(MAX) NULL, -- Optional bio with support for lengthy descriptions
    UserAddress NVARCHAR(MAX) NULL, -- Optional user address with support for Unicode
    PhoneNumber NVARCHAR(15) NULL, -- Added for storing phone numbers (international format)
    ProfilePicture NVARCHAR(500) NULL, -- URL or path for profile picture
    CreatedAt DATETIME DEFAULT GETDATE(), -- Automatically store the record creation time
    UpdatedAt DATETIME NULL -- Optional, tracks the last update time
);


truncate table UserSchema.UserTBL

CREATE TABLE PostSchema.PostTBL (
    PostId INT PRIMARY KEY IDENTITY, 
    PostTitle NVARCHAR(255) NOT NULL,
    PostContent NVARCHAR(MAX) NOT NULL,
    MediaUrl NVARCHAR(500) NULL,
    MediaType NVARCHAR(50) NULL, 
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME NULL 
);


CREATE TABLE CommentSchema.CommentTBL (
    CommentID INT PRIMARY KEY IDENTITY, -- Auto-incrementing unique identifier for each comment
    UserId INT NOT NULL, -- References the User who made the comment
    PostId INT NOT NULL, -- References the Post on which the comment is made
    CommentContent NVARCHAR(MAX) NOT NULL, -- The actual comment content
    CreatedAt DATETIME DEFAULT GETDATE(), -- Automatically store the record creation time
    UpdatedAt DATETIME NULL, -- Tracks the last update time (if the comment is edited)

    -- Foreign Key Constraints
    CONSTRAINT FK_Comment_User FOREIGN KEY (UserId) REFERENCES UserSchema.UserTBL(UserId) ON DELETE CASCADE,
    CONSTRAINT FK_Comment_Post FOREIGN KEY (PostId) REFERENCES PostSchema.PostTBL(PostId) ON DELETE CASCADE
);


Alter PROCEDURE SignupUser
    @first_name VARCHAR(255),
    @last_name VARCHAR(255),
    @username VARCHAR(255),
    @UserPass VARCHAR(255),
    @email VARCHAR(255),
	@message varchar(255) output
AS
BEGIN
	begin try
			-- Insert user data into UserTBL
		INSERT INTO UserSchema.UserTBL (FirstName, LastName, UserName, UserPass, Email)
		VALUES (@first_name, @last_name, @username, @UserPass, @email);
    
		-- Optionally, you can return a message or output variable
		set @message = 'Signup successfull!'
	end try
	begin catch
		set @message = 'Error Occured!'
	end catch

END;


declare @msg varchar(30);
exec SignupUser 'test','lasttest','test123','test@123','test@gmail.com',@msg output;
select @msg



alter PROCEDURE SignInUser
    @username VARCHAR(255) = null,
	@email VARCHAR(255)= null,
    @UserPass VARCHAR(255),
	@userData int output
AS
BEGIN
	begin try

		select @userData =  UserId from UserSchema.UserTBL where UserName = @username or Email = @email;
	end try
	begin catch
		set @userData =-1
	end catch

END;

declare @dt int;
exec SignInUser @email= 'test@gmail.com',@UserPass='test@123',@userData=@dt output;
select @dt
