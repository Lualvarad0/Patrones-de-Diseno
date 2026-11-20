// Template Method: the base class fixes the overall algorithm's shape
// (read -> process -> save) in one method; subclasses only override the
// one step that actually differs between them.
class DataProcessor {
  process() {
    // the "template method": the skeleton never changes
    this.readData();
    this.processData();
    this.saveData();
  }

  readData() {
    console.log("Reading raw data...");
  }

  processData() {
    throw new Error("Subclasses must implement processData()"); // the one step each subclass must supply
  }

  saveData() {
    console.log("Saving results...");
  }
}

class CsvProcessor extends DataProcessor {
  processData() {
    console.log("Parsing data as CSV");
  }
}

class JsonProcessor extends DataProcessor {
  processData() {
    console.log("Parsing data as JSON");
  }
}

// --- demo ---
new CsvProcessor().process(); // same read/save steps, different parsing step
console.log();
new JsonProcessor().process();
