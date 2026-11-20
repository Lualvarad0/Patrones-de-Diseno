      *> Template Method in Object-Oriented COBOL (GnuCOBOL).
      *> "data-processor" fixes the algorithm's shape (read -> process
      *> -> save) in one method; "csv-processor"/"json-processor" only
      *> override the one step that differs.
      *> Compile with:  cobc -x -free template_method.cbl -o template_method
       >>SOURCE FORMAT FREE
       identification division.
       class-id. data-processor.

       object.
           procedure division.

      *> the "template method": the skeleton never changes
           method-id. process.
               procedure division.
                   invoke self "read-data"
                   invoke self "process-data"
                   invoke self "save-data"
               end method process.

           method-id. read-data.
               procedure division.
                   display "Reading raw data..."
               end method read-data.

      *> overridden by each subclass — base version does nothing
           method-id. process-data.
               procedure division.
                   continue
               end method process-data.

           method-id. save-data.
               procedure division.
                   display "Saving results..."
               end method save-data.

       end object.
       end class data-processor.

      *> ------------------------------------------------------------------
       identification division.
       class-id. csv-processor inherits data-processor.
       object.
           procedure division.
           method-id. process-data.
               procedure division.
                   display "Parsing data as CSV"
               end method process-data.
       end object.
       end class csv-processor.

      *> ------------------------------------------------------------------
       identification division.
       class-id. json-processor inherits data-processor.
       object.
           procedure division.
           method-id. process-data.
               procedure division.
                   display "Parsing data as JSON"
               end method process-data.
       end object.
       end class json-processor.

      *> ------------------------------------------------------------------
       identification division.
       program-id. main.
       environment division.
       configuration section.
       repository.
           class csv-processor.
           class json-processor.

       data division.
       working-storage section.
       01 processor object reference.

       procedure division.
           invoke csv-processor "new" returning processor
           invoke processor "process"
      *> same read/save steps, different parsing step

           display " "

           invoke json-processor "new" returning processor
           invoke processor "process"

           stop run.
       end program main.
