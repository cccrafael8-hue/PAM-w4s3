import 'package:flutter/material.dart';
import 'package:w4s3/models/product.dart';
import 'package:w4s3/widget_basic/product_card.dart';
import 'package:w4s3/pages/katalog_detail_page.dart';
import 'package:w4s3/pages/tambah_produk_page.dart';
import 'package:w4s3/pages/profil_page.dart';

class KatalogHomePage extends StatefulWidget {
  const KatalogHomePage({super.key});

  @override
  State<KatalogHomePage> createState() => _KatalogHomePageState();
}

class _KatalogHomePageState extends State<KatalogHomePage> {
  int _tabTerpilih = 0;
  int _cartCount = 0;

  final List<Product> _daftarProduk = [
    Product(nama: 'Kursi Minimalis', harga: 350000, icon: Icons.chair),
    Product(nama: 'Meja Kerja Kayu', harga: 750000, icon: Icons.table_restaurant),
    Product(nama: 'Lampu Meja LED', harga: 120000, icon: Icons.light),
    Product(nama: 'Headphone Wireless', harga: 500000, icon: Icons.headphones),
    Product(nama: 'Jam Dinding Digital', harga: 150000, icon: Icons.access_time),
  ];

  void _konfirmasiHapusProduk(int index) {
    final productTarget = _daftarProduk[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Produk?'),
          content: Text('Apakah Anda yakin ingin menghapus "${productTarget.nama}" dari katalog?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _daftarProduk.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Produk "${productTarget.nama}" telah dihapus.')),
                );
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _bukaFormTambahProduk() async {
    final Product? produkBaru = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TambahProdukPage()),
    );

    if (!mounted) return;

    if (produkBaru != null) {
      setState(() {
        _daftarProduk.add(produkBaru);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produk "${produkBaru.nama}" berhasil ditambahkan!')),
      );
    }
  }

  Widget _buildKatalogTab() {
    if (_daftarProduk.isEmpty) {
      return const Center(
        child: Text('Belum ada produk di katalog.', style: TextStyle(fontSize: 16)),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: _daftarProduk.length,
      itemBuilder: (context, index) {
        final product = _daftarProduk[index];
        return ProductCard(
          nama: product.nama,
          harga: product.harga,
          icon: product.icon,
          onTap: () async {
            final bool? ditambahkan = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KatalogDetailPage(product: product),
              ),
            );

            if (!context.mounted) return;

            if (ditambahkan == true) {
              setState(() {
                _cartCount++;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.nama} ditambahkan ke keranjang!')),
              );
            }
          },
          onDelete: () => _konfirmasiHapusProduk(index),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabPages = [
      _buildKatalogTab(),
      const ProfilPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_tabTerpilih == 0 ? 'Katalog Produk' : 'Profil Pengguna'),
        actions: [
          if (_tabTerpilih == 0)
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Total barang di keranjang: $_cartCount')),
                    );
                  },
                ),
                if (_cartCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$_cartCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
      body: tabPages[_tabTerpilih],
      floatingActionButton: _tabTerpilih == 0
          ? FloatingActionButton(
              onPressed: _bukaFormTambahProduk,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabTerpilih,
        onTap: (index) {
          setState(() {
            _tabTerpilih = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}