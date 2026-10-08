class TourismPlace {
  String name;
  String location;
  String description;
  int price;
  String imageUrl;

  TourismPlace({
    required this.name,
    required this.location,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

var tourismPlaceList = [
  TourismPlace(
    name: 'Pantai Kuta',
    location: 'Bali',
    description: 'Pantai Kuta adalah sebuah tempat pariwisata yang terletak di kecamatan Kuta, sebelah selatan Kota Denpasar, Bali, Indonesia. Daerah ini merupakan sebuah tujuan wisata turis mancanegara dan telah menjadi objek wisata andalan Pulau Bali sejak awal tahun 1970-an.',
    price: 50000,
    imageUrl: 'https://images.unsplash.com/photo-1537956965359-7573183d1f57?auto=format&fit=crop&w=800&q=80',
  ),
  TourismPlace(
    name: 'Candi Borobudur',
    location: 'Jawa Tengah',
    description: 'Borobudur adalah sebuah candi Buddha yang terletak di Borobudur, Magelang, Jawa Tengah, Indonesia. Candi ini didirikan oleh para penganut agama Buddha Mahayana sekitar tahun 800-an Masehi pada masa pemerintahan wangsa Syailendra.',
    price: 75000,
    imageUrl: 'https://images.unsplash.com/photo-1596402184320-417e7178b2cd?auto=format&fit=crop&w=800&q=80',
  ),
  TourismPlace(
    name: 'Raja Ampat',
    location: 'Papua',
    description: 'Kepulauan Raja Ampat merupakan rangkaian empat gugusan pulau yang berdekatan dan berlokasi di barat bagian Kepala Burung Pulau Papua. Empat gugusan pulau yang menjadi anggotanya dinamakan menurut empat pulau terbesarnya.',
    price: 250000,
    imageUrl: 'https://images.unsplash.com/photo-1516690561799-46d8f74f9abf?auto=format&fit=crop&w=800&q=80',
  ),
  TourismPlace(
    name: 'Gunung Bromo',
    location: 'Jawa Timur',
    description: 'Gunung Bromo adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia. Gunung ini memiliki ketinggian 2.329 meter di atas permukaan laut dan menawarkan pemandangan matahari terbit yang sangat memukau.',
    price: 35000,
    // URL Gambar di bawah ini sudah diperbarui agar tidak error 404
    imageUrl: 'https://images.unsplash.com/photo-1588668214407-6ea9a6d8c272?auto=format&fit=crop&w=800&q=80',
  ),
];