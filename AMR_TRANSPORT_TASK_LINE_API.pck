create or replace package AMR_TRANSPORT_TASK_LINE_API is

  -- Author  : PRJON
  -- Created : 2/4/2020 9:45:27 PM
  -- Purpose : Info
  
  module_  CONSTANT VARCHAR2(25) := 'AMR';
  lu_name_ CONSTANT VARCHAR2(25) := 'AmrTTLCfp';
  lu_type_ CONSTANT VARCHAR2(25) := 'Entity';
  
  PROCEDURE Create_Date(
   rowkey_     IN     VARCHAR2,
   attr_cf_    IN     VARCHAR2,
   attr_       IN     VARCHAR2,
   action_     IN     VARCHAR2 );

  PROCEDURE Run_Proc(
   rowkey_     IN     VARCHAR2,
   attr_cf_    IN     VARCHAR2,
   attr_       IN     VARCHAR2,
   action_     IN     VARCHAR2 );

  PROCEDURE Submit_Job(
   rowkey_     IN     VARCHAR2,
   attr_cf_    IN     VARCHAR2,
   attr_       IN     VARCHAR2,
   action_     IN     VARCHAR2 );
   
   
end AMR_TRANSPORT_TASK_LINE_API;
/
create or replace package body AMR_TRANSPORT_TASK_LINE_API is

PROCEDURE Create_Date(
   rowkey_     IN     VARCHAR2,
   attr_cf_    IN     VARCHAR2,
   attr_       IN     VARCHAR2,
   action_     IN     VARCHAR2 )
                 IS PRAGMA AUTONOMOUS_TRANSACTION;
  info_        VARCHAR2(2000);
  rowid_       VARCHAR2(2000);
  attr_cfx_    VARCHAR2(2000);  
  count_       NUMBER := 0;
  START_TIME_  DATE := SYSDATE;  
  parms_       VARCHAR2(2000);
  DEADLOCK_    EXCEPTION;
BEGIN
  attr_cfx_  := attr_cf_;
     
  WHILE (count_ = 0) LOOP
   SELECT count(t.objid) INTO count_
    FROM TRANSPORT_TASK_LINE t  
     WHERE objkey = rowkey_;
   IF ((SYSDATE - START_TIME_) > .00012) THEN
        RAISE DEADLOCK_;
   END IF;
     END LOOP;

  SELECT objid  INTO  rowid_  
    FROM TRANSPORT_TASK_LINE  WHERE objkey =  rowkey_;
    
  Airm1app.TRANSPORT_TASK_LINE_CFP.Cf_New__ (info_, rowid_, attr_cfx_, attr_, action_);
            
  COMMIT;
END Create_Date;

PROCEDURE Run_Proc(
   rowkey_     IN     VARCHAR2,
   attr_cf_    IN     VARCHAR2,
   attr_       IN     VARCHAR2,
   action_     IN     VARCHAR2 )
IS PRAGMA AUTONOMOUS_TRANSACTION;
  info_        VARCHAR2(2000);
  rowid_       VARCHAR2(2000);
  attr_cfx_    VARCHAR2(2000);
  count_       NUMBER := 0;
  START_TIME_  DATE := SYSDATE;  
  parms_       VARCHAR2(2000);
  DEADLOCK_    EXCEPTION;
BEGIN

   WHILE (count_ = 0) LOOP
     SELECT count(t.objid) INTO count_
       FROM TRANSPORT_TASK_LINE t  
         WHERE objkey = rowkey_;
       IF ((SYSDATE - START_TIME_) > .00012) THEN
         RAISE DEADLOCK_;
      END IF;
   END LOOP;
   
/*
   CLIENT_SYS.Clear_Attr(parms_);
   CLIENT_SYS.Add_To_Attr('TRANSPORT_LINES', rowkey_,  parms_ );
   CLIENT_SYS.Add_To_Attr('TRANSPORT_LINES', attr_cf_, parms_ );
   CLIENT_SYS.Add_To_Attr('TRANSPORT_LINES', attr_,    parms_ );
   CLIENT_SYS.Add_To_Attr('TRANSPORT_LINES', action_,  parms_ );
   Transaction_SYS.Deferred_Call('Airm1app.AMR_TRANSPORT_TASK_LINE_API.Create_Date', parms_);
*/ 
-- attr_cfx_ := attr_cf_;    
-- Airm1app.TRANSPORT_TASK_LINE_CFP.Cf_New__ (info_, rowid_, attr_cfx_, attr_, action_);
 --Airm1app.TRANSPORT_TASK_LINE_CFP.Cf_Modify__ (info_, rowid_, attr_cfx_, attr_, action_);

 COMMIT;
   EXCEPTION
    WHEN DEADLOCK_ THEN
       DBMS_OUTPUT.PUT_LINE('ERROR');
       ROLLBACK;
END Run_Proc;



PROCEDURE Submit_Job(
   rowkey_     IN     VARCHAR2,
   attr_cf_    IN     VARCHAR2,
   attr_       IN     VARCHAR2,
   action_     IN     VARCHAR2 )
                       IS PRAGMA AUTONOMOUS_TRANSACTION;
 DEADLOCK_            EXCEPTION;
 program_name_        VARCHAR2(300)  := 'TTL_PROG';
 job_name_            VARCHAR2(100)  := 'TTL_Job_02';

BEGIN

  job_name_ := DBMS_SCHEDULER.GENERATE_JOB_NAME ('TTL_');

  DBMS_OUTPUT.PUT_LINE(' ******** START JOB ******** ');

  program_name_:= 'TTL_PROG';
    
  BEGIN
   dbms_scheduler.drop_program(program_name_, TRUE);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('PROGRAM has not been created.'); 
  END;
  
  DBMS_OUTPUT.PUT_LINE(' 1 ');
  DBMS_SCHEDULER.create_program (
    program_name        => program_name_,
    program_type        => 'STORED_PROCEDURE',
    program_action      => 'Airm1app.AMR_TRANSPORT_TASK_LINE_API.Create_Date',
    number_of_arguments => 4,
    enabled             => FALSE,
    comments            => 'Update data');
  DBMS_OUTPUT.PUT_LINE(' 2 ');

  DBMS_SCHEDULER.define_program_argument (
    program_name      => program_name_,
    argument_name     => 'rowkey_',
    argument_position => 1,
    argument_type     => 'VARCHAR2',
    default_value     => rowkey_);
  DBMS_OUTPUT.PUT_LINE(' 3 ');

  DBMS_SCHEDULER.define_program_argument (
    program_name      => program_name_,
    argument_name     => 'attr_cf_',
    argument_position => 2,
    argument_type     => 'VARCHAR2',
    default_value     => attr_cf_);
  DBMS_OUTPUT.PUT_LINE(' 4 ');

  DBMS_SCHEDULER.define_program_argument (
    program_name      => program_name_,
    argument_name     => 'attr_',
    argument_position => 3,
    argument_type     => 'VARCHAR2',
    default_value     => attr_);
  DBMS_OUTPUT.PUT_LINE(' 5 ');

  DBMS_SCHEDULER.define_program_argument (
    program_name      => program_name_,
    argument_name     => 'action_',
    argument_position => 4,
    argument_type     => 'VARCHAR2',
    default_value     => action_);
  DBMS_OUTPUT.PUT_LINE(' 6 ');

  DBMS_SCHEDULER.enable (name => program_name_);

  DBMS_SCHEDULER.create_job (
    job_name        => job_name_,
    program_name    => program_name_,
    start_date      => sysdate,
    auto_drop       => TRUE,
    comments        => 'Job for TRANSPORT TASK LINES');

  DBMS_OUTPUT.PUT_LINE(' ******** RUN JOB ******** ');
 
  dbms_scheduler.run_job(job_name_, use_current_session => FALSE);
  
  DBMS_OUTPUT.PUT_LINE(' ******** COMPLETED JOB ******** ');

  COMMIT;

   EXCEPTION
    WHEN DEADLOCK_ THEN
     DBMS_OUTPUT.PUT_LINE('ERROR1 (Submit_Job)');
     ROLLBACK;

    WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('ERROR2 (Submit_Job): '|| SQLCODE||'..'||SUBSTR(SQLERRM, 1, 300));  
     ROLLBACK;

END Submit_Job;


end AMR_TRANSPORT_TASK_LINE_API;
/
