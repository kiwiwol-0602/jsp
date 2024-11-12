show tables;

create table schedule (
	idx int not null auto_increment, /*스케쥴관리 고유번호*/
	mid varchar(20) not null, /*회원 아이디*/
	sDate datetime not null, /*일정이 있는 날짜*/
	part varchar(10) not null, /*일정분류(1.실패의날, 2.성공의날, 3.주일, 4.반성(합리화)의날*/
	content text not null, /*일정 상세내역*/
	primary key(idx),
	foreign key(mid) references member(mid)
);

desc schedule;

insert into schedule values (default, 'hihi', '2024-11-10', '주일', '주님의 은총으로 부찌3인분 공기밥3개 라면사리2개 사이다');
insert into schedule values (default, 'hihi', '2024-11-10', '반성(합리화)의날', '부찌3인분 먹어서 동물원 가서 반성의 시간을 가졌으나 저녁에 대패삼겹살');
insert into schedule values (default, 'hihi', '2024-11-11', '실패의날', '피자에 소주');
insert into schedule values (default, 'hihi', '2024-11-09', '성공의날', '몸보신으로 삼계탕');
insert into schedule values (default, 'hihi', '2024-11-09', '반성(합리화)의날', '6시 이후엔 살찐다고 쥐포에 맥주 먹으려고 했으나 김치만두 급발진');
insert into schedule values (default, 'hihi', '2024-11-08', '실패의날', '왕천파닭+오뎅탕 소주');
insert into schedule values (default, 'hihi', '2024-11-17', '주일', '수육에 김장김치');
insert into schedule values (default, 'hihi', '2024-11-12', '성공의날', '따뜻한 국밥');
insert into schedule values (default, 'hihi', '2024-11-02', '성공의날', '엄마표 집밥');

select * from schedule order by idx desc;
select * from schedule where mid='hihi' order by idx desc;
select * from schedule where mid='hihi' and substring(sDate,1,10)='2024-11-12' order by idx desc;
select * from schedule where mid='hihi' and substring(sDate,1,10)='2024-11-2' order by idx desc; (x 검색불가)
select * from schedule where mid='hihi' and date_format(sDate,'%Y-%m-%d')='2024-11-02' order by idx desc;

select * from schedule where mid='hihi' and date_format(sDate,'%Y-%m')='2024-11' order by idx desc;
select * from schedule where mid='hihi' and date_format(sDate,'%Y-%m')='2024-11' order by sDate;
select * from schedule where mid='hihi' and date_format(sDate,'%Y-%m')='2024-11' order by sDate, part;


