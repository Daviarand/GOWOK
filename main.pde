// === Variabel Kontrol Adegan ===
final int ADEGAN_AWAL = 1;
final int ADEGAN_PERCAKAPAN = 2;
final int ADEGAN_TURUN_DAN_JALAN = 3;
final int ADEGAN_LADANG = 4;
final int ADEGAN_MASJID = 5;
final int TRANSISI_FADE_OUT = 98;
final int TRANSISI_FADE_IN = 99;

int adeganSekarang = ADEGAN_AWAL;
int adeganBerikutnya; // Untuk menyimpan adegan tujuan saat transisi

// === Variabel Objek untuk Setiap Adegan ===
Scene1 scene1; Scene2 scene2; Scene3 scene3; Scene4 scene4; Scene5 scene5;

// === Aset Global & Variabel Transisi ===
SoundFile suaraBurung, suaraSungai;
float alphaTransisi = 0;
float kecepatanFade = 5; // Ubah untuk kecepatan transisi

void setup() {
  size(1336, 768);
  frameRate(60);
  
  suaraBurung = new SoundFile(this, "burungBerkicau.mp3");
  suaraSungai = new SoundFile(this, "suaraSungai.mp3");
  
  if (adeganSekarang <= ADEGAN_TURUN_DAN_JALAN) suaraSungai.loop();
  suaraBurung.loop();
  
  suaraBurung.amp(1);
  suaraSungai.amp(0.3);
  
  scene1 = new Scene1(this); scene2 = new Scene2(this);
  scene3 = new Scene3(this); scene4 = new Scene4(this);
  scene5 = new Scene5(this);
}

void draw() {
  // Logika utama untuk menggambar adegan atau transisi
  switch (adeganSekarang) {
    case ADEGAN_AWAL: scene1.run(); break;
    case ADEGAN_PERCAKAPAN: scene2.run(); break;
    case ADEGAN_TURUN_DAN_JALAN: scene3.run(); break;
    case ADEGAN_LADANG: scene4.run(); break;
    case ADEGAN_MASJID: scene5.run(); break;
    
    case TRANSISI_FADE_OUT:
      // Saat fade out, tetap gambar adegan sebelumnya
      runPreviousScene();
      
      alphaTransisi += kecepatanFade;
      if (alphaTransisi >= 255) {
        alphaTransisi = 255;
        adeganSekarang = TRANSISI_FADE_IN; // Ganti ke mode fade in
        resetNextScene(); // Reset adegan tujuan
      }
      break;
      
    case TRANSISI_FADE_IN:
      // Saat fade in, gambar adegan tujuan
      runNextScene();
      
      alphaTransisi -= kecepatanFade;
      if (alphaTransisi <= 0) {
        alphaTransisi = 0;
        adeganSekarang = adeganBerikutnya; // Transisi selesai
      }
      break;
  }
  
  // Gambar persegi transisi jika alpha > 0
  if (alphaTransisi > 0) {
    fill(0, alphaTransisi);
    noStroke();
    rect(0, 0, width, height);
  }
}

// Fungsi ini memulai proses transisi
void goToNextScene() {
  // Hanya proses jika tidak sedang dalam transisi
  if (adeganSekarang < 90) {
    
    // Jika adegan sekarang 1 atau 2, pindah LANGSUNG tanpa fade
    if (adeganSekarang == ADEGAN_AWAL || adeganSekarang == ADEGAN_PERCAKAPAN) {
      adeganSekarang++; // Langsung ke adegan berikutnya
      
      // Reset adegan berikutnya secara manual
      if (adeganSekarang == ADEGAN_PERCAKAPAN) {
        scene2.reset();
      } else if (adeganSekarang == ADEGAN_TURUN_DAN_JALAN) {
        scene3.reset();
      }
    } 
    // Jika adegan lain (3 atau 4), gunakan transisi FADE
    else {
      adeganBerikutnya = adeganSekarang + 1;
      adeganSekarang = TRANSISI_FADE_OUT;
    }
  }
}

// === Fungsi-fungsi pembantu untuk draw() ===
void runPreviousScene() {
  switch (adeganBerikutnya) {
    case ADEGAN_PERCAKAPAN: scene1.run(); break;
    case ADEGAN_TURUN_DAN_JALAN: scene2.run(); break;
    case ADEGAN_LADANG: scene3.run(); break;
    case ADEGAN_MASJID: scene4.run(); break;
  }
}

void runNextScene() {
  switch (adeganBerikutnya) {
    case ADEGAN_PERCAKAPAN: scene2.run(); break;
    case ADEGAN_TURUN_DAN_JALAN: scene3.run(); break;
    case ADEGAN_LADANG: scene4.run(); break;
    case ADEGAN_MASJID: scene5.run(); break;
  }
}

void resetNextScene() {
  switch (adeganBerikutnya) {
    case ADEGAN_PERCAKAPAN: scene2.reset(); break;
    case ADEGAN_TURUN_DAN_JALAN: scene3.reset(); break;
    case ADEGAN_LADANG: scene4.reset(); if(suaraSungai.isPlaying()) suaraSungai.stop(); break;
    case ADEGAN_MASJID: scene5.reset(); break;
  }
}