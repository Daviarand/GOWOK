//import processing.sound.*;

//class Scene5 {
//  PApplet p;

//  // Aset & Variabel
//  PImage bg, adilJalan1, adilJalan2, ustadzJalan1, ustadzJalan2, adilDuduk1, adilDuduk2, ustadzDuduk1, ustadzDuduk2;
//  SoundFile suaraJalanKaki; // Suara spesifik untuk scene ini
  
//  float scale = 0.4f; // Sesuaikan scale agar konsisten
//  float adilX, adilY, ustadzX, ustadzY;
//  int frameCounter;
//  int frameInterval = 10;
//  boolean sudahSampai;
//  String statusAdil, statusUstadz;
//  int dudukFrameCounter, dudukInterval = 30, jedaAdilMulaiDuduk = 30;

//  // Lingkungan
//  int jumlahAwan = 6; float[] awanX, awanY, awanSpeed, awanSize;
//  int jumlahBurung = 5; float[] burungX, burungY, burungSpeed;
//  float rumputOffset = 0;
//  float[] burungDiamX = {580, 620, 650};
//  float[] burungDiamY = {230, 225, 235};

//  Scene5(PApplet parent) {
//    p = parent;
    
//    // Inisialisasi Array
//    awanX = new float[jumlahAwan]; awanY = new float[jumlahAwan]; awanSpeed = new float[jumlahAwan]; awanSize = new float[jumlahAwan];
//    burungX = new float[jumlahBurung]; burungY = new float[jumlahBurung]; burungSpeed = new float[jumlahBurung];
    
//    // Muat Aset
//    bg = loadImage("Traditional Mosque in Rural Landscape (1).png"); 
//    adilJalan1 = p.loadImage("adiljalan1.png"); adilJalan2 = p.loadImage("adiljalan2.png");
//    ustadzJalan1 = p.loadImage("ustadzjalan1.png"); ustadzJalan2 = p.loadImage("ustadzjalan2.png");
//    adilDuduk1 = p.loadImage("Adilduduk1.png"); adilDuduk2 = p.loadImage("Adilduduk2.png");
//    ustadzDuduk1 = p.loadImage("Ustadduduk1.png"); ustadzDuduk2 = p.loadImage("Ustadduduk2.png");
    
//    suaraJalanKaki = new SoundFile(p, "jalanKaki.mp3");
//    suaraJalanKaki.amp(0.6f);
//  }

//  void reset() {
//    frameCounter = 0;
//    sudahSampai = false;
//    statusAdil = "jalan";
//    statusUstadz = "jalan";
//    dudukFrameCounter = 0;
    
//    adilX = p.width + 100;
//    ustadzX = adilX - 80;
//    adilY = 550;
//    ustadzY = 550;
    
//    if(!suaraJalanKaki.isPlaying()){
//      suaraJalanKaki.loop();
//    }
    
//    for (int i=0; i<jumlahAwan; i++) { awanX[i]=p.map(i,0,jumlahAwan-1,0,p.width); awanY[i]=p.random(50,200); awanSpeed[i]=p.random(0.3f,1.2f); awanSize[i]=p.random(1.2f,2.5f); }
//    for (int i=0; i<jumlahBurung; i++) { burungX[i]=p.random(p.width, p.width+800); burungY[i]=p.random(80,250); burungSpeed[i]=p.random(1.5f,3.5f); }
//  }

//  void run() {
//    p.imageMode(p.CENTER); p.image(bg, p.width/2, p.height/2); p.imageMode(p.CORNER);
    
//    drawLingkungan();
//    updateKarakter();
    
//    frameCounter++;
//    rumputOffset += 0.05;
//  }
  
//  void updateKarakter() {
//    float targetX = p.width / 2.0f - 100;
//    float charWidth = adilJalan1.width * scale;
//    float charHeight = adilJalan1.height * scale;

//    if (!sudahSampai) {
//      adilX -= 1.5f; ustadzX -= 1.5f;
//      if (adilX <= targetX) {
//        adilX = targetX; ustadzX = targetX - 80;
//        sudahSampai = true;
//        suaraJalanKaki.stop();
//      }
//    }

//    if (!sudahSampai) {
//      if ((frameCounter/frameInterval)%2==0) {p.image(adilJalan1,adilX,adilY,charWidth,charHeight); p.image(ustadzJalan1,ustadzX,ustadzY,charWidth,charHeight);}
//      else {p.image(adilJalan2,adilX,adilY,charWidth,charHeight); p.image(ustadzJalan2,ustadzX,ustadzY,charWidth,charHeight);}
//    } else {
//      float dudukYOffset = 40;
      
//      if (statusUstadz.equals("jalan")) statusUstadz = "dudukTransisi";
//      if (dudukFrameCounter > jedaAdilMulaiDuduk && statusAdil.equals("jalan")) statusAdil = "dudukTransisi";

//      if (statusUstadz.equals("dudukTransisi")) {
//        if (dudukFrameCounter < dudukInterval) p.image(ustadzDuduk1, ustadzX, ustadzY + dudukYOffset, ustadzDuduk1.width*scale, ustadzDuduk1.height*scale);
//        else { p.image(ustadzDuduk2, ustadzX, ustadzY + dudukYOffset, ustadzDuduk2.width*scale, ustadzDuduk2.height*scale); statusUstadz = "dudukAkhir"; }
//      } else if (statusUstadz.equals("dudukAkhir")) {
//        p.image(ustadzDuduk2, ustadzX, ustadzY + dudukYOffset, ustadzDuduk2.width*scale, ustadzDuduk2.height*scale);
//      }
      
//      if (statusAdil.equals("jalan")) p.image(adilJalan1, adilX, adilY, charWidth, charHeight);
//      else if (statusAdil.equals("dudukTransisi")) {
//        int adilFrame = dudukFrameCounter - jedaAdilMulaiDuduk;
//        if (adilFrame < dudukInterval) p.image(adilDuduk1, adilX, adilY + dudukYOffset, adilDuduk1.width*scale, adilDuduk1.height*scale);
//        else { p.image(adilDuduk2, adilX, adilY + dudukYOffset, adilDuduk2.width*scale, adilDuduk2.height*scale); statusAdil = "dudukAkhir"; }
//      } else if (statusAdil.equals("dudukAkhir")) {
//        p.image(adilDuduk2, adilX, adilY + dudukYOffset, adilDuduk2.width*scale, adilDuduk2.height*scale);
//      }
      
//      dudukFrameCounter++;
//    }
//  }

//  void drawLingkungan() {
//    drawBurungDiam();
//    drawRumput();
//    for (int i=0;i<jumlahAwan;i++){drawAwan(awanX[i],awanY[i],awanSize[i]);awanX[i]-=awanSpeed[i];if(awanX[i]<-300)awanX[i]=p.width+p.random(100,300);}
//    for (int i=0;i<jumlahBurung;i++){drawBurung(burungX[i],burungY[i]);burungX[i]-=burungSpeed[i];if(burungX[i]<-50)burungX[i]=p.width+p.random(100,400);}
//  }
  
//  void drawAwan(float x,float y,float s){p.noStroke();p.fill(255,220);p.ellipse(x,y,60*s,40*s);p.ellipse(x+25*s,y-10*s,50*s,35*s);p.ellipse(x+50*s,y,60*s,40*s);}
//  void drawBurung(float x,float y){p.fill(30);p.noStroke();p.triangle(x,y,x-10,y-5,x-5,y);p.triangle(x,y,x+10,y-5,x+5,y);}
//  void drawRumput(){p.stroke(34,139,34);for(int i=0;i<p.width;i+=2){if(i<220||i>1030){float sway=p.sin(rumputOffset+i*0.1f)*3;float yDasar=p.height-20;float tinggiRumput=30+p.sin(i*0.7f+rumputOffset)*3;p.line(i,yDasar,i+sway,yDasar-tinggiRumput);}}}
//  void drawBurungDiam(){for(int i=0;i<burungDiamX.length;i++){float x=burungDiamX[i],y=burungDiamY[i];p.fill(30);p.noStroke();p.ellipse(x,y,10,10);p.ellipse(x+6,y-3,6,6);p.triangle(x+9,y-3,x+13,y-1,x+9,y+1);}}
//}









// Deklarasi semua gambar yang akan digunakan
PImage bg;
PImage adilJalan1, adilJalan2;
PImage ustadzJalan1, ustadzJalan2;
PImage adilDuduk1, adilDuduk2;
PImage ustadzDuduk1, ustadzDuduk2;

// Variabel untuk skala dan posisi karakter
float scale = 0.3; // <-- DIKEMBALIKAN ke ukuran awal saat berjalan
float scaledWidth, scaledHeight;
float adilX, adilY;
float ustadzX, ustadzY;

// Variabel untuk kontrol animasi
int frameCounter = 0;
int frameInterval = 10;
boolean sudahSampai = false;

// Status transisi karakter dari berjalan ke duduk
String statusAdil = "jalan";
String statusUstadz = "jalan";
int dudukFrameCounter = 0;
int dudukInterval = 30; // Durasi untuk setiap frame duduk
int jedaAdilMulaiDuduk = 30; // Jeda sebelum adil mulai duduk

// Variabel untuk elemen latar belakang (Awan)
int jumlahAwan = 6;
float[] awanX = new float[jumlahAwan];
float[] awanY = new float[jumlahAwan];
float[] awanSpeed = new float[jumlahAwan];
float[] awanSize = new float[jumlahAwan];

// Variabel untuk elemen latar belakang (Burung Terbang)
int jumlahBurung = 5;
float[] burungX = new float[jumlahBurung];
float[] burungY = new float[jumlahBurung];
float[] burungSpeed = new float[jumlahBurung];

// Variabel untuk efek rumput bergoyang
float rumputOffset = 0;

// Posisi untuk burung yang diam di atap
float[] burungDiamX = {580, 620, 650};
float[] burungDiamY = {230, 225, 235};


void setup() {
  size(1336, 768);
  
  // Memuat semua aset gambar
  bg = loadImage("masjid.png");
  adilJalan1 = loadImage("adiljalan1.png");
  adilJalan2 = loadImage("adiljalan2.png");
  ustadzJalan1 = loadImage("ustadzjalan1.png");
  ustadzJalan2 = loadImage("ustadzjalan2.png");
  adilDuduk1 = loadImage("Adilduduk1.png");
  adilDuduk2 = loadImage("Adilduduk2.png");
  ustadzDuduk1 = loadImage("Ustadduduk1.png");
  ustadzDuduk2 = loadImage("Ustadduduk2.png");

  // Menghitung ukuran karakter setelah di-skala
  scaledWidth = adilJalan1.width * scale;
  scaledHeight = adilJalan1.height * scale;

  // Posisi awal karakter (di luar layar kanan)
  adilX = width + 120; // Adil sedikit di belakang ustadz
  ustadzX = width + 50;
  adilY = 630;
  ustadzY = 630;

  // Inisialisasi posisi dan properti awan
  for (int i = 0; i < jumlahAwan; i++) {
    awanX[i] = random(width);
    awanY[i] = random(50, 200);
    awanSpeed[i] = random(0.3, 1.2);
    awanSize[i] = random(1.2, 2.5);
  }

  // Inisialisasi posisi dan properti burung terbang
  for (int i = 0; i < jumlahBurung; i++) {
    burungX[i] = random(width, width + 800);
    burungY[i] = random(80, 250);
    burungSpeed[i] = random(1.5, 3.5);
  }
}

void draw() {
  // --- GAMBAR LATAR BELAKANG DAN EFEK VISUAL ---
  imageMode(CORNER);
  image(bg, 0, 0, width, height);

  drawKotakInfaq();
  drawBurungDiam();
  drawRumput();

  // Menggambar dan menggerakkan awan
  for (int i = 0; i < jumlahAwan; i++) {
    drawAwan(awanX[i], awanY[i], awanSize[i]);
    awanX[i] -= awanSpeed[i];
    if (awanX[i] < -200) { // Jika keluar layar, reset posisi
      awanX[i] = width + random(100, 300);
      awanY[i] = random(50, 200);
    }
  }

  // Menggambar dan menggerakkan burung terbang
  for (int i = 0; i < jumlahBurung; i++) {
    drawBurung(burungX[i], burungY[i]);
    burungX[i] -= burungSpeed[i];
    if (burungX[i] < -50) { // Jika keluar layar, reset posisi
      burungX[i] = width + random(100, 400);
      burungY[i] = random(80, 250);
    }
  }

  // Kembalikan mode gambar ke CENTER untuk karakter
  imageMode(CENTER);

  // --- LOGIKA GERAKAN DAN POSISI KARAKTER ---

  // Tentukan posisi target akhir saat duduk
  float targetUstadzX = width / 2.0 + 10;
  float jarakDuduk = 70; 
  float targetAdilX = targetUstadzX - jarakDuduk;

  // Jika karakter belum sampai di tujuan
  if (!sudahSampai) {
    // Gerakkan kedua karakter ke kiri
    float speed = 2.0;
    adilX -= speed;
    ustadzX -= speed;

    // Cek jika Ustadz sudah mencapai posisi targetnya
    if (ustadzX <= targetUstadzX) {
      ustadzX = targetUstadzX; // Kunci posisi akhir Ustadz
      adilX = targetAdilX;     // Kunci posisi akhir Adil
      sudahSampai = true;      // Set status menjadi sudah sampai
    }

    // Tampilkan animasi berjalan
    if ((frameCounter / frameInterval) % 2 == 0) {
      image(adilJalan1, adilX, adilY, scaledWidth, scaledHeight);
      image(ustadzJalan1, ustadzX, ustadzY, scaledWidth, scaledHeight);
    } else {
      image(adilJalan2, adilX, adilY, scaledWidth, scaledHeight);
      image(ustadzJalan2, ustadzX, ustadzY, scaledWidth, scaledHeight);
    }

  } else { // Jika sudah sampai, mulai animasi duduk
    // ================== PERUBAHAN DI SINI ==================
    float dudukScale = 0.15; // DIUBAH, ukuran saat duduk dikecilkan
    // =======================================================
    
    float dudukWidth = adilDuduk1.width * dudukScale;
    float dudukHeight = adilDuduk1.height * dudukScale;
    float dudukYOffset = 60; // Offset Y disesuaikan dengan skala baru

    // ---- Animasi Duduk Ustadz ----
    if (statusUstadz.equals("jalan")) {
      statusUstadz = "dudukTransisi";
      dudukFrameCounter = 0; 
    }

    if (statusUstadz.equals("dudukTransisi")) {
      image(ustadzDuduk1, ustadzX, ustadzY + dudukYOffset, dudukWidth, dudukHeight);
      if (dudukFrameCounter >= dudukInterval) {
        statusUstadz = "dudukAkhir"; 
      }
    }
    
    if (statusUstadz.equals("dudukAkhir")) {
       image(ustadzDuduk2, ustadzX, ustadzY + dudukYOffset, dudukWidth, dudukHeight);
    }

    // ---- Animasi Duduk Adil ----
    if (statusAdil.equals("jalan") && dudukFrameCounter >= jedaAdilMulaiDuduk) {
      statusAdil = "dudukTransisi";
    }

    // Jika Adil masih "jalan", tampilkan animasi berjalan dengan skala normal
    if (statusAdil.equals("jalan")) {
       if ((frameCounter / frameInterval) % 2 == 0) {
           image(adilJalan1, adilX, adilY, scaledWidth, scaledHeight);
       } else {
           image(adilJalan2, adilX, adilY, scaledWidth, scaledHeight);
       }
    }

    // Jika Adil dalam transisi duduk, gunakan skala duduk
    if (statusAdil.equals("dudukTransisi")) {
      image(adilDuduk1, adilX, adilY + dudukYOffset, dudukWidth, dudukHeight);
      int adilFrame = dudukFrameCounter - jedaAdilMulaiDuduk;
      if (adilFrame >= dudukInterval) {
        statusAdil = "dudukAkhir";
      }
    }
    
    // Jika Adil sudah selesai transisi, gunakan skala duduk
    if (statusAdil.equals("dudukAkhir")) {
      image(adilDuduk2, adilX, adilY + dudukYOffset, dudukWidth, dudukHeight);
    }

    dudukFrameCounter++;
  }

  // Tingkatkan counter untuk animasi
  frameCounter++;
  rumputOffset += 0.05; // Untuk efek rumput bergoyang
}


// --- FUNGSI-FUNGSI BANTUAN (Tidak Ada Perubahan) ---

void drawAwan(float x, float y, float s) {
  noStroke();
  fill(255, 255, 255, 220);
  ellipse(x, y, 60 * s, 40 * s);
  ellipse(x + 25 * s, y - 10 * s, 50 * s, 35 * s);
  ellipse(x + 50 * s, y, 60 * s, 40 * s);
}

void drawBurung(float x, float y) {
  fill(30);
  noStroke();
  triangle(x, y, x - 10, y - 5, x - 5, y);
  triangle(x, y, x + 10, y - 5, x + 5, y);
}

void drawRumput() {
  stroke(34, 139, 34);
  strokeWeight(1.5);
  for (int i = 0; i < width; i += 2) {
    if (i < 220 || i > 1030) {
      float sway = sin(rumputOffset + i * 0.1) * 3;
      float yDasar = height - 20;
      float tinggiRumput = 30 + sin(i * 0.7 + rumputOffset) * 3;
      line(i, yDasar, i + sway, yDasar - tinggiRumput);
    }
  }
}

void drawBurungDiam() {
  for (int i = 0; i < burungDiamX.length; i++) {
    float x = burungDiamX[i];
    float y = burungDiamY[i] + 150;
    fill(30);
    noStroke();
    ellipse(x, y, 10, 10);
    ellipse(x + 6, y - 3, 6, 6);
    triangle(x + 9, y - 3, x + 13, y - 1, x + 9, y + 1);
  }
}

void drawKotakInfaq() {
  float kotakX = 688;
  float kotakY = 601;
  float kotakWidth = 40;
  float kotakHeight = 50;
  fill(139, 69, 19);
  stroke(90, 40, 10);
  strokeWeight(2);
  rect(kotakX, kotakY, kotakWidth, kotakHeight, 5);
  stroke(0);
  strokeWeight(3);
  line(kotakX + 10, kotakY + 10, kotakX + kotakWidth - 10, kotakY + 10);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(12);
  text("INFAQ", kotakX + kotakWidth / 2, kotakY + kotakHeight / 2 + 5);
}
