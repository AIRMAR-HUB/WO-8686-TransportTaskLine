

DECLARE
   rowkey_            VARCHAR2(300)  := 'XYZ';
   attr_cf_           VARCHAR2(300)  := 'XYZ';
   attr_              VARCHAR2(300)  := 'XYZ';
   action_            VARCHAR2(300)  := 'XYZ';
 DEADLOCK_            EXCEPTION;
 program_name_        VARCHAR2(300)  := 'TTL_PROG';
 job_name_            VARCHAR2(100)  := 'TTL_Job_02';

BEGIN

  job_name_ := DBMS_SCHEDULER.GENERATE_JOB_NAME ('TTL_');

  DBMS_OUTPUT.PUT_LINE(' ******** START JOB ******** ');

  program_name_:= 'TTL_PROG';
  dbms_scheduler.drop_program(program_name_, TRUE);
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

END;

/*
SELECT * FROM v$version;

select log_date, job_name, status, run_duration
from dba_scheduler_job_run_details t  
where LOG_DATE > SYSDATE-.5 and job_name like 'T%'
 order by log_date desc
 
job_name='UPDATE_PLAYER_STATES' or status='FAILED';

select sysdate, sysdate-.00015
from dual

begin AMR_TRANSPORT_TASK_LINE_API.Submit_Job('XYZ','XYZ','XYZ','XYZ'); end;
*/
