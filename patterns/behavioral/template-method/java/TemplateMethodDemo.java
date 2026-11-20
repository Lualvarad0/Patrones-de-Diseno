// Template Method: the base class fixes the overall algorithm's shape
// (read -> process -> save) in one method; subclasses only override the
// one step that actually differs between them.
abstract class DataProcessor {
    final void process() { // the "template method": the skeleton never changes
        readData();
        processData();
        saveData();
    }

    void readData() { System.out.println("Reading raw data..."); }

    abstract void processData(); // the one step each subclass must supply

    void saveData() { System.out.println("Saving results..."); }
}

class CsvProcessor extends DataProcessor {
    void processData() { System.out.println("Parsing data as CSV"); }
}

class JsonProcessor extends DataProcessor {
    void processData() { System.out.println("Parsing data as JSON"); }
}

public class TemplateMethodDemo {
    public static void main(String[] args) {
        DataProcessor processor = new CsvProcessor();
        processor.process(); // same read/save steps, different parsing step

        System.out.println();

        processor = new JsonProcessor();
        processor.process();
    }
}
