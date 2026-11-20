// Template Method: the base class fixes the overall algorithm's shape
// (read -> process -> save) in one method; subclasses only override the
// one step that actually differs between them.
#include <iostream>

class DataProcessor {
public:
    void process() const { // the "template method": the skeleton never changes
        readData();
        processData();
        saveData();
    }

    virtual ~DataProcessor() = default;

protected:
    virtual void readData() const { std::cout << "Reading raw data..." << std::endl; }

    virtual void processData() const = 0; // the one step each subclass must supply

    virtual void saveData() const { std::cout << "Saving results..." << std::endl; }
};

class CsvProcessor : public DataProcessor {
protected:
    void processData() const override { std::cout << "Parsing data as CSV" << std::endl; }
};

class JsonProcessor : public DataProcessor {
protected:
    void processData() const override { std::cout << "Parsing data as JSON" << std::endl; }
};

int main() {
    CsvProcessor csv;
    csv.process(); // same read/save steps, different parsing step

    std::cout << std::endl;

    JsonProcessor json;
    json.process();

    return 0;
}
