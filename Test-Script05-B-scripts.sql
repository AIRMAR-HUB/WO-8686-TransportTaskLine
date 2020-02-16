
select * from transport_task_line_cfp
select * from transport_task_line_cft for update  -- commit;  rollback;

select * from transport_task_line_tab where from_contract = 'GEM'

select * from inventory_part_in_stock_tab where contract = 'AMR' and part_no = 'RCVR-A2-8CH-00'


select distinct(transport_task_status) from transport_task_line_tab

-- INSERT INTO  transport_task_line_cft VALUES(2, sysdate);


create table AMR_TEMP_TAB
(
  idd        VARCHAR2(50),
  info1      VARCHAR2(50), 
  info2      VARCHAR2(50) 
)

select * from AMR_TEMP_TAB for update  --  commit;
select count(IDD), count(info1), count(info2) from AMR_TEMP_TAB where idd = 11

declare 
  CREATED_  number := 0;
  EXECUTED_ number := 0;
begin
  select count(info1), 
         count(info2)INTO CREATED_, EXECUTED_
          from AMR_TEMP_TAB where idd = 1;

IF CREATED_ = 1 THEN
 dbms_output.put_line('CREATED_ - TRUE'); 
ELSE
 dbms_output.put_line('CREATED_ - FALSE'); 
END IF;

IF EXECUTED_ = 1 THEN
 dbms_output.put_line('EXECUTED_ - TRUE'); 
ELSE
 dbms_output.put_line('EXECUTED_ - FALSE'); 
END IF;

end;



  select count(CF$_TIME_CREATED), 
         count(CF$_TIME_EXECUTED)INTO CREATED_, EXECUTED_
          from transport_task_line_cft where ROWKEY = 1;

