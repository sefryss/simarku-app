//Book Models
class Book {
  final String title;
  final String thumbnail;
  final String genre;
  final String page;
  final String author;
  final String publisher;
  final String releaseDate;
  final String synopsis;
  final String owner;

  Book({
    required this.title,
    required this.thumbnail,
    required this.genre,
    required this.page,
    required this.author,
    required this.publisher,
    required this.releaseDate,
    required this.synopsis,
    required this.owner,
  });
}

var bookList = [
  Book(
      title: 'Selamat Tinggal',
      owner: 'Sefry Syahrudin',
      thumbnail: 'assets/images/selamat_tinggal.jpeg',
      page: '503',
      genre: 'Fiksi',
      author: 'Tere Liye',
      publisher: 'Tere Liye',
      releaseDate: 'Mei 07, 2020',
      synopsis:
          'Selamat Tinggal, Tidak ada sinopsis. Anggap saja surprise saat membacanya. Buku sebaiknya tidak dibaca oleh: 1. Kalian yang sedang patah hati, 2. Kalian yang cinta pertamanya ambyar, 3. Kalian yang tertipu kepalsuan.'),
  Book(
    title: 'Wingit',
    owner: 'Dimas Rahmamukti',
    thumbnail: 'assets/images/wingit.jpg',
    page: '251',
    genre: 'Horor',
    author: 'Sara Wijiyanto',
    publisher: 'Elex Media Komputindo',
    releaseDate: 'Jul 14, 2021',
    synopsis:
        'Penelusuran sebuah kompleks perumahan tua terbengkalai di daerah Jakarta Timur malam itu awalnya berjalan menyenangkan. Sebelum masuk ke area kompleks, saya bersama Wisnu, Fadi, dan Demian membuka vlog dengan gimmick seru untuk mencairkan suasana. Namun, saat tiba di sebuah lokasi rumah tingkat yang dikelilingi pepohonan dan semak, saya melihat semakin banyak makhluk tak kasatmata yang membuat saya terkejut. Tidak jauh dari situ, saya merasakan kehadiran sesosok hantu yang ingin berkomunikasi dengan saya. Hantu tersebut ternyata berwujud seorang anak kecil laki-laki. Fadi mengambil alih penelusuran saat makhluk tersebut berkomunikasi dengan saya. Selanjutnya, kami menyebut hantu anak kecil tersebut dengan nama Adik. Ia memiliki kebiasaan mengangkat kaki kanannya lalu menggesekkan tulang kering kaki kanannya ke betis kaki kiri seperti merasakan gatal. Ternyata, Adik tidak sendirian. Ia bersama dengan seorang kuntilanak yang ia panggil Tante. Adik bahkan menunjukkan di mana lokasi Tante berada, tepatnya di sebuah pohon. Inilah penelusuran kisah Adik dan Tante Kun....',
  ),
  Book(
    title: 'Gadis Kretek',
    owner: 'Bagas Gumelar',
    thumbnail: 'assets/images/gadis_kretek.jpeg',
    page: '274',
    genre: 'Novel Sejarah',
    author: 'Ratih Kumala',
    publisher: 'Gramedia Pustaka Utama',
    releaseDate: '2012',
    synopsis:
        'Soeraja yang sedang sakit keras sedang mengalami sekarat. Namun ada satu nama yang seringkali disebutnya, yaitu Jeng Yah. Nama ini membuat ketiga anaknya, Tegar, Karim, dan Lebas mengaduk-ngaduk kota di Jawa Tengah untuk mencari sosok Jeng Yah dan berusaha mempertemukan mereka. Anak-anak Soeraja benar-benar terkejut, selama pencarian berlangsung mereka semakin mengetahui sejarah berdirinya Pabrik Kretek Djagad Raja, milik ayah mereka (Penggabungan dari Soedjagad dan Soeraja yang adalah singkatan dari nama kakek dan ayah mereka yang diabadikan menjadi pabrik rokok). Kisah pencarian mereka membawa kembali pada masa muda Soejagad dan Idroes Moeria, seorang rival sejak awal memulai karir mereka mendalami rokok kretek. Mereka merupakan pekerja di perusahaan rokok klobot milik Trisno. Penjajahan Jepang akhinya membuat bisnis Trisno bangkrut. Trisno menjual semua sisa harta dan bisnisnya. Idroes Moeria melihat peluang emas lalu membeli sisa tembakau Trisno dengan harga murah. Dengan sedikit pengetahuan selama mengikuti Trisno, Idroes memulai bisnis dengan menjual rokok klobot. Soejagad iri dengan keberhasilan Idroes. Dia juga mendirikan usaha rokok klobot sendiri. Sejak itulah mereka saling bersaing menjadi yang terbaik. Persaingan semakin memuncak ketika Soedjagad gagal melamar Roemaisa gara-gara dia tidak dapat membaca. Di lain pihak, Idroes berhasil mempersunting Roemaisa.',
  ),
  Book(
    title: 'Perempuan yang Menangis kepada Bulan Hitam',
    owner: 'Faris Oldie',
    thumbnail: 'assets/images/perempuan.jpg',
    page: '300',
    genre: 'Fiksi',
    author: 'Dian Purnomo',
    publisher: 'Gramedia Pustaka Utama',
    releaseDate: 'Nov 01, 2020',
    synopsis:
        'Magi Diela diculik dan dijinakkan seperti binatang. Sirna sudah impiannya membangun Sumba. Kini dia harus melawan orangtua, seisi kampung, dan adat yang ingin merenggut kemerdekaannya sebagai perempuan. Ketika budaya memenjarakan hati Magi yang meronta, dia harus memilih sendiri nerakanya: meninggalkan orangtua dan tanah kelahirannya, menyerahkan diri kepada si mata keranjang, atau mencurangi kematiannya sendiri. Perempuan yang Menangis kepada Bulan Hitam ditulis berdasarkan pengalaman banyak perempuan korban kawin tangkap di Sumba. Tradisi kawin tangkap menggedor hati Dian Purnomo untuk menyuarakan jerit perempuan yang seolah tak terdengar bahkan oleh Tuhan sekalipun.',
  ),
  Book(
    title: 'Pengabdi Netijen',
    owner: 'Salsabila Fatmasari',
    thumbnail: 'assets/images/pengabdi_netijen.jpg',
    page: '188',
    genre: 'Romantis, Komedi',
    author: 'Geraldy Tan',
    publisher: 'Gagas Media',
    releaseDate: 'Jun 14, 2018',
    synopsis:
        'Dulu pas SD, tampilan gue tuh berkacamata putih, rambut gaya batok kelapa, poni belah tengah dan badan sekurus tiang listrik. Ketagihan main gameboy bikin gue betah di kamar aja dan nggak punya skill bersosialisasi. Makanya, teman gue hanya beberapa ekor. Nah, pas SMP, gue sempat minder banget. Saat cowok-cowok lain udah mulai berbulu, badannya gede-gede, punya kumis tipis yang melambai-lambai saat tertiup angin dari lubang hidung ketika mereka bernapas, pertumbuhan gue malah terhambat. Yang paling mengerikan, gue nggak berbulu. Lantas gue nekat pake minyak Firdaus punya bokap. Waktu mau mandi pagi, gue taruh minyaknya di ketek. Kelar mandi gue oles-olesin minyak Firdaus ke berbagai area di badan, lalu pake baju seragam sekolah. Lantas, apakah tumbuh bulu? Boro-Boro!!! Berbulu kagak, ketek gue malah jadi licin banget kayak arena ice skating. Pengabdi Netijen menceritakan pengalaman Geraldy Tan, seorang cowok yang tadinya bukan siapa-apa, tapi karena keinginan dan impian yang kuat, bisa meraih hal-hal yang tidak pernah dia bayangkan. Bahkan, kini ia dikenal banyak orang. Lewat video receh, Gerry sekarang punya banyak teman, juga banyak endorse-an.',
  ),
  Book(
    title: 'Mustika Zakar Celeng',
    owner: 'Amelia Stefani',
    thumbnail: 'assets/images/mustika_zakar_celeng.jpg',
    page: '232',
    genre: 'Fiksi Sastra',
    author: 'Adia Puja',
    publisher: 'Gramedia Pustaka Utama',
    releaseDate: 'Mei 30, 2023',
    synopsis:
        'Tidak bisakah kau bertahan sedikit lebih lama, Kang? Setidaknya sekali dalam hidup, aku ingin merasa dipuaskan.Ó Pengakuan mencengangkan Nurlela ini membuat Tobor hancur. Pernikahan berusia sebelas tahun mereka berada di tubir perpisahan oleh perkara hubungan badan. Nurlela didera ragam penyesalan, sedangkan Tobor mencoba beragam cara agar urusan ranjang ini terselesaikan. Mulai dari yang medis, hingga mistis. Termasuk mencari sosok mitos Ratu Siluman Celeng dan meminta kesaktikan dari mustika berbentuk zakar. * ÒMustika Zakar Celeng sepertinya hendak melakukan rekonsiliasi antara realitas sosial dengan mitos, komik dengan tragedi, realisme dengan surealisme. Isu seksual dikembangkan menjadi isu sosial, lalu menjadi isu politik yang menggambarkan kesia-siaan tokohnya yang mencari kekuasaan tapi berakhir pada ketidakberdayaan.',
  ),
  Book(
    title: 'Tenung',
    owner: 'Nabila Norhaliza',
    thumbnail: 'assets/images/tenung.jpg',
    page: '183',
    genre: 'Horor',
    author: 'Risa Saraswati, Dimas Tri Aditiyo',
    publisher: 'Bukune',
    releaseDate: 'Jan 28, 2019',
    synopsis:
        'Andira Kusuma Dewi berhubungan dengan Fial. Andira mempunyai seorang ibu yang selalu bergonta - ganti pasangan hingga saudara-saudaranya mempunyai muka yang berbeda yaitu arab, cina, dan bule. Tapi kini ibunya jatuh sakit hingga adira yang merawat tapi ibunya tak pernah menganggapnya ada. Andira hanya ingin ibunya mati karena dia muak dengan ibunya. Andira adalah seorang gadis remaja polos yang pikirannya bisa sangat kritis. Sehari-hari, dia mengurusi ibunya yang sakit-sakitan dan menulis surat pada seseorang yang dia kenal lewat rubrik majalah. Melalui surat-surat itu, dia bercerita tentang hidupnya. Mulai dari kebingungannya atas silsilah dan wajah keluarga yang beragam, cemoohan orang-orang kepada mereka, dan yang paling membingungkan adalah bangkitnya sang ibu dari kematian setelah dinyatakan meninggal. Rahandi Syafial baru pertama kali mendapatkan surat yang menceritakan tentang keluarga dari seorang Andira yang membenci gaya hidup ibunya. Fial merasakan ada kecocokan antaranya dirinya dengan Andira tapi syafial itu ternyata adalah ayah dari ira. Syafial memalsukan namanya agar bisa dekat dengan ira. Ira pun tidak menduganya bahwa syafial adalah ayahnya yang tidak lama ini memberi semangat dan hidup bagi ira yang mengurus keluarganya. Novel ini merupakan Souvenir pernikahan Risa Saraswati dan Dimas Aditiyo berbeda dari kebanyakan orang. Bukan benda-benda unik yang diberikan kepada tamu undangan, tapi sebuah buku berjudul "Tenung". Kini buku "Tenung" bisa dinikmati oleh pembaca setia buku-buku Risa Saraswati. Penerbit Bukune yang telah menerbitkan karya terbaru dari Risa.',
  ),
  Book(
    title: 'Cantik itu Luka',
    owner: 'Muhammad Zaidhan',
    thumbnail: 'assets/images/cantik_itu_luka.jpg',
    page: '537',
    genre: 'Fiksi, Fiksi Sejarah, Realisme',
    author: 'Eka Kurniawan',
    publisher: 'Gramedia Pustaka Utama',
    releaseDate: '2002',
    synopsis:
        'Di akhir masa kolonial, seorang perempuan dipaksa menjadi pelacur. Kehidupan itu terus dijalaninya hingga ia memiliki tiga anak gadis yang kesemuanya cantik. Ketika mengandung anaknya yang keempat, ia berharap anak itu akan lahir buruk rupa. Itulah yang terjadi, meskipun secara ironik ia memberinya nama si Cantik.',
  ),
  Book(
    title: 'Lebih Senyap dari Bisikan',
    owner: 'Restu Dwi Saptoaji',
    thumbnail: 'assets/images/lebih_senyap.jpg',
    page: '164',
    genre: 'Fiksi Sastra',
    author: 'Andina Dwifatma',
    publisher: 'Gramedia Pustaka Utama',
    releaseDate: 'Jun 17, 2021',
    synopsis:
        'Lebih Senyap dari Bisikan berkisah tentang pasang surut kehidupan keluarga Amara dan Baron. Setelah memasukin tahun-tahun awal pernikahan, mereka dijejali berbagai pertanyaan mengapa belum punya anak, meski keduanya sudah mencoba berbagai cara agar bisa hamil. Di akhirat nanti, kalau aku ketemu Tuhan, akan kutanyakan kenapa Dia bikin tubuh perempuan seperti makanan kaleng. Kubayangkan di bawah pusar atau pantatku ada tulisan: Best Before: Mei 2026. Amara dan Baron dikepung pertanyaan mengapa belum punya anak. Amara dan Baron menikah tanpa restu ibu Amara karena menikah beda agama. Setelah 8 tahun menanti kehamilan dengan penuh perjuangan, akhirnya Amara bisa hamil dan melahirkan anaknya. Amara melahirkan dengan normal, meski begitu perjuangannya sangat berat saat menjadi ibu muda. Tapi, perjuangan Amara dan Baron untuk jadi orang tua dan pasangan yang ideal ternyata tidak mudah. Banyak rintangan yang menghadang mereka. Amara merasakan kelelahan yang saat menjadi ibu bagi anaknya, Yuki. Amara harus berjuang memompa asi eksklusif setiap hari selama berbulan-bulan karena harus membagi waktu dengan pekerjaannya. Aneka usaha untuk hamil nyatanya telah mereka lakukan, dari yang normal hingga ekstrem. Namun, persoalan tidak selesai tatkala Amara hamil dan melahirkan. Ada yang tidak ditulis di buku panduan menjadi orangtua, ada yang tidak pernah disampaikan di utas Program Hamil. Lebih Senyap dari Bisikan merupakan novel kedua Andina Dwifatma, setelah Semusim, dan Semusim Lagi (2013)—pemenang Sayembara Novel Dewan Kesenian Jakarta. Novel ini membuka mata pembaca dengan kisah Amara dan pahit manis kehidupan perempuan dalam menemukan apa yang berharga.',
  ),
  Book(
    title: 'Jakarta Sebelum Pagi',
    owner: 'Annisa Nikke Amalia',
    thumbnail: 'assets/images/jakarta_sebelum_pagi.jpg',
    page: '280',
    genre: 'Fiksi',
    author: 'Ziggy Zezsyazeoviennazabrizkie',
    publisher: 'Grasindo',
    releaseDate: 'Mei 01, 2016',
    synopsis:
        'Perkenalkan, namanya Emina, pekerja kantoran biasa dengan keunikannya tersendiri. Dimulai dari namanya saja, tidak ada yang menduga bahwa “Emina” adalah versi kebarat-baratan dari nama “Aminah” khas Timur Tengah. Dan tentunya masih banyak keunikan lain yang sosok tersebut miliki. Kehidupannya juga terbilang normal-normal saja, tidak ada yang begitu spesial kecuali sifat eksentriknya yang membuat hari-harinya lebih dari biasa saja. Masa lalunya juga dapat dikatakan biasa-biasa saja meskipun orang yang kali pertama mendengarnya menganggap itu luar biasa. Orang tua dari Emina sudah meninggal sejak dirinya masih kecil, membuatnya tinggal bersama kakek, nenek, dan adik dari kakeknya di sebuah daerah di kota metropolitan. Dikarenakan rumah tersebut penuh dengan orang-orang tua, Emina menjuluki rumahnya sebagai “rumah para jompo”. Kenormalan dalam hidup Emina berubah seketika saat dia menerima surat misterius dari pengirim yang tidak kalah misterius. Bukannya merasa khawatir atau semacamnya, Emina justru malah tertarik untuk mencari tahu siapa pengirim surat tersebut dan alasan kenapa dia mengirimkan surat ini. Rasa ingin tahu Emina terhadap sang pengirim misterius ini sudah sampai di titik bahwa dia menganggap pengirim surat ini sedang menguntit dirinya. Dan wajar saja Emina berpikir seperti itu, mengingat dirinya mendapatkan surat ini dengan cara yang unik pula. Dalam pencariannya terhadap pengirim surat itu, kelihatannya takdir membawanya untuk bertemu sejumlah orang yang tidak kalah eksentrik dengan dirinya. Emina berkenalan dengan banyak sekali orang-orang unik yang mau membantunya menyelidiki surat misterius ini.',
  ),
];
