
drop table department cascade constraints;
drop table program cascade constraints;
drop table building cascade constraints;
drop table course cascade constraints;
drop table classroom cascade constraints;
drop table instructor cascade constraints;
drop table time_block cascade constraints;
drop table student cascade constraints;
drop table schedule cascade constraints;
drop table schedule_waitlist cascade constraints;
drop table special_permission cascade constraints;
drop table course_load cascade constraints;
drop table student_course cascade constraints;
drop table pre_requistics cascade constraints;
drop table preference cascade constraints;
drop table preference_day cascade constraints;

-- DEPARTMENT TABLE
create table department 
(
departmentid int,
departmentname varchar(50),
primary key(departmentid)
);  

-- PROGRAM TABLE
create table program
(
programid int,
departmentid int,
programname varchar(50),
programtype number,  -- 1 = undergrad , 2= masters, 3= PHD
primary key(programid),
foreign key(departmentid) references department
); 

-- building table
create table building
(
buildingid int,
buildingname varchar(50),
primary key(buildingid)
);

-- course table
create table course
(
courseid int,
coursename varchar(50),
programid int, --program table
credits number,  -- no.of credits
grading_format int,  -- 1 = letter, 2= pass/fail  
required int, --  0= elective and 1= core subject
room_type int, -- 1= computer lab , 0= regular room
no_of_sections number,
section_size number,
primary key(courseid),
foreign key(programid) references program(programid),
status number -- 1= open, 0= close
); 

-- classroom table
create table classroom
(
roomid int,
roomname varchar(50),
courseid int, --course table
no_of_seats number,
room_type number, -- different from previous roomtype. what type of room, the class has
primary key(roomid),
foreign key(courseid) references course(courseid)
); 

-- instructor table
create table instructor
(
instructorid int,
instructorname varchar(50),
instructorstatus varchar(50),
courseid int,
departmentid int,
primary key(instructorid),
foreign key(courseid) references course,
foreign key(departmentid) references department
); 

-- time_block table
create table time_block
(
time_blockid int,
roomid int,
start_time timestamp,
instructorid int, --instructor table
length interval day to second,
day1 number,
day2 number,
primary key(time_blockid),
foreign key(instructorid) references instructor,
foreign key(roomid) references classroom
); 

-- student table
create table student
(
student_id int,
student_name varchar(50),
programid int,
primary key(student_id),
foreign key(programid) references program
);


-- schedule table
create table schedule
(
scheduleid int,
courseid int, --from course table
sid int, -- no section id till now, we should create
instructorid int, -- from instructor table
year number,
semester varchar(50), -- fall 2019
capacity_of_students_section number,
time_blockid int, -- from time_block table
roomid int, -- from classroom table
waiting_list_capacity number,
schedule_status number, -- 1= open, 0= full
student_id int, --made changes
primary key(scheduleid),
foreign key(courseid) references course,
foreign key(instructorid) references instructor,
foreign key(time_blockid) references time_block,
foreign key(roomid) references classroom,
foreign key(student_id) references student
); 

 

-- schedule_waitlist table
create table schedule_waitlist
(
scheduled_waitlist_id int,
student_id int, -- from student table
scheduleid int, -- from schedule table
student_position  varchar(50),
sid int, --made changes now
primary key(scheduled_waitlist_id),
foreign key(student_id) references student,
foreign key(scheduleid) references schedule
); 

-- special_permission table
create table special_permission
(
specialpermission_id int,
student_id int, -- from student table
scheduleid int, -- from schedule table
type_of_permission number, -- 1= enroll in close class, 2= enroll without prerequisites
primary key(specialpermission_id),
foreign key(student_id) references student,
foreign key(scheduleid) references schedule
);  

-- course load table
create table course_load
(
course_load_id int,
instructorid int,
courseid int, --made changes now
programid int,
instructorname varchar(50),
no_of_courses number,
year number,
semester varchar(50),
primary key(course_load_id),
foreign key(instructorid) references instructor,
foreign key(courseid) references course,
foreign key(programid) references program
); 

-- student_course table
create table student_course
(
student_course_id int,
reg_status int,
courseid int,--from course table
student_id int, --from student table
scheduleid int, --from schedule table (changes made now)
sid int, --made changes now
primary key(student_course_id),
foreign key (courseid) references course,
foreign key (student_id) references student,
foreign key(scheduleid) references schedule
);

-- pre-requistics table
create table pre_requistics
(
pre_requistics_id varchar(50),
pre_requistics_name varchar(50),
courseid int,
credits number,
primary key(pre_requistics_id),
foreign key (courseid) references course
);

-- Preference table 1
create table preference
(
preference_id int,
instructorid int,
courseid int, 
no_of_sections number,
year number,
semester varchar(50),
primary key(preference_id)
);

-- Preference day table
create table preference_day
(
preference_day_id int,
instructorid int,
day1 number,
day2 number,
primary key(preference_day_id),
foreign key(instructorid) references instructor
);


-- INSERTION: 	

-- Department table
insert into department values(1,'Computer Science');
insert into department values(2,'Information Systems');
insert into department values(3,'Data Science');
insert into department values(4,'Engineering Management');
insert into department values(5,'Human Centered Computing');

-- Program table
insert into program values(11,2,'Information Systems',2);
insert into program values(12,5,'Human Centered Computing',2);
insert into program values(13,3,'Data Science',2);
insert into program values(14,4,'Engineering Management',3);
insert into program values(15,1,'Computer Systems',3);
insert into program values(16,1,'Computer Systems',1);

-- Building table
insert into building values(001,'Physics');
insert into building values(002,'IT');
insert into building values(003,'Public Policy');
insert into building values(004,'Administration');
insert into building values(005,'Administration');
insert into building values(006,'Physics');

-- Course table
insert into course values(10,'Advance Database Projects',11,3,1,1,0,2,35,1);
insert into course values(20,'Digital Media',11,3,1,1,0,1,40,1);
insert into course values(30,'Distributed Systems',11,2,1,0,0,1,40,1);
insert into course values(40,'Management Information Systems',11,2,1,1,1,1,40,1);
insert into course values(50,'Design Algorithm Analysis',13,3,1,0,0,2,30,1);
insert into course values(60,'Structural Analysis',14,2,1,1,1,1,45,1);


-- Classroom table
insert into classroom values(101,601,10,35,0);
insert into classroom values(102,603,30,40,0);
insert into classroom values(103,620,30,31,1);
insert into classroom values(104,621,40,50,1);
insert into classroom values(105,332,50,45,0);
insert into classroom values(106,331,60,40,0);

-- Instructor table
insert into instructor values(22, 'William', 'Fulltime',10, 1);
insert into instructor values(33, 'Roberts', 'Parttime',60, 3);
insert into instructor values(44, 'James', 'Parttime',50, 4);
insert into instructor values(55, 'John', 'Fulltime',20, 5);
insert into instructor values(66, 'William', 'Fulltime',30, 2);
insert into instructor values(77, 'Roberts', 'Parttime',40, 1);

--Time_block table
insert into time_block values(201,101, timestamp '2019-08-01 04:30:00.0',22,interval '2:15' hour to minute,1,2);
insert into time_block values(202,102, timestamp '2019-08-02 04:30:00.0',22,interval '2:15' hour to minute,3,4);
insert into time_block values(203,103, timestamp '2019-08-03 07:00:00.0',44,interval '1:15' hour to minute,5,null);
insert into time_block values(204,104, timestamp '2019-08-04 07:00:00.0',55,interval '1:15' hour to minute,3,null);
insert into time_block values(205,106, timestamp '2019-08-05 04:30:00.0',66,interval '2:15' hour to minute,1,4);
insert into time_block values(206,105, timestamp '2019-08-06 04:30:00.0',77,interval '1:15' hour to minute,2,null);

--Student table
insert into student values(2001,'Paul',11);
insert into student values(2002,'Peter',13);
insert into student values(2003,'Lia',15);
insert into student values(2004,'Mathew',16);
insert into student values(2005,'Keven',11);


--Schedule table
insert into schedule values(1001,10,100,22,2019,'fall',35,202,101,2,1,2001);
insert into schedule values(1002,30,300,66,2019,'fall',40,205,102,1,1,2002);
insert into schedule values(1003,20,200,55,2019,'spring',40,203,104,3,1,2003);
insert into schedule values(1004,50,500,44,2019,'spring',30,201,103,2,0,2004);
insert into schedule values(1005,60,600,33,2019,'fall',45,206,105,4,1,2005);
insert into schedule values(1006,40,400,33,2019,'spring',40,204,106,1,1,2001); 

--Schedule_waitlist 
insert into schedule_waitlist values(4001,2001,1001,1,100);
insert into schedule_waitlist values(4002,2003,1006,1,200);
insert into schedule_waitlist values(4003,2002,1004,0,300);
insert into schedule_waitlist values(4004,2005,1005,1,400);
insert into schedule_waitlist values(4005,2004,1002,1,500);

--Special_permission table
insert into special_permission values(3001,2003,1006,1);
insert into special_permission values(3002,2001,1005,2);
insert into special_permission values(3003,2002,1003,2);
insert into special_permission values(3004,2004,1002,1);
insert into special_permission values(3005,2005,1001,1);

--Course_load table
insert into course_load values(1010,22,10,11,'William',2,2019,'fall');
insert into course_load values(1011,33,20,12,'Roberts',1,2019,'fall');
insert into course_load values(1012,44,30,13,'James',1,2019,'spring');
insert into course_load values(1013,55,50,14,'John',1,2019,'spring');
insert into course_load values(1014,66,60,15,'William',1,2019,'spring');

--Student_course table
insert into student_course values(5001,1,10,2001,1001,100);
insert into student_course values(5002,1,30,2002,1006,200);
insert into student_course values(5003,0,40,2003,1005,300);
insert into student_course values(5004,1,60,2004,1002,600);
insert into student_course values(5005,1,50,2005,1003,400); 

-- Pre_requistics table
insert into pre_requistics values(601,'Database',10,3);
insert into pre_requistics values(600,'Object-oriented',20,3);
insert into pre_requistics values(650,'Data-Communication',30,3);
insert into pre_requistics values(435,'Computer Graphics',40,3);
insert into pre_requistics values(481,'Computer Networks',50,3);

-- Preference table
insert into preference values(301,22,10,2,2019,'fall');
insert into preference values(302,33,60,1,2019,'fall');
insert into preference values(303,44,50,2,2019,'spring');
insert into preference values(304,55,20,1,2019,'spring');
insert into preference values(305,66,30,1,2019,'fall');
insert into preference values(306,77,40,1,2019,'spring');

-- Preference day table
insert into preference_day values(401,22,1,2);
insert into preference_day values(402,33,3,4);
insert into preference_day values(403,44,5,1);
insert into preference_day values(404,55,3,2);
insert into preference_day values(405,66,1,4);


drop sequence course_load_id_seq;
drop sequence preference_id_seq;
drop sequence preference_day_id_seq;
CREATE SEQUENCE course_load_id_seq START WITH 1015;
CREATE SEQUENCE preference_id_seq START WITH 307;
CREATE SEQUENCE preference_day_id_seq START WITH 406;








--Feature 1

drop sequence sequence_name;
CREATE SEQUENCE sequence_name
START WITH 70
INCREMENT BY 10;

show error;
set serveroutput on;
create or replace procedure feature_one
(
course_name in varchar,
program_id in integer,
no_of_credits in number,
gradingformat in int,
req in integer,
roomtype in integer,
amount_of_section in number,
section_sizes in number,
course_status in number
)
AS
v_count int;
begin
select count(*) into v_count from course where coursename = course_name;
if v_count = 1 then
update course
set coursename = course_name,
programid = program_id,
credits = no_of_credits,
grading_format = gradingformat,
required = req,
room_type = roomtype,
no_of_sections = amount_of_section;
else
insert into course(courseid, coursename, programid, credits, grading_format,REQUIRED, room_type, no_of_sections,section_size,status)
values(sequence_name.nextval, course_name, program_id, no_of_credits, gradingformat, req, roomtype, amount_of_section,section_sizes,course_status);
dbms_output.put_line(sequence_name.currval);
end if;
Exception
when no_data_found then
dbms_output.put_line('no data found');
end;
/



--Feature 2

drop sequence seq_iid;
CREATE SEQUENCE seq_iid
START WITH 88
INCREMENT BY 10;

show errors;
set serveroutput on;
create or replace procedure feature_two
(
instructor_name in varchar,
department_id in int,
instructor_type in varchar
)
AS
v_count int;
v_count1 int;
v_count2 int;
begin
select count(*) into v_count from instructor where instructorname = instructor_name;
select count(*) into v_count1 from instructor where instructorstatus = instructor_type;
select count(*) into v_count2 from instructor where departmentid=department_id;
if v_count = 0 or v_count1 = 0 or v_count2 = 0 then
insert into instructor(instructorid , instructorname, departmentid, instructorstatus)
values
(seq_iid.nextval, instructor_name, department_id, instructor_type);
dbms_output.put_line(seq_iid.currval);
else
dbms_output.put_line('Invalid entry');
end if;
end;
/
 

--Feature 3

drop sequence course_load_id_seq;
drop sequence preference_id_seq;
drop sequence preference_day_id_seq;
CREATE SEQUENCE course_load_id_seq START WITH 1015;
CREATE SEQUENCE preference_id_seq START WITH 307;
CREATE SEQUENCE preference_day_id_seq START WITH 406;
create or replace procedure C_load (i_id in int,yr in number,sem in varchar,c_load in int,
willing_courses in courselisttype,num_sec in number,v_day1 number,v_day2 number)
is
v_count int;
c_count int;
n_count int;
course_list courselisttype;
begin
select count(*) into v_count from instructor where instructorid=i_id;
c_count:=willing_courses.count;
dbms_output.put_line(c_count);
select (regexp_count(v_day1,v_day2 , ',') + 1) into n_count from dual ;
dbms_output.put_line(n_count);
if v_count=0
then dbms_output.put_line(i_id ||' is an invaild instructor ID');
elsif c_load > c_count
then dbms_output.put_line('list of courses willing to teach cannot be less than course load');
elsif n_count>2
then dbms_output.put_line('Instructor not available is over two');
else
insert into preference_day(preference_day_id,instructorid,day1,day2) values(preference_day_id_seq.nextval,i_id,v_day1,v_day2);
dbms_output.put_line('rows inserted into preference_day table');
select willing_courses into course_list from dual;
FOR i in 1 ..course_list.count LOOP
insert into preference (preference_id,instructorid,courseid,no_of_sections,year,semester) values(preference_id_seq.nextval,i_id,course_list(i),num_sec,yr,sem);
end loop;
dbms_output.put_line('rows inserted into preference table');
insert into course_load (course_load_id,instructorid,no_of_courses,semester,year) values(course_load_id_seq.nextval,i_id,c_load,sem,yr);
dbms_output.put_line('rows inserted into course_load table');
end if;
end;
/


--Feature 4
set serveroutput on;
create or replace procedure feature_four (v_yr in number, v_sem in varchar, v_pid in int) 
IS
Cursor c1 is select coursename,credits, grading_format, scheduleid, schedule.sid, instructorname, roomname, day1, day2, start_time, start_time+length AS end_time, 
course.status from course, schedule,instructor,classroom,time_block where course.courseid=schedule.courseid and schedule.instructorid=instructor.instructorid 
and schedule.roomid=classroom.roomid and classroom.roomid=time_block.roomid and year=v_yr and semester=v_sem and programid=v_pid 
order by course.courseid,schedule.sid;


v_name course.coursename%type;
no_credits course.credits%type;
v_grading course.grading_format%type;
v_scid schedule.scheduleid%type;
v_sid schedule.sid%type;
v_inst_name instructor.instructorname%type;
v_rname classroom.roomname%type;
v_day1 time_block.day1%type;
v_day2 time_block.day2%type;
v_st_time time_block.start_time%type;
v_end_time time_block.start_time%type;
v_status course.status%type;
v_count int;
---P_count int; check
begin
Open c1;
select count(*) into v_count from program where programid=v_pid;
--select count(*) into P_count from course where programid=v_pid;
if v_count=0 then
dbms_output.put_line('program id is invalid');
--elsif p_count =0 then
--dbms_output.put_line('program id is valid but not present in our database');
else
Loop
fetch c1 into v_name, no_credits, v_grading, v_scid, v_sid, v_inst_name, v_rname, v_day1, v_day2, v_st_time, v_end_time, v_status;
exit when c1%notfound;
dbms_output.put_line('name of course is:'||v_name||',number of credits:'||no_credits||',grading format:'||v_grading);
dbms_output.put_line('The schedule id is:'||v_scid||',Section id is:'||v_sid||',instructor name is:'||v_inst_name);
dbms_output.put_line('classroom name is:'||v_rname||',days of class:'||v_day1||','||v_day2||',start time of the class:'||v_st_time);
dbms_output.put_line('end time of the class:'||v_end_time||',status of the class:'||v_status);
End loop;
end if;
close c1;
END;
/


--Feature 5
show errors;
set serveroutput on;
create or replace procedure feature_5 (yr in number,sem in varchar)
is
cursor z is select instructorid,count(courseid) as cnt_cour from schedule
where year=yr and semester=sem group by instructorid;
cnt int;
instid int;
begin
for zrec in z loop
cnt:=zrec.cnt_cour;
dbms_output.put_line(cnt);
instid:=zrec.instructorid;
dbms_output.put_line(instid);
update course_load set no_of_courses = cnt where instructorid=instid and year=yr and semester=sem;
dbms_output.put_line('row updated in table');
end loop;
end;
/




--Feature 6
drop sequence abc;
CREATE SEQUENCE abc
START WITH 1007
INCREMENT BY 1;

Create or replace type sectionlisttype as varray(10) of number;

Create or replace procedure assign_instructors(input_course_id int, input_year number, input_sem varchar)
AS
section_ids sectionlisttype;
max_sections course.no_of_sections%type;
max_willing_to_teach preference.no_of_sections%type;
sections_needed int;
min_value int;
new_section_id int;
systimestamp timestamp;
section_count int;
stu_id int;
Begin
select no_of_sections into max_sections from course where courseid = input_course_id;

select distinct(sid) bulk collect into section_ids from schedule where courseid = input_course_id;
sections_needed := max_sections - section_ids.count;

if (sections_needed=0) then
    dbms_output.put_line('Enough Sections');
else
    for c1 in (select preference.instructorid, course.courseid, course.section_size,input_year,input_sem,stu_id
        from course_load,course,preference
        where course.courseid = preference.courseid and course_load.instructorid=preference.instructorid and course_load.year =input_year
        and course_load.semester = input_sem and course_load.semester=preference.semester and course_load.year=preference.year
        and course.courseid = input_course_id
        order by least(sections_needed,preference.no_of_sections)*(course_load.no_of_courses - scheduled_no_of_courses) desc)
    loop
        if sections_needed = 0 then
            dbms_output.put_line('Assigned all sections');
        end if;
        section_count := section_ids.count + 1;
        dbms_output.put_line('Assigning course id: ' || input_course_id || 'with new section ID = ' || section_count ||
        'for instructor ID = ' || c1.instructorid);
        insert into schedule values (abc.nextval, input_course_id, section_count,
        c1.instructorid,input_year,input_sem, c1.section_size,NULL,NULL,10,1,c1.stu_id);
        sections_needed := sections_needed -1;
       
    end loop;
    if sections_needed > 0 then
        dbms_output.put_line('Not possible to assign more sections.');
    end if;
end if;
End;
/





--Feature 7
drop table temp_course;

create global temporary table temp_course
(
	course_id varchar(100),
	course_name varchar(100),
	program_pid number
);


----procedure to find course that is not assigned----

create or replace procedure find_course(program_id in number)
is
cursor c1 is
select courseid,coursename from course where not exists(select null from course_load where course.courseid=course_load.courseid);
ccid varchar(100);
ccname varchar(100);
begin
open c1;
loop
	fetch c1 into ccid,ccname;
	exit when c1%notfound;
	if c1%found then
	insert into temp_course(course_id,course_name,program_pid) values (ccid,ccname,program_id);
	else
	dbms_output.put_line('all courses are assigned');
	end if;
end loop;
close c1;
end;
/


-----temporary table for instructor----

drop table temp_instructor;
create global temporary table temp_instructor
(
instructor_id int,
instructor_name varchar(100),
program_pid varchar(100)
);


-----procedure to find the instructor not exceed their course load----

create or replace procedure find_instructor(v_programid in number)
is
cursor c1 is
select instructorid, instructorname from course_load where programid=v_programid and no_of_courses < course_load_id;
v_iid int;
v_iname varchar(100);
begin
open c1;
loop
	fetch c1 into v_iid,v_iname;
	exit when c1%notfound;
	if c1%found then
	insert into temp_instructor(instructor_id,instructor_name,program_pid) values (v_iid,v_iname,v_programid);
	else
	dbms_output.put_line('no instructor');
	end if;
end loop;
close c1;
end;
/



-----assign elective to instructor-----

create or replace procedure assign_elective(v_iid in int,v_iname in varchar,course_d in varchar)
is
no_course varchar(100);
v_cid course_load.course_load_id%type;
v_ass course_load.no_of_courses%type;
begin
	select course_name into no_course from temp_course where course_id=course_d; 
	insert into course_load (instructorid,instructorname,courseid,no_of_courses) values (v_iid, v_iname, course_d,no_course);
	update course_load set no_of_courses=no_of_courses+1 where instructorid=v_iid;
	if v_cid > v_ass then
	dbms_output.put_line(v_iid || v_iname);
	end if;
	exception 
	when no_data_found then
	dbms_output.put_line('invalid data');
end;
/



--Feature 8
create table temp_score (room_score int, time_block_score int, total int);

alter table temp_score add (room_id int, time_block_id int);

--truncate table temp_score;

set serveroutput on;
show errors;
create or replace procedure compu(schedule_id int)
as
v_student_count int;
v_schedule_count int;
tb_id schedule.time_blockid%type;
r_id schedule.roomid%type;
d1 preference_day.day1%type;
d2 preference_day.day2%type;
st_time time_block.start_time%type;
len time_block.length%type;
graduate_program program.programtype%type;
room_id classroom.roomid%type;
room_type course.room_type%type;
r_count int;
tb_count int;
min_total_score int;

f_roomid schedule.roomid%type;
f_tbid schedule.time_blockid%type;


cursor c1 is select c.roomid from schedule s, classroom c where s.scheduleid = schedule_id and s.CAPACITY_OF_STUDENTS_SECTION <= c.NO_OF_SEATS;
cursor c2 is select t.time_blockid from time_block t, schedule s where s.scheduleid = schedule_id and s.instructorid = t.instructorid;

begin
    select count(*) into v_schedule_count from schedule where scheduleid = schedule_id;
    if v_schedule_count = 0 then
        dbms_output.put_line('Invalid Schedule ID');
    else
        select time_blockid, roomid into tb_id, r_id from schedule s where s.scheduleid = schedule_id;
        if tb_id is not null and r_id is not null then
            dbms_output.put_line('Already course assigned' || tb_id  || '-----' || r_id);
        else
            dbms_output.put_line('Register' || tb_id  || '-----' || r_id);
           
            select day1, day2 into d1, d2 from preference_day p, schedule s where s.instructorid = p.instructorid and s.scheduleid = schedule_id;
            dbms_output.put_line(' Instructor black out days' || d1  || '-----' || d2);
           
            select start_time, length into st_time, len from time_block tb, schedule s where s.instructorid = tb.instructorid and s.scheduleid = schedule_id;
            dbms_output.put_line(' Start time and lenght'  || st_time  || '-----' || len);
           
            select p.programtype into graduate_program from course c, program p, schedule s where s.courseid = c.courseid and c.programid = p.programid and s.scheduleid = schedule_id;
           
            if graduate_program = 2 then
                dbms_output.put_line(' Its a graduate program');
               
            else
                dbms_output.put_line(' Its not a graduate program');
            end if;
            
            open c1;
           
            loop
            fetch c1 into room_id;
            exit when c1%notfound;
            dbms_output.put_line('room id : '||room_id);
            select count(*) into r_count from schedule where roomid = room_id;
            dbms_output.put_line('room score count : '||r_count);
           
            insert into temp_score(room_score, room_id) values (r_count, room_id);
           
            end loop;
            close c1;            
           
            open c2;
            loop
            fetch c2 into tb_id;
            exit when c2%notfound;
           
            dbms_output.put_line('timeblock id : '||tb_id);
            select count(*) into tb_count from schedule where time_blockid = tb_id;
            dbms_output.put_line('time block score count : '||tb_count);
           
            update temp_score set time_block_score = tb_count;
            update temp_score set time_block_id = tb_id;
           
            end loop;
            close c2;
           
            update temp_score set total = room_score * time_block_score;
           
            select c.room_type into room_type from course c, schedule s where s.scheduleid = 1002 and c.courseid = s.courseid;
           
            if room_type = 1 then
                dbms_output.put_line('Computer room required');
            else
                dbms_output.put_line('Computer room  not required');
            end if;
           
            SELECT total, room_id, time_block_id into min_total_score, f_roomid, f_tbid FROM temp_score WHERE total =(SELECT MIN( total ) FROM  temp_score) and rownum = 1;
           dbms_output.put_line('score : ' || min_total_score || ', Final Room id : ' || f_roomid || ', final timeblock id : ' || f_tbid);
           
           update schedule set time_blockid  = f_tbid, roomid = f_roomid where scheduleid = schedule_id;
        end if;
    end if;

end;
/



--Feature 9

create or replace procedure compute(dept_id in department.departmentid%type, year schedule.year%type, semester schedule.semester%type)
as
sch_id schedule.scheduleid%type;
cursor c1 is select s.scheduleid from department d, schedule s , program p, course c where d.departmentid = p.departmentid and p.programid = c.programid and c.courseid = s.courseid and d.departmentid  = dept_id and s.year = year and s.semester = semester order by p.programtype desc;

begin
    open c1;
    loop
    fetch c1 into sch_id;
    exit when c1%notfound;   
    compu(sch_id);   
    end loop;
    close c1;  
end;
/



--Feature 10
drop sequence sequence_feature_ten;
CREATE SEQUENCE sequence_feature_ten
START WITH 3006
INCREMENT BY 1
CACHE 20;
show error;
set serveroutput on;
create or replace procedure feature_ten
(
st_id in integer,
sh_id in integer,
permission_type in number
)
as
v_studentid_count int;
v_scheduleid_count int;
begin
select count(*) into v_studentid_count from special_permission where student_id = st_id;
select count(*) into v_scheduleid_count from special_permission where scheduleid = sh_id;
if v_studentid_count = 0  then
	dbms_output.put_line('Invalid Student ID');
elsif v_scheduleid_count = 0 then
	dbms_output.put_line('Invalid Schedule ID');
else 
insert into special_permission(specialpermission_id, student_id, scheduleid, type_of_permission)
values(sequence_feature_ten.nextval, st_id, sh_id, permission_type);
end if;
end;
/



--Feature 11
show errors;
set serveroutput on;
create or replace function feature_eleven(
v_student_id in number,
v_schedule_id in number
)
return number 
IS
prereqcoursid varchar(50);
studentt_id number;
schedulee_id number;
coursee_id number;
v_out number;
begin
select count(*) into studentt_id from student where student_id=v_student_id;
select count(*) into schedulee_id from schedule where scheduleid=v_schedule_id;
select courseid into coursee_id from schedule where scheduleid=v_schedule_id;
select pr.courseid into prereqcoursid from student s,schedule sc,program p,course c,pre_requistics pr 
where sc.courseid=c.courseid and s.programid=p.programid and
v_student_id=s.student_id and c.programid=p.programid and
pr.courseid=c.courseid and v_schedule_id=sc.scheduleid; 
if schedulee_id !=0 and coursee_id=prereqcoursid then 
v_out:=1;
return v_out;
else 
v_out:=0;
return v_out;
end if;
exception 
when no_data_found then
dbms_output.put_line('No data found exception');
v_out:=0;
end;
/



--Feature 12
set serveroutput on;
create or replace procedure feature_twelve(stu_id in student.student_id%type,sch_id schedule.scheduleid%type)
IS
v_studentid student.student_id%type;
v_schedule_id schedule.scheduleid%type;
v_section_id schedule.sid%type;
v_course_id course.courseid%type;
v_rstatus student_course.reg_status%type;
v_permissiontype special_permission.type_of_permission%type;
v_sec_capacity schedule.capacity_of_students_section%type;
v_section_size schedule.capacity_of_students_section%type;
v_waitlist schedule_waitlist.student_position%type;
v_grade course.grading_format%type;
v_status schedule.schedule_status%type;
Begin
select count(*) into v_studentid from student 
where student_id = stu_id;

select count(*) into v_schedule_id from schedule where scheduleid = sch_id;
select courseid into v_course_id from schedule where scheduleid = sch_id;

if v_studentid != 0 and v_schedule_id != 0 then

Select sid into v_section_id from schedule where scheduleid = sch_id;
select grading_format into v_grade from course where courseid = v_course_id ;

If v_grade = 0 then

Select reg_status into v_rstatus from student_course sc, schedule sh , pre_requistics pr

where sc.student_id = stu_id and  sh.sid = ( select pr.pre_requistics_id from pre_requistics pr where courseid
= (Select courseid from schedule where scheduleid = sch_id))and pr.courseid = sh.sid ;
       
        select type_of_permission into v_permissiontype from special_permission
        where student_id =  stu_id 
        and  scheduleid = sch_id;

            If v_permissiontype  = 2 then 
            select schedule_status  into v_status from schedule
            where sid = (Select sid from course  
                                      where scheduleid = sch_id);

                if v_status =  1 
                then 
                select type_of_permission into v_permissiontype from special_permission
                    where student_id =   stu_id 
                    and  scheduleid =   sch_id;

                    If v_permissiontype =  1
                    then
                    insert into schedule values (null,v_course_id, v_section_id, null,null,null,null,null,null,null,v_status,stu_id);

                    select count(*) into v_sec_capacity from schedule where sid = (select sid from schedule 
                                                                                    where scheduleid = sch_id)
                   and schedule_status = 1;

                        select capacity_of_students_section into v_section_size from schedule where  scheduleid=sch_id ;

                        If  v_sec_capacity = v_section_size 
                        then 
                        update schedule set schedule_status = 0
                        where sid = (select sid from course
                                            where scheduleid = sch_id);

                        select count(*) into v_waitlist from schedule_waitlist where scheduleid = sch_id;

                                If v_waitlist <10 
                                then 
                                update schedule_waitlist set student_position 
                                = (select max(student_position)from schedule_waitlist
                                                            where scheduleid = sch_id)
                                where scheduleid = sch_id;

                                else 
                                dbms_output.put_line('waitlist is full ');
                        end if;
                    end if ;
                end if;
            end if;
        end if;
    end if;
end if;
end;
/



--Feature 13
set serveroutput on;
create or replace procedure feature_thirteen(stu_id int, sch_id int)
as
v_student_count int;
v_schedule_count int;
a int;
b int;
c int;
d int;
e int;
f int;
g int;

--cursor c1 is select student_position

begin
    select count(*) into v_student_count from student where student_id = stu_id;
    select count(*) into v_schedule_count from schedule where scheduleid = sch_id;
    if v_student_count = 0  then
        dbms_output.put_line('Invalid Student ID');
    elsif v_schedule_count = 0 then
        dbms_output.put_line('Invalid Schedule ID');
    else
        select count(*) into a from student_course sc where sc.student_id = stu_id;
        if a=0 then
            dbms_output.put_line('Not registered');
           
        else
            select sc.reg_status into b from student_course sc where sc.student_id = stu_id and sc.scheduleid = sch_id;
           
            dbms_output.put_line(b);
            if b = 0 then
                update student_course set reg_status=1 where student_id = stu_id and scheduleid = sch_id;
                update schedule_waitlist set student_position = student_position - 1 where student_position > d;
            elsif (b = 1) then
                update student_course set reg_status=2 where student_id = stu_id and scheduleid = sch_id;
                select min(student_position) into e from schedule_waitlist;
                select student_id, scheduleid into f,g from schedule_waitlist where e=student_position;
                dbms_output.put_line('f :' || f);
                dbms_output.put_line('g :' || g);
                update schedule_waitlist set student_position = student_position - 1 where student_position > e;
                                 
               
            end if;
           
        end if;
end if;        
end;
/



--Feature 14
set serveroutput on;
create or replace procedure feature_forteen(v_yr in number, stu_id in int, v_sem in varchar) IS
Cursor c1 is select c.courseid, c.coursename, sh.sid, sh.schedule_status, shw.student_position 
from course c, schedule sh, schedule_waitlist shw,student_course sc 
where c.courseid=sh.courseid and sc.courseid=sh.courseid and sc.student_id=shw.student_id and 
sh.sid=shw.sid and year=v_yr and sc.student_id=stu_id and semester=v_sem;
c_id course.courseid%type;
c_name course.coursename%type;
se_id schedule.sid%type;
course_status schedule.schedule_status%type;
waitlist_position schedule_waitlist.student_position%type;
v_count int;
begin
Open c1;
select count(*) into v_count from schedule_waitlist where student_id=stu_id;
if v_count=0 then
dbms_output.put_line('student id is invalid');
else
Loop
fetch c1 into c_id, c_name, se_id, course_status, waitlist_position;
exit when c1%notfound;
if course_status=0 then
dbms_output.put_line('course id is:'||c_id||', name of the course is:'||c_name||', section id is:'||se_id||', status of the class:'||course_status||', wait list position of the student is:'||waitlist_position);
else
dbms_output.put_line('course id is:'||c_id||', name of the course is:'||c_name||', section id is:'||se_id||', status of the class:'||course_status);
end if;
End loop;
end if;
close c1;
END;
/


--Feature 15
set serveroutput on;
Create or replace procedure feature_fifteen
(
dept_id IN int,
yr IN number,
sem IN varchar)
IS
cursor c1 is select c.no_of_sections,c.courseid,c.coursename,sch.sid,count(reg_status) as no_stu_enrl_wl
from schedule sch,course c,program p,department d,schedule_waitlist sw,student_course sc
where sch.courseid=c.courseid and p.programid=c.programid and p.departmentid=d.departmentid and sch.scheduleid=sw.scheduleid and
sch.scheduleid=sc.scheduleid and sc.student_id=sw.student_id and year=yr and semester=sem and
sc.reg_status in (1,0)and d.departmentid=dept_id group by c.no_of_sections,c.courseid,c.coursename,sch.sid;
v_total_course int;
total_student int;
no_section number;
c_id int;
c_name varchar(50);
se_id int;
no_stu_enrl_wl int;
v_count int;
begin
select count(*) into v_count from department where departmentid=dept_id;
if v_count=0 then
dbms_output.put_line('Invalid department ID');
else
select count(sc.student_id)into total_student from schedule sch,course c,program p,department d,schedule_waitlist sw,student_course sc
where sch.courseid=c.courseid and p.programid=c.programid and p.departmentid=d.departmentid  and  sch.scheduleid=sw.scheduleid and sw.student_id=sc.student_id and
sch.scheduleid=sw.scheduleid and sc.reg_status = 1 and sch.year=yr and sch.semester=sem and d.departmentid=dept_id having count(*)>=1;
dbms_output.put_line('Total number of students enrolled to at least one course for year : '||yr||' and semester : '||sem||' is '||total_student);
open c1;
select count(c.courseid) as total_course into v_total_course from course c,program p,department d,schedule sch
where c.programid=p.programid and d.departmentid=p.departmentid and sch.courseid=c.courseid and year=yr and semester=sem;
loop
fetch c1 into no_section,c_id,c_name,se_id,no_stu_enrl_wl;
exit when c1%notfound;
dbms_output.put_line('Total number of courses is : '||v_total_course|| ', course ID is :'||c_id||'course name is :'||c_name||', section ID is : '||se_id||', number students in enrolled or waitlist status is :'||no_stu_enrl_wl);
end loop;
end if;
end;
/


--Feature 16
set serveroutput on;
show errors;
create or replace procedure feature_k(v_year schedule.year%type, v_sem schedule.semester%type,
k in schedule.waiting_list_capacity%type)
is
cursor c1 is select min(sc.roomid),min(sc.time_blockid)
from schedule sc
where sc.year = v_year and sc.semester = v_sem and sc.waiting_list_capacity = k
group by roomid,time_blockid;
cursor c2 is select sc.roomid, cr.roomname, sc.waiting_list_capacity from schedule sc, classroom cr where
sc.roomid = cr.roomid and sc.year = v_year and sc.semester = v_sem and sc.waiting_list_capacity = k;
cursor c3 is select tb.time_blockid,tb.day1,tb.day2,tb.start_time
from schedule sc,time_block tb
where sc.time_blockid = tb.time_blockid and sc.year = v_year and sc.semester = v_sem and sc.waiting_list_capacity = k;

v_minrid integer;
v_mintid integer;
v_a integer;
v_rn varchar(60);
v_sec integer;
v_d1 integer;
v_d2 integer;
v_count integer;
begin
open c1;
loop
fetch c1 into v_minrid, v_mintid;
exit when c1%notfound;
end loop;
select roomid into v_count from schedule where year = v_year and semester = v_sem and
waiting_list_capacity = k;
if v_count != 0 then
for i in c2
loop
v_a := i.roomid;
v_rn := i.roomname;
dbms_output.put_line('class id= ' || v_a || ' class name= ' || v_rn
|| ' waiting list length= ' || i.waiting_list_capacity);
end loop;
select sid into v_sec from schedule where schedule.year = v_year and
schedule.semester = v_sem and schedule.waiting_list_capacity = k;
dbms_output.put_line('room id= '|| v_a || ' room name=' || v_rn || ' Number of schedule class sections=' || v_sec);
else
dbms_output.put_line('Invalid room id');
end if;
select tb.day1, tb.day2 into v_d1, v_d2 from time_block tb, schedule sc where
sc.time_blockid = tb.time_blockid and sc.year = v_year and sc.semester = v_sem and sc.waiting_list_capacity = k;
if v_d1 = NULL and v_d2 = NULL then
dbms_output.put_line(' Invalid time block id');
else
for j in c3
loop
dbms_output.put_line('tid= ' || j.time_blockid || ' day1 = ' || j.day1 || ' day2= ' || j.day2  || ' start_time= ' || j.start_time);
end loop;
end if;
exception
when no_data_found then
dbms_output.put_line('no data found');
end;
/







