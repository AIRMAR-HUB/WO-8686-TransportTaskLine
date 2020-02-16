DECLARE
--B
  ROWKEY_         number := 0;
  CREATED_        number := 0;
  EXECUTED_      number := 0;
  info_               VARCHAR2(2000);
  attr_cf_            VARCHAR2(2000);
  attr_               VARCHAR2(2000);
  action_             VARCHAR2(5)            := 'DO';
  sysdate_            VARCHAR2(100)        := TO_CHAR(SYSDATE, 'YYYY-MM-DD-HH24.MI.SS');
  TIME_CREATED_       VARCHAR2(2000)       := 'CF$_TIME_CREATED' || CHR(31) || sysdate_ || CHR(30) ||'' ;
  TIME_EXECUTED_      VARCHAR2(2000)       := 'CF$_TIME_EXECUTED' || CHR(31) ||sysdate_ || CHR(30) ||'' ;


  rec_    TRANSPORT_TASK_LINE_CFT%ROWTYPE;

BEGIN
/*

 SELECT t.rowid  FROM TRANSPORT_TASK_LINE_tab t  
     WHERE rowkey = 'F8825C567251437AB6B16E4F305CB0A2';
     
  select *  FROM transport_task_line_cft 
            WHERE  ROWKEY =  'F8825C567251437AB6B16E4F305CB0A2';
            
  SELECT  COUNT(ROWKEY), 
                COUNT(CF$_TIME_CREATED), 
                COUNT(CF$_TIME_EXECUTED)    --INTO     ROWKEY_ ,  CREATED_ ,  EXECUTED_
          FROM transport_task_line_cft 
            WHERE  ROWKEY =  'F8825C567251437AB6B16E4F305CB0A2';
*/
  SELECT  COUNT(ROWKEY), 
                COUNT(CF$_TIME_CREATED), 
                COUNT(CF$_TIME_EXECUTED)    INTO     ROWKEY_ ,  CREATED_ ,  EXECUTED_
          FROM transport_task_line_cft 
            WHERE  ROWKEY =  'F8825C567251437AB6B16E4F305CB0A2';

if 1 = 1 then
--IF 'CREATED' = 'CREATED'  AND  CREATED_  =  1 THEN
  if 1 = 1 then
--  IF  ROWKEY_     =  1 THEN
      attr_cf_ := TIME_CREATED_;
      --attr_cf_ := TIME_EXECUTED_;
        DBMS_OUTPUT.PUT_LINE('B1: ' );
--      Airm1app.AMR_TRANSPORT_TASK_LINE_API.Create_Date('F8825C567251437AB6B16E4F305CB0A2', attr_cf_, attr_, 'PREPARE');
      Airm1app.AMR_TRANSPORT_TASK_LINE_API.Create_Date('F8825C567251437AB6B16E4F305CB0A2', attr_cf_, attr_, action_);

--      Airm1app.TRANSPORT_TASK_LINE_CFP.Cf_New__ (info_, 'AAAY2lAAGAACgQvAAj', attr_cf_, attr_, action_);
        DBMS_OUTPUT.PUT_LINE('A1: ' );
/*
      rec_.cf$_time_created    :=   SYSDATE;
      Airm1app.TRANSPORT_TASK_LINE_CFP.Insert___ ('&NEW:ROWKEY', rec_ );
*/
    /* --  ----------INSERT INTO  transport_task_line_cft       VALUES( '&NEW:ROWKEY', sysdate, null);*/
 ELSE
       REC_.cf$_time_executed := SYSDATE;
--       Airm1app.TRANSPORT_TASK_LINE_CFP.Update___ ('&NEW:ROWKEY', rec_ );
       --  ---------UPDATE  transport_task_line_cft              SET  CF$_TIME_CREATED = sysdate WHERE  ROWKEY = -------------------'&NEW:ROWKEY';
 END IF;
END IF;


IF 'NEW:TRANSPORT_TASK_STATUS' = 'EXECUTED' AND  EXECUTED_  = 0   THEN
  IF  ROWKEY_     =  0 THEN
      attr_cf_ := TIME_CREATED_;
      Airm1app.TRANSPORT_TASK_LINE_CFP.Cf_New__ (info_, 'F8825C567251437AB6B16E4F305CB0A2Y', attr_cf_, attr_, action_);
/*
      rec_.cf$_time_created    :=   SYSDATE;
      Airm1app.TRANSPORT_TASK_LINE_CFP.Insert___ ('&NEW:ROWKEY', rec_ );
*/
     --  -------------- INSERT INTO  transport_task_line_cft       VALUES( '&NEW:ROWKEY' , null, sysdate);
 ELSE
       REC_.cf$_time_executed := SYSDATE;
--       Airm1app.TRANSPORT_TASK_LINE_CFP.Update___ ('&NEW:ROWKEY', rec_ );
       --  -------------UPDATE  transport_task_line_cft              SET  CF$_TIME_EXECUTED = sysdate WHERE  ROWKEY = ----------------------'&NEW:ROWKEY';
 END IF;
END IF;

/*

COMMIT;
EXCEPTION
 WHEN OTHERS THEN
   ROLLBACK;
   DBMS_OUTPUT.PUT_LINE('ERROR: ' ||SQLCODE||'-'||SUBSTR(SQLERRM, 1, 300));
*/
END;
