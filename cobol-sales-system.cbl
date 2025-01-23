       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROG01.
      *****************************************************************
      ***   CIS4373L PROG01 COBOL SOURCE PROGRAM                     **
      ***                                                            **
      ***  AUTHOR:  Adam Burmuzoski                                  **
      ***   INPUT:  1. CONTROL CARD                                  **
      ***  OUTPUT:  1. SALES REPORT                                  **
      ***                                                            **
      *****************************************************************
      ***  MODIFICATION LOG:                                         **
      ***  00.  02/10/2024 Adam Burmuzoski ORIGINAL VERSION         **
      ***  01.  03/16/2024  Adam Burmuzoski - UPDATED VERSION        **
      ***                                                            **
      *****************************************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CUSTOMER-SALES-FILE   ASSIGN TO CUSTSLS.
           SELECT SALES-REPORT-FILE     ASSIGN TO PRINT001.
           
       DATA DIVISION.
       FILE SECTION.
       FD  CUSTOMER-SALES-FILE
           RECORD CONTAINS 60 CHARACTERS.
       01  CUSTOMER-MASTER-RECORD.
           05 BRANCH-NUMBER              PIC 9(02).
           05 SALES-REP-NUMBER           PIC 9(02).
           05 CUSTOMER-NUMBER            PIC 9(05).
           05 CUSTOMER-NAME              PIC X(30).
           05 CURRENT-YTD-SALES          PIC S9(7)V99 COMP-3.
           05 PREVIOUS-YTD-SALES         PIC S9(7)V99 COMP-3.
           05 FILLER                     PIC X(03).
           
       FD  SALES-REPORT-FILE.
       01  SALES-RPT-RECORD              PIC X(132).
           
       WORKING-STORAGE SECTION.
       01  PROGRAM-INDICATORS.
           05 ARE-THERE-MORE-RECORDS   PIC X   VALUE 'Y'.
               88 THERE-ARE-MORE-RECORDS        VALUE 'Y'.
               88 THERE-ARE-NO-MORE-RECORDS     VALUE 'N'.
           
       01  WS-PGM-VARS.
           05  WS-LINE-CTR          PIC 9(02)  VALUE  0.
           05  WS-PAGE-CTR          PIC 9(05)  VALUE  0.
           
       01  WS-TOTALS.
           05  WS-TOTAL-CURRENT-YTD-SALES   PIC S9(9)V99 COMP-3 
           VALUE ZERO.
           05  WS-TOTAL-PREVIOUS-YTD-SALES  PIC S9(9)V99 COMP-3 
           VALUE ZERO.
           
       01  WS-CURRENT-DATE-N-TIME.
           05  WS-CURRENT-DATE.
               10  WS-CURRENT-DATE-CCYY    PIC 9(04)  VALUE 2024.
               10  WS-CURRENT-DATE-MM      PIC 9(02)  VALUE 03.
               10  WS-CURRENT-DATE-DD      PIC 9(02)  VALUE 16.
           05  WS-CURRENT-TIME.
               10  WS-CURRENT-TIME-HH      PIC 9(02)  VALUE 12.
               10  WS-CURRENT-TIME-MM      PIC 9(02)  VALUE 00.
               10  WS-CURRENT-TIME-SS      PIC 9(02)  VALUE 00.
           
       01  WS-RPT-HEADING-L1.
           05  FILLER            PIC X(06)  VALUE 'DATE: '.
           05  WS-RPT-H1-MM      PIC 9(02)  VALUE 03.
           05  FILLER            PIC X(01)  VALUE '/'.
           05  WS-RPT-H1-DD      PIC 9(02)  VALUE 16.
           05  FILLER            PIC X(01)  VALUE '/'.
           05  WS-RPT-H1-CCYY    PIC 9(04)  VALUE 2024.
           05  FILLER            PIC X(01)  VALUE SPACES.
           05  WS-RPT-H1-HR      PIC 9(02).
           05  FILLER            PIC X(01)  VALUE ':'.
           05  WS-RPT-H1-MIN     PIC 9(02).
           05  FILLER            PIC X(01)  VALUE ':'.
           05  WS-RPT-H1-SEC     PIC 9(02).
           05  FILLER            PIC X(20)  VALUE SPACES.
           05  WS-RPT-H1-TITLE   PIC X(30)  
           VALUE 'TXSTATE CIS4373L PROG01 FOR:'.
           05  WS-RPT-H1-MY-NAME PIC X(30)  VALUE 'Adam Burmuzoski'.
           05  FILLER            PIC X(15)  VALUE SPACES.
           05  FILLER            PIC X(06)  VALUE 'PAGE:'.
           05  WS-RPT-H1-PAGE-NR PIC ZZZ9.
           
       01  WS-RPT-HEADING-L2.
           05  FILLER            PIC X(06)  VALUE 'PGM: '.
           05  FILLER            PIC X(08)  VALUE 'PROG01'.
           05  FILLER            PIC X(39)  VALUE SPACES.
           05  WS-RPT-H2-TITLE   PIC X(35)  
           VALUE 'YEAR-TO-DATE SALES REPORT'.
           05  FILLER            PIC X(44)  VALUE SPACES.
           
       01  WS-RPT-DETAIL-LINE.
           05  DETAIL-CUSTOMER-NAME         PIC X(30).
           05  FILLER                       PIC X(4)   VALUE SPACES.
           05  DETAIL-CURRENT-YTD-SALES     PIC $9,999,999.99.
           05  FILLER                       PIC X(4)   VALUE SPACES.
           05  DETAIL-PREVIOUS-YTD-SALES    PIC $9,999,999.99.
           
       01  WS-RPT-TOTAL-LINE.
           05  FILLER                       PIC X(30)  
           VALUE 'TOTAL SALES:'.
           05  FILLER                       PIC X(4)   VALUE SPACES.
           05  TOTAL-CURRENT-YTD-SALES      PIC $9,999,999.99.
           05  FILLER                       PIC X(4)   VALUE SPACES.
           05  TOTAL-PREVIOUS-YTD-SALES     PIC $9,999,999.99.
           
       PROCEDURE DIVISION.
       00000-MAIN-LINE-ROUTINE.
           PERFORM 10000-INITIALIZATION-ROUTINE
           PERFORM 20000-HEADING-ROUTINE
           PERFORM 30000-PROCESS-CUSTOMER-MASTER 
           UNTIL THERE-ARE-NO-MORE-RECORDS
           PERFORM 40000-FINISH-ROUTINE
           STOP RUN.
           
       10000-INITIALIZATION-ROUTINE.
           OPEN INPUT CUSTOMER-SALES-FILE
           OUTPUT SALES-REPORT-FILE
           MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DATE-N-TIME
           MOVE 'Adam Burmuzoski' TO WS-RPT-H1-MY-NAME.
           
       20000-HEADING-ROUTINE.
           WRITE SALES-RPT-RECORD FROM WS-RPT-HEADING-L1 
           AFTER ADVANCING PAGE
           WRITE SALES-RPT-RECORD FROM WS-RPT-HEADING-L2 
           AFTER ADVANCING 1 LINE.
           
       30000-PROCESS-CUSTOMER-MASTER.
           READ CUSTOMER-SALES-FILE INTO CUSTOMER-MASTER-RECORD AT END
               SET THERE-ARE-NO-MORE-RECORDS TO TRUE
           NOT AT END
               PERFORM 31000-PROCESS-RECORD
           END-READ.
           
       31000-PROCESS-RECORD.
           MOVE CUSTOMER-NAME TO DETAIL-CUSTOMER-NAME
           MOVE CURRENT-YTD-SALES TO DETAIL-CURRENT-YTD-SALES
           MOVE PREVIOUS-YTD-SALES TO DETAIL-PREVIOUS-YTD-SALES
           ADD CURRENT-YTD-SALES TO WS-TOTAL-CURRENT-YTD-SALES
           ADD PREVIOUS-YTD-SALES TO WS-TOTAL-PREVIOUS-YTD-SALES
           WRITE SALES-RPT-RECORD FROM WS-RPT-DETAIL-LINE 
           AFTER ADVANCING 1 LINE.
           
       40000-FINISH-ROUTINE.
           MOVE WS-TOTAL-CURRENT-YTD-SALES TO TOTAL-CURRENT-YTD-SALES
           MOVE WS-TOTAL-PREVIOUS-YTD-SALES TO TOTAL-PREVIOUS-YTD-SALES
           WRITE SALES-RPT-RECORD FROM WS-RPT-TOTAL-LINE 
           AFTER ADVANCING 2 LINES
           CLOSE CUSTOMER-SALES-FILE SALES-REPORT-FILE.
       END PROGRAM PROG01.
