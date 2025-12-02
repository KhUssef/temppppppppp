class Book{ 
  //Attributes 
  late String name, image; 
  late int price, quantity; 
  Book(this.name, this.price, this.image){ 
    quantity = 10; 
  }
  decr(){
    quantity--;
  }
}

class Data {
  static List<Book> books = [ 
    Book("L'ombre du vent", 25, "assets/image1.png"),
    Book("Le Prof McFADDEN", 15, "assets/image2.png"),
  ];
  static void dec(int index) {
    books[index].decr();
  }
}