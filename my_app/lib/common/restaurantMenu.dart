class RestaurantMenu {
  String name;
  String price;

  RestaurantMenu({
    this.name,
    this.price,
  });
}

List<RestaurantMenu> restaurantMenuList = [
  RestaurantMenu(name: "Coca Cola", price: "1€"),
  RestaurantMenu(name: "Sardinhas", price: "11€"),
  RestaurantMenu(name: "Bolo", price: "10€"),
];
