       identification division.

       program-id. calc2000.
      ******************************************************************
      * Title..........: CALC2000 - Future Value Calculator
      * Programmer.....: Ben Stearns
      * Date...........: 1-28-26
      * GitHub URL.....: https://github.com/bstearns07/CALC2000
      * Program Desc...: Calculates future value of an investment
      * File Desc......: Define the sole source code for app
      ******************************************************************
       environment division.

       input-output section.

       data division.

       file section.

       working-storage section.

       01  user-entries.

           05  number-entered              pic 9        value 1.
           05  investment-amount           pic 99999    value 1000.
           05  number-of-years             pic 99       value 10.
           05  yearly-interest-rate        pic 99v9     value 5.5.

       01  work-fields.
           05  future-value                pic 9(7)v99.
           05  year-counter                pic 999.
      *     05  edited-whole-value          pic zz,zzz,zz9.
      *     05  edited-decimal-value        pic zzz,zzz.99.

      * Define procedures to displaying formatted report lines
      * Got idea online as I couldn't find alignment info in book
       01  display-line-whole.
      *    Define a label that spans a fixed 24 characters in length
           05  label-part-whole   pic X(24).
      *    Define a filler for the equal sign     
           05  filler-sign        pic X(4)            value "=".
      *    Use remaining portion of the line used for the value
           05  value-part-whole   pic Z,ZZZ,ZZ9.

       01  display-line-decimal.
           05  label-part-dec     pic X(24).
           05  filler-sign        pic X              value "=".
           05  value-part-dec     pic Z,ZZZ,ZZ9.99.


       procedure division.
      * Procedure the performs future value calculations 3 times
       000-calculate-future-values.
           DISPLAY "Calculating Future Values".
           perform 100-calculate-future-value
           COMPUTE investment-amount = investment-amount * 2.
           PERFORM 100-calculate-future-value
           COMPUTE investment-amount = investment-amount * 2.
           PERFORM 100-calculate-future-value
           display "End of session.".
           stop run.

      * Procedure to begin calulations until number of years is reached
       100-calculate-future-value.

           move investment-amount to future-value
           move 1 to year-counter
           perform 120-calculate-next-fv
               until year-counter > number-of-years
           PERFORM 140-display-values.

      * Procedure calculating future value for current investment amount
       120-calculate-next-fv.

           compute future-value rounded =
               future-value +
                   (future-value * yearly-interest-rate / 100).
           add 1 to year-counter.

      * Procedure to display formatted results with proper alignment
       140-display-values.

           DISPLAY "-------------------------------------".

      *    MOVE label text and value to display line structures
      *    Then DISPLAY the line structure for proper alignment
           MOVE "Investment Amount" TO label-part-whole
           MOVE investment-amount   TO value-part-whole
           DISPLAY display-line-whole

           MOVE "Number of Years" TO label-part-whole
           MOVE number-of-years    TO value-part-whole
           DISPLAY display-line-whole

           MOVE "Yearly Interest Rate" TO label-part-dec
           MOVE yearly-interest-rate    TO value-part-dec
           DISPLAY display-line-decimal

           MOVE "Future Value" TO label-part-dec
           MOVE future-value    TO value-part-dec
           DISPLAY display-line-decimal.
           DISPLAY "".
