import 'package:flutter/material.dart';

import 'package:w4s3/widget_basic/counter_widget.dart';
import 'package:w4s3/widget_basic/textfield_widget.dart';
import 'package:w4s3/widget_basic/form_widget.dart';
import 'package:w4s3/pages/produk_list_page.dart';
import 'package:w4s3/widget_basic/dialog_widget.dart';
import 'package:w4s3/pages/main_navigation_page.dart';
import 'package:w4s3/pages/katalog_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PAM Week 4 Sesi 3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MenuPraktikumPage(),
    );
  }
}

class MenuPraktikumPage extends StatelessWidget {
  const MenuPraktikumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modul W4S3 Praktikum'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: ListTile(
              leading: const Icon(Icons.shopping_bag, size: 36),
              title: const Text(
                'Tugas: Mini Aplikasi Katalog Produk',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Studi Kasus Katalog Produk dengan Form, Dialog, Keranjang, & Tab',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KatalogHomePage(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Latihan Modul Bagian 1 - 7:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('1. StatefulWidget & setState (Counter)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CounterWidget(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('2. TextField (Input Teks)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TextFieldWidget(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('3. Form & Validasi'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FormWidget(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.alt_route),
            title: const Text('4. Navigasi Antar Halaman & Kirim Data'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProdukListPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: const Text('5. Dialog & SnackBar'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DialogWidget(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.tab),
            title: const Text('6. BottomNavigationBar (Navigasi Tab)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainNavigationPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
