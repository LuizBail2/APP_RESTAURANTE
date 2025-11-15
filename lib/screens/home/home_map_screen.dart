import 'package:flutter/material.dart';
import 'restaurant_detail_screen.dart';
import '../../models/restaurant.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeMapScreen extends StatefulWidget {
  const HomeMapScreen({super.key});

  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchCity = '';

  //Lista de restaurantes
  final List<Restaurant> allRestaurants = [
    Restaurant(
      id: '1',
      name: 'A Casa do Porco',
      address: 'Rua Araújo, 124 - República, São Paulo',
      city: 'São Paulo',
      citySearch: 'sao paulo',
      rating: 4.4,

      //Cardapio e hr
      menu: [
        MenuItem(name: 'Pão de Tapioca com Linguiça Caipira'),
        MenuItem(name: 'Churrasco de Porco Caipira'),
        MenuItem(name: 'Creme de Mamão com Caramelo'),
      ],
      openingHours: '12:00',
      closingHours: '23:00',
      weekendOpening: '12:00',
      weekendClosing: '17:00',
    ),
    Restaurant(
      id: '2',
      name: 'Maní',
      address: 'Rua Joaquim Antunes, 210 - Pinheiros, São Paulo',
      city: 'São Paulo',
      citySearch: 'sao paulo',
      rating: 4.6,
      menu: [
        MenuItem(name: ' Arroz de Pato'),
        MenuItem(name: 'Pralinê com sorvete de coco'),
        MenuItem(name: 'Pupunha de Caramelo'),
      ],
      openingHours: '12:00',
      closingHours: '23:00',
      weekendOpening: '13:00',
      weekendClosing: '23:00',
    ),
    Restaurant(
      id: '3',
      name: 'D.O.M',
      address: 'Rua Barão de Capanema, 549 - Jardins, São Paulo',
      city: 'São Paulo',
      citySearch: 'sao paulo',
      rating: 4.6,
      menu: [
        MenuItem(name: 'Palmito pupunha assado com cogumelos e tucupi'),
        MenuItem(
            name: 'Pirarucu com purê de mandioca e molho de castanha-do-pará'),
        MenuItem(
            name:
                'Sorvete de açaí com crocante de tapioca e mel de abelha nativa'),
      ],
      openingHours: '12:00',
      closingHours: '20:30',
      weekendOpening: '19:00',
      weekendClosing: '20:30',
    ),
    Restaurant(
      id: '4',
      name: 'The Ox Room Steakhouse',
      address: 'Alameda Dom Pedro II, 390 - Batel, Curitiba',
      city: 'Curitiba',
      citySearch: 'curitiba',
      rating: 4.7,
      menu: [
        MenuItem(name: 'Golden Ball'),
        MenuItem(name: 'Tomahawk Steak'),
        MenuItem(name: 'Cheesecake de Frutas Vermelhas'),
      ],
      openingHours: '11:30',
      closingHours: '22:30',
      weekendOpening: '11:30',
      weekendClosing: '21:30',
    ),
    Restaurant(
      id: '5',
      name: 'Afonso’s',
      address:
          'Rua Professor Pedro Viriato Parigot de Souza, 529 - Campina do Siqueira, Curitiba',
      city: 'Curitiba',
      citySearch: 'curitiba',
      rating: 4.9,
      menu: [
        MenuItem(
          name: 'Alheira com Ovos',
        ),
        MenuItem(name: 'Bacalhau com Natas'),
        MenuItem(name: 'Pastel de Nata'),
      ],
      openingHours: '11:00',
      closingHours: '22:00',
      weekendOpening: '11:00',
      weekendClosing: '15:00',
    ),
    Restaurant(
      id: '6',
      name: 'Marcondes Cozinha Autoral',
      address: 'R. Recife, 220 - Cabral, Curitiba',
      city: 'Curitiba',
      citySearch: 'curitiba',
      rating: 5.0,
      menu: [
        MenuItem(name: 'Polvo Grelhado'),
        MenuItem(name: 'Ossobuco com risoto de açafrão'),
        MenuItem(name: 'Pudim com caramelo salgado'),
      ],
      openingHours: '18:30',
      closingHours: '23:00',
      weekendOpening: '12:00',
      weekendClosing: '23:00',
    ),
    Restaurant(
      id: '7',
      name: 'Dom Henrique Gastronomia',
      address: 'Rua Vicente Machado, 1368 - Centro, Guarapuava',
      city: 'Guarapuava',
      citySearch: 'guarapuava',
      rating: 4.8,
      menu: [
        MenuItem(name: 'Bruschettas artesanais'),
        MenuItem(name: 'Risoto com Pinhão'),
        MenuItem(name: 'Brownie com sorvete'),
      ],
      openingHours: '11:00',
      closingHours: '23:00',
      weekendOpening: '11:00',
      weekendClosing: '23:00',
    ),
    Restaurant(
      id: '8',
      name: 'Restaurante Canjão',
      address: 'Rua Doutor Laranjeiras, 841 - Centro, Guarapuava',
      city: 'Guarapuava',
      citySearch: 'guarapuava',
      rating: 4.9,
      menu: [
        MenuItem(name: 'Porções de Pão de Alho'),
        MenuItem(name: 'Feijoada'),
        MenuItem(name: 'Pudim de Leite'),
      ],
      openingHours: '08:00',
      closingHours: '22:00',
      weekendOpening: '08:00',
      weekendClosing: '14:30',
    ),
    Restaurant(
      id: '9',
      name: 'Restaurante Casa Vecchia',
      address: 'Rua Vicente Machado, 1289 - Centro, Guarapuava',
      city: 'Guarapuava',
      citySearch: 'guarapuava',
      rating: 4.7,
      menu: [
        MenuItem(name: 'Porções de Pão de Alho'),
        MenuItem(name: 'Feijoada'),
        MenuItem(name: 'Pudim de Leite'),
      ],
      openingHours: '11:30',
      closingHours: '14:00',
      weekendOpening: '11:00',
      weekendClosing: '14:00',
    ),
  ];

  String removeAccents(String str) {
    const withAccents = 'áàãâäéèêëíìîïóòõôöúùûüç';
    const withoutAccents = 'aaaaaeeeeiiiiooooouuuuc';
    for (int i = 0; i < withAccents.length; i++) {
      str = str.replaceAll(withAccents[i], withoutAccents[i]);
      str = str.replaceAll(
          withAccents[i].toUpperCase(), withoutAccents[i].toUpperCase());
    }
    return str;
  }

  //Menu Lateral
  Drawer _buildDrawer(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.orange),
            accountName: Text(user?.displayName ?? 'Usuário'),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
              child: user?.photoURL == null
                  ? const Icon(Icons.person, size: 40, color: Colors.orange)
                  : null,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Início'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sair', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredRestaurants = allRestaurants.where((restaurant) {
      if (searchCity.isEmpty) return true;
      return restaurant.citySearch.contains(searchCity);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("🍽 Busca de Restaurantes"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          //campo de pesquisa
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Digite o nome da cidade...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => searchCity = '');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) {
                final normalized = removeAccents(value.trim().toLowerCase());
                setState(() => searchCity = normalized);
              },
            ),
          ),

          // 🏙 Lista de restaurantes
          Expanded(
            child: filteredRestaurants.isEmpty
                ? const Center(
                    child: Text("Nenhum restaurante encontrado"),
                  )
                : ListView.builder(
                    itemCount: filteredRestaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = filteredRestaurants[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.restaurant,
                              size: 40, color: Colors.orange),
                          title: Text(
                            restaurant.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${restaurant.address}\n ${restaurant.rating.toString()}",
                          ),
                          isThreeLine: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RestaurantDetailScreen(
                                  name: restaurant.name,
                                  address: restaurant.address,
                                  rating: restaurant.rating,
                                  menu: restaurant.menu,
                                  openingHours: restaurant.openingHours,
                                  closingHours: restaurant.closingHours,
                                  weekendOpening: restaurant.weekendOpening,
                                  weekendClosing: restaurant.weekendClosing,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
