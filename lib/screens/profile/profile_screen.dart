import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  //Carrega os dados do usuário do Firestore
  Future<void> _loadUserData() async {
    if (user == null) return;

    final docRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);

    try {
      //tenta pegar do servidor
      final snap = await docRef.get(const GetOptions(source: Source.server));

      if (snap.exists && snap.data() != null) {
        setState(() => userData = snap.data());
        return;
      }
    } on FirebaseException catch (e) {
      final offline =
          e.code == 'unavailable' || (e.message?.contains('offline') ?? false);

      if (offline) {
        //tenta cache offline
        try {
          final snap = await docRef.get(const GetOptions(source: Source.cache));

          if (snap.exists && snap.data() != null) {
            setState(() => userData = snap.data());
            return;
          }
        } catch (_) {}
      }
    }

    //fallback final (usa dados do FirebaseAuth)
    setState(() => userData = {
          'name': user!.displayName ?? 'Usuário',
          'email': user!.email ?? '',
        });
  }

  //Faz logout e volta para a tela de login
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Nenhum usuário logado')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        backgroundColor: Colors.orange,
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.orange.shade100,
                      backgroundImage: userData!['photoUrl'] != null
                          ? NetworkImage(userData!['photoUrl'])
                          : null,
                      child: userData!['photoUrl'] == null
                          ? const Icon(Icons.person,
                              size: 60, color: Colors.orange)
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userData!['name'] ?? '',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userData!['email'] ?? '',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _logout,
                      icon: const Icon(Icons.logout),
                      label: const Text('Sair da conta'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
