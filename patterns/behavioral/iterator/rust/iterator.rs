// Iterator: exposes a way to walk through a collection's elements one by
// one without exposing whether it's backed by a Vec, a linked list, or
// anything else. Rust has this pattern built into the language via the
// `Iterator` trait (`next() -> Option<T>`) — implementing it is exactly
// what lets `BookIterator` be used in a plain `for` loop below.
struct BookCollection {
    books: Vec<String>,
}

impl BookCollection {
    fn new() -> Self {
        BookCollection { books: Vec::new() }
    }

    fn add(&mut self, title: &str) {
        self.books.push(title.to_string());
    }

    fn create_iterator(&self) -> BookIterator {
        BookIterator { books: &self.books, position: 0 }
    }
}

struct BookIterator<'a> {
    books: &'a [String],
    position: usize,
}

impl<'a> Iterator for BookIterator<'a> {
    type Item = &'a String;

    fn next(&mut self) -> Option<Self::Item> {
        if self.position < self.books.len() {
            let book = &self.books[self.position];
            self.position += 1;
            Some(book)
        } else {
            None
        }
    }
}

fn main() {
    let mut collection = BookCollection::new();
    collection.add("Clean Code");
    collection.add("The Pragmatic Programmer");
    collection.add("Design Patterns");

    for book in collection.create_iterator() {
        println!("{book}");
    }
}
