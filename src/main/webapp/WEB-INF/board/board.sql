show tables;

create table board (
	idx 			int not null auto_increment, /*게시글 고유번호*/	
	mid 			varchar(30) not null, /*게시글 올린이 아이디*/
	nickName 	varchar(30) not null, /*게시글 올린이 닉네임*/
	title 		varchar(100) not null, /*게시글 제목*/
	content 	text not null,	/*글 내용*/
	hostIp 		varchar(40) not null, /*글 올린이 IP*/
	openSw 		char(3) default '공개', /*공개글 유무 (공개/비공개)*/
	readNum		int default 0, /*글 조회수 누적(update)*/
	good 			int default 0, /*좋아요 수 누적(update)*/
	wDate 		datetime default now(), /*글 올린 날짜*/
	claim			char(2) default 'No', /*신고글 유무 (신고당한글:OK, 정상글:NO)*/

	primary key(idx),
	foreign key(mid) references member(mid)
);

desc board;

select * from board order by idx desc;

insert into board values (default, 'admin', '관리맨', '게시판 서비스를 시작합니다', '공개 게시판 입니다 만관부', '192.168.50.55', default, default, default, default, default);

--delete from board where idx = 14;

select idx, mid, title, datediff(wDate, now()) as dete_diff from board order by idx desc;

select idx, mid, title, timestampdiff(hour,wDate, now()) as time_diff from board order by idx desc;

-- 이전글 다음글 연습
select idx, title from board where idx < 24 order by idx desc limit 1;
select idx, title from board where idx > 24 order by idx limit 1;

-- 댓글 테이블(boardReply)
create table boardReply (
  idx      int not null auto_increment, /* 댓글의 고유번호 */
  boardIdx int not null,								/* 원본글(부모글)의 고유번호 - 외래키 지정 */
  mid      varchar(30) not null,				/* 댓글 올린이의 아이디 */
  nickName varchar(30) not null,				/* 댓글 올린이의 닉네임 */
  content  text not null,								/* 댓글 내용 */
  hostIp   varchar(50) not null,				/* 접속자 IP */
  wDate    datetime default now(),			/* 댓글 올린 날짜 */
  primary key(idx),
  foreign key(boardIdx) references board(idx) 
  on update cascade 
  on delete cascade
);

drop table boardReply;
desc boardReply;

insert into boardReply values (default, 28, 'hkd1234', '홍장군', '댓글연습입니다.', '192.168.50.20', default);
insert into boardReply values (default, 27, 'kms1234', '김장미', '내용 좋습니다. 참고합니다.', '192.168.50.53', default);
insert into boardReply values (default, 26, 'hkd1234', '홍장군', '관심주세요.', '192.168.50.55', default);

select * from boardReply;

select * from board order by idx desc;
select b.*, r.content from board b, boardReply r where b.idx=r.boardIdx order by idx desc;
select b.*, (select count(idx) from boardReply where boardIdx=b.idx) from board b order by idx desc;


































