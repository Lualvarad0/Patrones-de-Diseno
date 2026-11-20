// Template Method: the base class fixes the overall algorithm's shape
// (read -> process -> save) in one method; subclasses only override the
// one step that actually differs between them.
public abstract class DataProcessor
{
    public void Process() // the "template method": the skeleton never changes
    {
        ReadData();
        ProcessData();
        SaveData();
    }

    protected virtual void ReadData() => Console.WriteLine("Reading raw data...");

    protected abstract void ProcessData(); // the one step each subclass must supply

    protected virtual void SaveData() => Console.WriteLine("Saving results...");
}

public class CsvProcessor : DataProcessor
{
    protected override void ProcessData() => Console.WriteLine("Parsing data as CSV");
}

public class JsonProcessor : DataProcessor
{
    protected override void ProcessData() => Console.WriteLine("Parsing data as JSON");
}

class Program
{
    static void Main()
    {
        DataProcessor processor = new CsvProcessor();
        processor.Process(); // same read/save steps, different parsing step

        Console.WriteLine();

        processor = new JsonProcessor();
        processor.Process();
    }
}
