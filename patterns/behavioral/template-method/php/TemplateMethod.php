<?php
// Template Method: the base class fixes the overall algorithm's shape
// (read -> process -> save) in one method; subclasses only override the
// one step that actually differs between them.
abstract class DataProcessor
{
    public final function process(): void // the "template method": the skeleton never changes
    {
        $this->readData();
        $this->processData();
        $this->saveData();
    }

    protected function readData(): void
    {
        echo "Reading raw data...\n";
    }

    abstract protected function processData(): void; // the one step each subclass must supply

    protected function saveData(): void
    {
        echo "Saving results...\n";
    }
}

class CsvProcessor extends DataProcessor
{
    protected function processData(): void { echo "Parsing data as CSV\n"; }
}

class JsonProcessor extends DataProcessor
{
    protected function processData(): void { echo "Parsing data as JSON\n"; }
}

// --- demo ---
(new CsvProcessor())->process(); // same read/save steps, different parsing step
echo "\n";
(new JsonProcessor())->process();
