import java.util.ArrayList;
import java.util.List;

// Iterator: exposes a way to walk through a collection's elements one by
// one (hasNext/next) without exposing whether it's backed by an array,
// a list, or anything else. Java's own `Iterator` interface (used by
// `for-each`) already does this — this example builds the mechanism by
// hand to show what's actually happening underneath.
class BookCollection {
    private final List<String> books = new ArrayList<>();

    void add(String title) { books.add(title); }

    BookIterator createIterator() { return new BookIterator(books); }
}

class BookIterator {
    private final List<String> books;
    private int position = 0;

    BookIterator(List<String> books) { this.books = books; }

    boolean hasNext() { return position < books.size(); }

    String next() { return books.get(position++); }
}

public class IteratorDemo {
    public static void main(String[] args) {
        BookCollection collection = new BookCollection();
        collection.add("Clean Code");
        collection.add("The Pragmatic Programmer");
        collection.add("Design Patterns");

        BookIterator iterator = collection.createIterator();
        while (iterator.hasNext()) {
            System.out.println(iterator.next());
        }
    }
}
