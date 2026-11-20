// Template Method: a trait with a default method fixes the overall
// algorithm's shape (read -> process -> save); each implementor only
// overrides the one step that actually differs.
trait DataProcessor {
    fn process(&self) {
        // the "template method": the skeleton never changes
        self.read_data();
        self.process_data();
        self.save_data();
    }

    fn read_data(&self) {
        println!("Reading raw data...");
    }

    fn process_data(&self); // the one step each implementor must supply

    fn save_data(&self) {
        println!("Saving results...");
    }
}

struct CsvProcessor;
impl DataProcessor for CsvProcessor {
    fn process_data(&self) {
        println!("Parsing data as CSV");
    }
}

struct JsonProcessor;
impl DataProcessor for JsonProcessor {
    fn process_data(&self) {
        println!("Parsing data as JSON");
    }
}

fn main() {
    CsvProcessor.process(); // same read/save steps, different parsing step
    println!();
    JsonProcessor.process();
}
