// Composite: files (leaves) and folders (containers) implement the same
// interface, so the client can call getSize() on either one without
// asking "is this a leaf or a folder?" first.
class FileItem {
  constructor(name, size) {
    this.name = name;
    this.size = size;
  }

  getSize() {
    return this.size;
  }

  print(indent = "") {
    console.log(`${indent}${this.name} (${this.size}KB)`);
  }
}

class Folder {
  constructor(name) {
    this.name = name;
    this.children = [];
  }

  add(item) {
    this.children.push(item);
  }

  // Delegates to each child and sums the results — doesn't matter if a
  // child is a FileItem or another Folder, the recursion just happens.
  getSize() {
    return this.children.reduce((total, child) => total + child.getSize(), 0);
  }

  print(indent = "") {
    console.log(`${indent}${this.name}/ (${this.getSize()}KB)`);
    for (const child of this.children) {
      child.print(indent + "  ");
    }
  }
}

// --- demo ---
const root = new Folder("project");
root.add(new FileItem("README.md", 2));

const src = new Folder("src");
src.add(new FileItem("index.js", 5));
src.add(new FileItem("utils.js", 3));
root.add(src);

root.print(); // the client only ever calls print()/getSize(), leaf or folder
