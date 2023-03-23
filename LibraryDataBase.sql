CREATE TABLE admins(
     admin_num      NUMBER(11)  CONSTRAINT ad_ad_num_pk  PRIMARY KEY,      -- ?��?? ?��?  (PK)
     admin_name     VARCHAR2(255)  CONSTRAINT ad_ad_name_nn NOT NULL,      -- ?��?? ????
     admin_pw       VARCHAR2(255)  CONSTRAINT ad_ad_pw_nn NOT NULL,        -- ?��?? ????��?
     admin_phone    VARCHAR2(255)  CONSTRAINT ad_ad_phone_uk UNIQUE,       -- ?��?? ?׼?͹?? (UK)
     admin_email    VARCHAR2(255)  CONSTRAINT ad_ad_email_nn NOT NULL,     -- ?��?? ???��?
     admin_address  VARCHAR2(255)  CONSTRAINT ad_ad_address_nn NOT NULL,   -- ?��?? ???
     admin_registrationdate  VARCHAR2(255)  DEFAULT sysdate,               -- ?��?? ?��?��?
     admin_updatedate    VARCHAR2(255),                                     -- ?��?? ?????
     admin_note     VARCHAR2(255)                                          -- ???
);

SELECT * FROM admins;


-- ?��?? ?ݭ?? ??????
CREATE TABLE members (
     mem_num        NUMBER(11) CONSTRAINT m_m_num_pk  PRIMARY KEY,    -- ?��?? ?��?  (PK)
     mem_name       VARCHAR2(255) CONSTRAINT m_m_name_nn NOT NULL,    -- ?��?? ????
     mem_id         VARCHAR2(255) CONSTRAINT m_m_id_uk UNIQUE,        -- ?��?? ?ݬ???�� (UK)
     mem_pw         VARCHAR2(255) CONSTRAINT m_m_pw_nn NOT NULL,      -- ?��?? ????��?
     mem_birthday   CHAR(6) CONSTRAINT m_m_birthday_nn NOT NULL,      -- ?��?? ?????��??
     mem_sex        CHAR(1) CONSTRAINT m_m_sex_boolean CHECK(mem_sex IN ('0', '1')), -- ?��?? ?��?? (0,1 ?? ???)
     mem_phone      VARCHAR2(255) CONSTRAINT m_m_phone_uk UNIQUE,     -- ?��?? ?׼?͹?? (UK)
     mem_email      VARCHAR2(255) CONSTRAINT m_m_email_nn NOT NULL,   -- ?��??
     mem_address    VARCHAR2(255) CONSTRAINT m_m_address_nn NOT NULL, -- ?��?? ???
     mem_registrationdate VARCHAR2(255)     DEFAULT sysdate,          -- ?��?? ?��?��?
     mem_updatedate VARCHAR2(255),                                     -- ?��?? ?ݭ?? ?????
     mem_note       VARCHAR2(255)                                     -- ???
);

SELECT * FROM members;


DELETE FROM members WHERE mem_num = 7;

INSERT INTO members VALUES (mem_num_seq.nextval, '������', 'dbswl94', '1234', '980120', '1', '010-1234-5678', 'yj@naver.com', '��⵵ ������', '22/08/09', null, null);
INSERT INTO members VALUES (mem_num_seq.nextval, '�̵���', 'engkengkgg', '1234', '920605', '0', '010-6518-6822', '2ha@gmail.com', '��⵵ ������', default, null, null);
INSERT INTO members VALUES (mem_num_seq.nextval, '������', 'ppakjjii', '1234', '920809', '1', '010-8845-8642', 'ppakjjii@naver.com', '��⵵ �����ֽ�', '20/05/20', null, null);
INSERT INTO members VALUES (mem_num_seq.nextval, '�����', '90suji', '1234', '901118', '1', '010-3215-6515', 'ssuji@naver.com', '��õ������', '22/11/18', null, null);
INSERT INTO members VALUES (mem_num_seq.nextval, '����ȣ', 'kkhgg', '1234', '850706', '0', '010-5143-8431', 'kkh85@naver.com', '�λ걤����', '21/10/01', null, null);
INSERT INTO members VALUES (mem_num_seq.nextval, '�̵���', 'ehddyd', 'dlehddyd12.!', '980426', '0', '010-1234-9876', 'ehddyd@naver.com', '����������', default, null, null);


-- ?��?? ?ݭ?? ??????
CREATE TABLE books(
     book_id        VARCHAR2(255)  CONSTRAINT b_b_id_pk  PRIMARY KEY,      -- ?��?? ?��?��??? (PK)
     book_title     VARCHAR2(255)  CONSTRAINT b_b_title_nn NOT NULL,       -- ?��?? ?��??
     book_author    VARCHAR2(255)  CONSTRAINT b_b_author_nn NOT NULL,      -- ?��?? ???��
     book_publisher VARCHAR2(255)  CONSTRAINT b_b_publisher_nn NOT NULL,   -- ?��?? ?��??��
     book_isbn  VARCHAR2(255) CONSTRAINT b_b_isbn_uk UNIQUE,               -- ?��?? ISBN ?��?  (UK)
     book_bias      NUMBER(11) DEFAULT 1,                                  -- ?��?? ?��?��?? (?????? 1)
     book_duplicates NUMBER(11) DEFAULT 1,                                 -- ?��?? ????? (?????? 1)
     book_price     NUMBER(11),                                            -- ?��?? ????
     location_id    CHAR(1) CONSTRAINT b_loc_id_fk REFERENCES locations(location_id), -- ?��?? ???? (FK)
     book_registrationdate   VARCHAR2(255) DEFAULT sysdate,               -- ?��?? ?��?��?
     book_updatedate     VARCHAR2(255),                                     -- ?��?? ?ݭ?? 
     book_note      VARCHAR2(255)                                          -- ???
);

ALTER TABLE books DROP CONSTRAINT b_b_isbn_uk;

--CREATE TABLE callsign(
--     book_callsign  VARCHAR2(255)  CONSTRAINT c_b_cs_pk  PRIMARY KEY,
--     cs_classification_code VARCHAR2(255),
--     cs_sign           VARCHAR2(255),
--     cs_bias           NUMBER(11),
--     cs_duplicates     NUMBER(11)
--);

-- ?��?? ??? / ???? ??????
CREATE TABLE locations(
     location_id    CHAR(1) CONSTRAINT l_l_id_pk  PRIMARY KEY,        -- ?��?? ???? ?ݬ???��   (PK)
     location_name  VARCHAR2(255) CONSTRAINT l_l_name_nn NOT NULL     -- ?��?? ???? ????
);

INSERT INTO locations VALUES ('A', 'ö��');
INSERT INTO locations VALUES ('B', '����');
INSERT INTO locations VALUES ('C', '��ȸ����');
INSERT INTO locations VALUES ('D', '�ڿ�����');
INSERT INTO locations VALUES ('E', '�������');
INSERT INTO locations VALUES ('F', '����');
INSERT INTO locations VALUES ('G', '���');
INSERT INTO locations VALUES ('H', '����');
INSERT INTO locations VALUES ('I', '����');

COMMIT;

-- ???? ?��?׶ ??????
CREATE TABLE check_out_info(
     check_out_id   NUMBER(11) CONSTRAINT coi_coi_id_pk PRIMARY KEY,                 -- ???׵ ?ݬ???�� (PK)
     book_id        VARCHAR2(255) CONSTRAINT coi_b_id_fk REFERENCES books(book_id) ON DELETE SET NULL,  -- ???׵ ?��??   (FK)
     mem_num        NUMBER(11) CONSTRAINT coi_m_num_fk REFERENCES members(mem_num) ON DELETE SET NULL,  -- ?��?? ?��?   (FK)
     check_out_date VARCHAR2(255)           DEFAULT sysdate,                         -- ???׵ ?��??
     expect_return_date VARCHAR2(255)       DEFAULT sysdate + (INTERVAL '7' DAY),    -- ?���� ??? ?��??
     check_in_date  VARCHAR2(255)                                                    -- ?���� ?��??
);

INSERT INTO check_out_info VALUES (check_out_id_seq.nextval, '9', 5, '22/12/10', default, null);
UPDATE check_out_info SET expect_return_date = '22/12/16' WHERE check_out_id = 6;

-- ?ף???�� ?ݭ?? ??????
CREATE TABLE readingroom(
     seat_num       NUMBER(11) CONSTRAINT r_s_num_pk PRIMARY KEY,     -- ?��? ?��?  (PK)
     table_divider  CHAR(1)                                          -- ????? ?׵??
);

INSERT INTO readingroom VALUES (1, '0');
INSERT INTO readingroom VALUES (2, '0');
INSERT INTO readingroom VALUES (3, '0');
INSERT INTO readingroom VALUES (4, '0');
INSERT INTO readingroom VALUES (5, '0');
INSERT INTO readingroom VALUES (6, '0');
INSERT INTO readingroom VALUES (7, '0');
INSERT INTO readingroom VALUES (8, '0');
INSERT INTO readingroom VALUES (9, '0');
INSERT INTO readingroom VALUES (10, '0');
INSERT INTO readingroom VALUES (11, '0');
INSERT INTO readingroom VALUES (12, '0');
INSERT INTO readingroom VALUES (13, '0');
INSERT INTO readingroom VALUES (14, '0');
INSERT INTO readingroom VALUES (15, '0');
INSERT INTO readingroom VALUES (16, '0');
INSERT INTO readingroom VALUES (17, '0');
INSERT INTO readingroom VALUES (18, '0');
INSERT INTO readingroom VALUES (19, '0');
INSERT INTO readingroom VALUES (20, '0');

INSERT INTO readingroom VALUES (45, '1');

UPDATE readingroom SET table_divider = '0' WHERE seat_num = 19 OR seat_num = 20;

SELECT * FROM readingroom;


-- ?��? ???? ?ݭ?? ??????
CREATE TABLE seat_use_details(
     use_id     NUMBER(11) CONSTRAINT sud_u_id_pk PRIMARY KEY,                        -- ?ף???�� ?��???��?׶ ?ݬ???��     (PK)
     mem_num    NUMBER(11) CONSTRAINT sud_m_num_fk REFERENCES members(mem_num) ON DELETE SET NULL,       -- ?��???ݭ??   (FK)
     seat_num   NUMBER(11) CONSTRAINT sud_s_num_fk REFERENCES readingroom(seat_num) ON DELETE SET NULL,  -- ?��? ?��?  (FK)
     start_time VARCHAR2(255) DEFAULT to_char(sysdate, 'yyyy.mm.dd hh24:mi'),         -- ?��?? ?��?? ?��??
     end_time   VARCHAR2(255)                                                         -- ?��?? ??? ?��??
);

INSERT INTO seat_use_details VALUES (user_detail_id_seq.nextval, 1, 1, default, null);
INSERT INTO seat_use_details VALUES (user_detail_id_seq.nextval, 2, 7, default, null);
INSERT INTO seat_use_details VALUES (user_detail_id_seq.nextval, 3, 10, default, null);
INSERT INTO seat_use_details VALUES (user_detail_id_seq.nextval, 4, 15, default, null);
INSERT INTO seat_use_details VALUES (user_detail_id_seq.nextval, 5, 5, default, null);
INSERT INTO seat_use_details VALUES (user_detail_id_seq.nextval, 6, 20, default, null);

DELETE FROM seat_use_details WHERE end_time IS NOT NULL;


-- ????? ?ݭ?? ??????
CREATE TABLE IMAGE_INFORMATION(
     image_id  NUMBER(11) CONSTRAINT i_i_id_pk PRIMARY KEY,                          -- ????? ?ݬ???��     (PK)
     image_name     VARCHAR2(255) CONSTRAINT i_i_name_nn NOT NULL,                   -- ????? ????
     image_byte_info      BLOB CONSTRAINT i_i_b_info_nn NOT NULL                     -- ????? byte ?ݭ??
);

CREATE TABLE MEMBER_LOG_HISTORY (
    MEM_LOG_ID      NUMBER(11) CONSTRAINT mem_log_id_pk PRIMARY KEY,
    MEM_NUM      NUMBER(11) CONSTRAINT mlog_mem_num_fk REFERENCES members(mem_num) ON DELETE CASCADE,
    LOGIN_TIME      VARCHAR2(255) DEFAULT to_char(sysdate, 'yyyy.mm.dd hh24:mi'),
    LOGOUT_TIME     VARCHAR2(255)
);

DROP TABLE member_log_history;
DESC member_log_history;
UPDATE  member_log_history SET logout_time = to_char(sysdate, 'yyyy.mm.dd hh24:mi') WHERE mem_num = 6;
SELECT * FROM member_log_history;


CREATE TABLE ADMIN_LOG_HISTORY (
    ADMIN_LOG_ID    NUMBER(11) CONSTRAINT adm_log_id_pk PRIMARY KEY,
    ADMIN_NUM       NUMBER(11) CONSTRAINT admlog_admin_num_fk REFERENCES admins(admin_num) ON DELETE CASCADE,
    LOGIN_TIME      VARCHAR2(255) DEFAULT to_char(sysdate, 'yyyy.mm.dd hh24:mi'),
    LOGOUT_TIME     VARCHAR2(255)
);
DROP TABLE images;
SELECT * FROM admin_log_history;

INSERT INTO admin_log_history VALUES(admin_log_id_seq.nextval, 3);
UPDATE admin_log_history SET logout_time = sysdate WHERE admin_num = 3;

SELECT * FROM fonts;
SELECT * FROM THEMES;
CREATE TABLE FONTS (
    font_id NUMBER(11) CONSTRAINT font_id_pk PRIMARY KEY,
    font_size   VARCHAR(255),
    font_activation CHAR(1) CONSTRAINT font_active_boolean CHECK(font_activation IN ('0', '1'))
);
DELETE FONTS WHERE font_id = 1;
INSERT INTO fonts VALUES(1,'Small','0');

DESC fonts;

CREATE TABLE THEMES (
    theme_id    NUMBER(11) CONSTRAINT theme_id_pk PRIMARY KEY,
    theme_name  VARCHAR2(255),
    theme_activation CHAR(1) CONSTRAINT theme_active_boolean CHECK(theme_activation IN ('0', '1'))
);
UPDATE themes SET theme_activation = 1 WHERE theme_name <> 'BlueGreen'; 

INSERT INTO themes VALUES (5, 'Purple', 0);
INSERT INTO themes VALUES (6, 'Gray', 0);

CREATE TABLE IMAGES (
    image_id    NUMBER(11) CONSTRAINT image_id_pk PRIMARY KEY,
    image_name  VARCHAR2(255),
    image_path  VARCHAR2(255)
);
SELECT * FROM IMAGES;

DELETE images;

CREATE SEQUENCE theme_id_seq 
     INCREMENT BY 1
     START WITH 1
     MINVALUE 1
     MAXVALUE 99999999
     CYCLE
     NOCACHE;

CREATE SEQUENCE image_id_seq
     INCREMENT BY 1
     START WITH 1
     MINVALUE 1
     MAXVALUE 99999999
     CYCLE
     NOCACHE;

CREATE SEQUENCE mem_log_id_seq
    increment by 1
    start with 1;

CREATE SEQUENCE admin_log_id_seq
    increment by 1
    start with 1;



-- ?��?? ?��? ?��???��
CREATE SEQUENCE mem_num_seq
     INCREMENT BY 1
     START WITH 1
     MINVALUE 1
     MAXVALUE 99999999
     CYCLE
     NOCACHE;
     
-- ?��?? ?��? ?��???��
CREATE SEQUENCE admin_num_seq
     INCREMENT BY 1
     START WITH 1
     MINVALUE 1
     MAXVALUE 99999999
     CYCLE
     NOCACHE;

-- ?��?? ?��?��??? ?��???��
CREATE SEQUENCE book_id_seq
     INCREMENT BY 1
     START WITH 1
     MINVALUE 1
     MAXVALUE 999999999
     CYCLE
     NOCACHE;

-- ?ף???�� ?��?? ?��?׶ ?ݬ???�� ?��???��
CREATE SEQUENCE user_detail_id_seq
     INCREMENT BY 1
     START WITH 1
     MINVALUE 1
     MAXVALUE 99999999
     CYCLE
     NOCACHE;

-- ???׵ ?ݬ???�� ?��???��
CREATE SEQUENCE check_out_id_seq
     INCREMENT BY 1
     START WITH 1
     MINVALUE 1
     MAXVALUE 99999999
     CYCLE
     NOCACHE;
     
SELECT * FROM books;
SELECT * FROM readingroom;
SELECT * FROM check_out_info;
SELECT * FROM members;
SELECT * FROM admins;

UPDATE books SET book_duplicates = 2 WHERE book_title = '�Ƹ��';

SELECT * FROM seat_use_details;

INSERT INTO seat_use_details VALUES (user_detail_id_seq.nextval, 2, 10, default, null);

SELECT * FROM books;

SELECT name, value FROM v$spparameter where name = 'processes';

alter system set processes = 200 scope = spfile;

DELETE FROM images WHERE image_id = 153;
SELECT * FROM images;

SELECT * FROM books;

DESC themes;
COMMIT;