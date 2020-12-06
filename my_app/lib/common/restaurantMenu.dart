class RestaurantMenu {
  String name;
  String price;

  RestaurantMenu({
    this.name,
    this.price,
  });
}

//for restaurant
List<RestaurantMenu> restaurantFoodMenuList = [
  RestaurantMenu(name: "Cozido à Portuguesa", price: "10.00€"),
  RestaurantMenu(name: "Sardinhas Enlatadas", price: "11.00€"),
  RestaurantMenu(name: "Bacalhau à Gomes de Sá", price: "14.00€"),
];

List<RestaurantMenu> restaurantDrinksMenuList = [
  RestaurantMenu(name: "Coca Cola", price: "2.00€"),
  RestaurantMenu(name: "Ice Tea", price: "2.00€"),
  RestaurantMenu(name: "Água Mineral", price: "1.50€"),
];
//for cafe
List<RestaurantMenu> cafeFoodMenuList = [
  RestaurantMenu(name: "Hamburger de Queijo", price: "5.00€"),
  RestaurantMenu(name: "Hamburger Especial", price: "8.00€"),
  RestaurantMenu(name: "Bolo Mel", price: "7.00€/fatia"),
];

List<RestaurantMenu> cafeDrinksMenuList = [
  RestaurantMenu(name: "Sumol", price: "2.00€"),
  RestaurantMenu(name: "Chá Verde", price: "3.50€"),
  RestaurantMenu(name: "Choclate Quente", price: "4.60€"),
];
