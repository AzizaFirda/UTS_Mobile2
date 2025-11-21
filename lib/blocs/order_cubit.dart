import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/menu_model.dart';

class OrderState {
  final List<MenuModel> menuItems;
  final List<MenuModel> cartItems;
  final String selectedCategory;

  OrderState({
    required this.menuItems,
    required this.cartItems,
    this.selectedCategory = 'Semua',
  });

  OrderState copyWith({
    List<MenuModel>? menuItems,
    List<MenuModel>? cartItems,
    String? selectedCategory,
  }) {
    return OrderState(
      menuItems: menuItems ?? this.menuItems,
      cartItems: cartItems ?? this.cartItems,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  // Hitung total harga setelah diskon per item
  double get subtotalPrice => cartItems.fold(
      0, (sum, item) => sum + (item.getDiscountedPrice() * item.quantity));

  // Diskon transaksi 10% jika total > 100000
  double get transactionDiscount {
    return subtotalPrice > 100000 ? subtotalPrice * 0.1 : 0;
  }

  // Total harga final setelah semua diskon
  double get totalPrice => subtotalPrice - transactionDiscount;

  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);

  List<String> get categories {
    final cats = menuItems.map((e) => e.category).toSet().toList();
    return ['Semua', ...cats];
  }

  List<MenuModel> get filteredMenu {
    if (selectedCategory == 'Semua') return menuItems;
    return menuItems.where((e) => e.category == selectedCategory).toList();
  }
}

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState(
    menuItems: _initialMenu,
    cartItems: [],
  ));

  static final List<MenuModel> _initialMenu = [
    MenuModel(id: '1', name: 'Nasi Goreng', description: 'Nasi goreng spesial dengan telur dan ayam', price: 25000, category: 'Makanan', imageUrl: '🍛', discount: 0.1),
    MenuModel(id: '2', name: 'Mie Ayam', description: 'Mie ayam dengan pangsit goreng', price: 20000, category: 'Makanan', imageUrl: '🍜', discount: 0),
    MenuModel(id: '3', name: 'Ayam Bakar', description: 'Ayam bakar bumbu kecap', price: 35000, category: 'Makanan', imageUrl: '🍗', discount: 0.15),
    MenuModel(id: '4', name: 'Sate Ayam', description: 'Sate ayam dengan bumbu kacang', price: 30000, category: 'Makanan', imageUrl: '🍢', discount: 0.05),
    MenuModel(id: '5', name: 'Es Teh Manis', description: 'Teh manis dingin segar', price: 5000, category: 'Minuman', imageUrl: '🧋', discount: 0),
    MenuModel(id: '6', name: 'Es Jeruk', description: 'Jeruk peras segar dengan es', price: 8000, category: 'Minuman', imageUrl: '🍊', discount: 0),
    MenuModel(id: '7', name: 'Kopi Susu', description: 'Kopi susu gula aren', price: 15000, category: 'Minuman', imageUrl: '☕', discount: 0.2),
    MenuModel(id: '8', name: 'Jus Alpukat', description: 'Jus alpukat segar dengan susu', price: 18000, category: 'Minuman', imageUrl: '🥤', discount: 0.1),
    MenuModel(id: '9', name: 'Kerupuk', description: 'Kerupuk udang renyah', price: 3000, category: 'Snack', imageUrl: '😋', discount: 0),
    MenuModel(id: '10', name: 'Pisang Goreng', description: 'Pisang goreng crispy', price: 10000, category: 'Snack', imageUrl: '🌽', discount: 0),
  ];

  // Tambah item ke keranjang
  void addToOrder(MenuModel item) {
    final cartItems = List<MenuModel>.from(state.cartItems);
    final index = cartItems.indexWhere((e) => e.id == item.id);
    
    if (index >= 0) {
      cartItems[index] = cartItems[index].copyWith(
        quantity: cartItems[index].quantity + 1,
      );
    } else {
      cartItems.add(item.copyWith(quantity: 1));
    }
    emit(state.copyWith(cartItems: cartItems));
  }

  // Kurangi atau hapus item dari keranjang
  void removeFromOrder(MenuModel item) {
    final cartItems = List<MenuModel>.from(state.cartItems);
    final index = cartItems.indexWhere((e) => e.id == item.id);
    
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index] = cartItems[index].copyWith(
          quantity: cartItems[index].quantity - 1,
        );
      } else {
        cartItems.removeAt(index);
      }
      emit(state.copyWith(cartItems: cartItems));
    }
  }

  // Update quantity langsung
  void updateQuantity(MenuModel item, int qty) {
    final cartItems = List<MenuModel>.from(state.cartItems);
    final index = cartItems.indexWhere((e) => e.id == item.id);
    
    if (qty <= 0 && index >= 0) {
      cartItems.removeAt(index);
    } else if (index >= 0) {
      cartItems[index] = cartItems[index].copyWith(quantity: qty);
    } else if (qty > 0) {
      cartItems.add(item.copyWith(quantity: qty));
    }
    
    emit(state.copyWith(cartItems: cartItems));
  }

  // Hitung total harga setelah diskon
  double getTotalPrice() {
    return state.totalPrice;
  }

  // Hapus semua pesanan
  void clearOrder() {
    emit(state.copyWith(cartItems: []));
  }

  void setCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
  }

  int getItemQuantity(String id) {
    final item = state.cartItems.where((e) => e.id == id).firstOrNull;
    return item?.quantity ?? 0;
  }

  // Alias untuk kompatibilitas dengan kode lama
  void addToCart(MenuModel item) => addToOrder(item);
  void removeFromCart(MenuModel item) => removeFromOrder(item);
  void clearCart() => clearOrder();
}