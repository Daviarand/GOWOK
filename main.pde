// === Variabel Kontrol Adegan ===
final int ADEGAN_AWAL = 1;
final int ADEGAN_PERCAKAPAN = 2;
final int ADEGAN_TURUN_DAN_JALAN = 3;
final int ADEGAN_LADANG = 4;
final int ADEGAN_MASJID = 5; // BARU

int adeganSekarang = ADEGAN_AWAL;

// === Variabel Objek untuk Setiap Adegan ===
Scene1 scene1;
Scene2 scene2;
Scene3 scene3;
Scene4 scene4;
Scene5 scene5; // BARU

// === Aset Global ===
SoundFile suaraBurung, suaraSungai;

void setup() {
  size(1336, 768);
  frameRate(60); // Atur target FPS ke 60
  
  suaraBurung = new SoundFile(this, "burungBerkicau.mp3");
  suaraSungai = new SoundFile(this, "suaraSungai.mp3");
  
  suaraBurung.loop();
  suaraSungai.loop();
  suaraBurung.amp(1);
  suaraSungai.amp(0.3);
  
  // Membuat instance dari setiap kelas adegan
  scene1 = new Scene1(this);
  scene2 = new Scene2(this);
  scene3 = new Scene3(this);
  scene4 = new Scene4(this);
  scene5 = new Scene5(this);
}

void draw() {
  switch (adeganSekarang) {
    case ADEGAN_AWAL:
      scene1.run();
      break;
    case ADEGAN_PERCAKAPAN:
      scene2.run();
      break;
    case ADEGAN_TURUN_DAN_JALAN:
      scene3.run();
      break;
    case ADEGAN_LADANG:
      scene4.run();
      break;
    case ADEGAN_MASJID: // BARU
      scene5.run();
      break;
  }
}

// Fungsi ini mengatur perpindahan antar adegan
void goToNextScene() {
  if (adeganSekarang == ADEGAN_AWAL) {
    adeganSekarang = ADEGAN_PERCAKAPAN;
    scene2.reset(); 
  } else if (adeganSekarang == ADEGAN_PERCAKAPAN) {
    adeganSekarang = ADEGAN_TURUN_DAN_JALAN;
    scene3.reset();
  } else if (adeganSekarang == ADEGAN_TURUN_DAN_JALAN) {
    adeganSekarang = ADEGAN_LADANG;
    // BARU: Hentikan suara sungai saat akan masuk ke Scene 4
    if (suaraSungai.isPlaying()) {
      suaraSungai.stop();
    }
    scene4.reset();
  } else if (adeganSekarang == ADEGAN_LADANG) {
    adeganSekarang = ADEGAN_MASJID;
    // Pastikan suara sungai tetap berhenti saat masuk Scene 5
    if (suaraSungai.isPlaying()) {
      suaraSungai.stop();
    }
    scene5.reset();
  }
}