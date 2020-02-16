--A  rollback;

select TO_CHAR(SYSDATE, 'MM/DD/YYYY HH12:MI:SS PM') from dual
select TO_CHAR(SYSDATE, 'YYYY-MM-DD-HH24.MI.SS') from dual 
select * from MATERIAL_REQUIS_LINE_TAB where supply_code not in ('IO', 'PI')
 SELECT * FROM  TRANSPORT_TASK_LINE_CFT WHERE rowkey = objkey_;
 
  SELECT * FROM  TRANSPORT_TASK_LINE_CFT WHERE rowkey = 'F8825C567251437AB6B16E4F305CB0A2' FOR UPDATE;
  
  UPDATE TRANSPORT_TASK_LINE_CFT SET CF$_TIME_CREATED = SYSDATE
  WHERE rowkey = 'F8825C567251437AB6B16E4F305CB0A2';   --COMMIT;  rollback;
  UPDATE TRANSPORT_TASK_LINE_CFT SET CF$_TIME_CREATED  = NULL
  WHERE rowkey = 'F8825C567251437AB6B16E4F305CB0A2';   --  COMMIT;     rollback;

select * from MATERIAL_REQUIS_LINE_TAB where order_no  in ('1140')
select * from MATERIAL_REQUIS_LINE_TAB where project_id is null

--BF406FCD1EAE43FF8C9498CE9FE45C6A     2/3/2020 4:39:03 AM
select * from TRANSPORT_TASK_LINE_CFT for update --  commit;
     SELECT objid
      FROM TRANSPORT_TASK_LINE
      WHERE objkey = 'BF406FCD1EAE43FF8C9498CE9FE45C6A';

select * from inventory_part_in_stock where part_no in ('19-029-01')
SELECT count(t.objid)   FROM TRANSPORT_TASK_LINE t     
WHERE objkey = 'BF406FCD1EAE43FF8C9498CE9FE45C6A';

SELECT t.rowid, t.*  FROM TRANSPORT_TASK_LINE_tab t  WHERE rowkey = 'BF406FCD1EAE43FF8C9498CE9FE45C6A';
SELECT t.objid, t.*  FROM TRANSPORT_TASK_LINE t     WHERE objkey = 'BF406FCD1EAE43FF8C9498CE9FE45C6A';
SELECT *  FROM TRANSPORT_TASK_LINE      WHERE objid  = 'AAAY2lAAGAACgQvAAj';
SELECT *  FROM TRANSPORT_TASK_LINE_tab  WHERE rowversion > sysdate-5 rowid = 'AAAY2lAAGAAC2O0AAA';
select * from transport_task_line 
where transport_task_status not in ('Executed') order by 1

select * from 
AIRM1APP.INVENTORY_PART_IN_STOCK_TAB where PART_NO = '19-029-01' for update
--  COMMIT;
----------------------------------------------
--INSERT INTO  transport_task_line_cft       VALUES( 'ABC1', sysdate, null);  -- rollback;
----------------------------------------------
declare
rec_    TRANSPORT_TASK_LINE_CFT%ROWTYPE

begin
  rec_.rowkey              :=  '&NEW:ROWKEY';
  
  rec_.cf$_time_created    :=   SYSDATE
Airm1app.TRANSPORT_TASK_LINE_CFP.Insert___ (rec_.rowkey, rec_ )

REC_.cf$_time_executed := SYSDATE
Airm1app.TRANSPORT_TASK_LINE_CFP.Insert___ (rec_.rowkey, rec_ )
end;

------------------------------------------------------------
declare
--PROCEDURE Unpack___ (
   type_    VARCHAR2(200) := 'DO'  ;--IN     VARCHAR2 DEFAULT 'MODIFY',
   attr_cf_ VARCHAR2(200) := 'CF$_TIME_CREATED' || CHR(31) || sysdate || CHR(30) ||'' ;--IN OUT VARCHAR2,
   newrec_   TRANSPORT_TASK_LINE_CFT%ROWTYPE;
--IS
   ptr_   NUMBER;
   name_  VARCHAR2(30);
   value_ VARCHAR2(4000);
   msg_   VARCHAR2(32000);
BEGIN
   ptr_ := NULL;
   WHILE (Client_SYS.Get_Next_From_Attr(attr_cf_, ptr_, name_, value_)) LOOP
      Dbms_Output.Put_Line('name_ '|| name_ );
      Dbms_Output.Put_Line('value_ '|| value_ );
      /*
      CASE name_
         WHEN 'CF$_TIME_CREATED' THEN

            IF type_ = 'MODIFY' THEN
               Error_SYS.Item_Insert(lu_name_, 'CF$_TIME_CREATED');
            END IF;
            newrec_.cf$_time_created := Client_SYS.Attr_Value_To_Date(value_);


         WHEN 'CF$_TIME_EXECUTED' THEN

            IF type_ = 'MODIFY' THEN
               Error_SYS.Item_Insert(lu_name_, 'CF$_TIME_EXECUTED');
            END IF;
            newrec_.cf$_time_executed := Client_SYS.Attr_Value_To_Date(value_);



         ELSE
            Client_SYS.Add_To_Attr(name_, value_, msg_);
      END CASE;
      */
   END LOOP;
      Dbms_Output.Put_Line('OUT OF LOOP '  );
   --attr_cf_ := msg_;
EXCEPTION
   WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('ERROR: ' ||SQLCODE||'-'||SUBSTR(SQLERRM, 1, 300));-- Error_SYS.Item_Format(lu_name_, name_, value_);
END; -- Unpack___;



   info_       OUT    VARCHAR2,
   objid_      IN     VARCHAR2,
   attr_cf_    IN OUT VARCHAR2,
   attr_       IN     VARCHAR2,
   action_     IN     VARCHAR2 )
IS
   objkey_ VARCHAR2(50) := Get_Objkey_From_Objid(objid_);
SELECT objkey FROM TRANSPORT_TASK_LINE
      WHERE objid = 'AAAY2lAAGAACgQtAAl' objid_;
   
 SELECT t.rowid, t.*  --INTO rowid_  from A
   FROM TRANSPORT_TASK_LINE_tab t  
     WHERE rowkey = 'F8825C567251437AB6B16E4F305CB0A2' --rowkey_; result is AA..goes into proc
     
  objkey_ VARCHAR2(50) := Get_Objkey_From_Objid(objid_);
     CURSOR get_objkey IS
      SELECT * --objkey
      FROM TRANSPORT_TASK_LINE
      WHERE objid = 'AAAY2lAAGAACgQtAAl' -- objid_;   ff.. is returned
  objkey_ = ff..    
 
  IF (Check_Exist___(objkey_)) THEN
      SELECT *
      FROM  TRANSPORT_TASK_LINE_CFT
      WHERE rowkey = 'F8825C567251437AB6B16E4F305CB0A2'  --objkey_;     
      exists - true
      
      --If you try to Modify Created or executed date, process will throw an error
      -- TRANSPORT_TASK_LINE_CFP.UNPACK WILTH A tYPE OF MODIFY THROWS THE ERROR
      -- Rowid is not available until after the commit on TABLE:TRANSPORT_TASK_LINE_tab
      -- Rowid is used to get the rowkey (which we already have).  since you need the 
      -- rowkey, this process can notdo an insert from a trigger process.


  SELECT  COUNT(ROWKEY), 
                COUNT(CF$_TIME_CREATED), 
                COUNT(CF$_TIME_EXECUTED)   -- INTO     ROWKEY_ ,  CREATED_ ,  EXECUTED_
          FROM transport_task_line_cft 
            WHERE  ROWKEY =  'F8825C567251437AB6B16E4F305CB0A2';
            
            
