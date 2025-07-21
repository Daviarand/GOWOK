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








//// Variabel Latar dan Karakter
//PImage bg;
//PImage adilJalan1, adilJalan2, ustadzJalan1, ustadzJalan2;
//PImage adilDuduk1, adilDuduk2, ustadzDuduk1, ustadzDuduk2;

//float scale = 0.3;
//float scaledWidth, scaledHeight;
//float adilX, adilY, ustadzX, ustadzY;

//int frameCounter = 0;
//int frameInterval = 10;
//boolean sudahSampai = false;

//// Status transisi duduk
//String statusAdil = "jalan", statusUstadz = "jalan";
//int dudukFrameCounter = 0, dudukInterval = 30, jedaAdilMulaiDuduk = 0;

//// Variabel Awan dan Burung Terbang
//int jumlahAwan = 6;
//float[] awanX = new float[jumlahAwan], awanY = new float[jumlahAwan];
//float[] awanSpeed = new float[jumlahAwan], awanSize = new float[jumlahAwan];
//int jumlahBurung = 5;
//float[] burungX = new float[jumlahBurung], burungY = new float[jumlahBurung], burungSpeed = new float[jumlahBurung];

//// Variabel Rumput Bergoyang
//int jumlahRumput = 500;
//float[] rumputX = new float[jumlahRumput];
//float[] rumputY = new float[jumlahRumput];
//float[] rumputHeight = new float[jumlahRumput];
//float[] rumputPhase = new float[jumlahRumput];

//// Burung diam di atap masjid
//float[] burungDiamX = {580, 620, 650}, burungDiamY = {230, 225, 235};

//// Variabel untuk Sapi (Jumlah diubah menjadi 5)
//int jumlahSapi = 5;
//float[] sapiX = new float[jumlahSapi];
//float[] sapiY = new float[jumlahSapi];
//float[] sapiSpeed = new float[jumlahSapi];
//int[] sapiArah = new int[jumlahSapi];

//void setup() {
//  size(1336, 768);
//  bg = loadImage("Traditional Mosque in Rural Landscape (1).png"); 

//  adilJalan1 = loadImage("adiljalan1.png");
//  adilJalan2 = loadImage("adiljalan2.png");
//  ustadzJalan1 = loadImage("ustadzjalan1.png");
//  ustadzJalan2 = loadImage("ustadzjalan2.png");
//  adilDuduk1 = loadImage("Adilduduk1.png");
//  adilDuduk2 = loadImage("Adilduduk2.png");
//  ustadzDuduk1 = loadImage("Ustadduduk1.png");
//  ustadzDuduk2 = loadImage("Ustadduduk2.png");

//  scaledWidth = adilJalan1.width * scale;
//  scaledHeight = adilJalan1.height * scale;

//  adilX = width + 50;
//  ustadzX = adilX - 70;
//  adilY = 630;
//  ustadzY = 630;

//  for (int i = 0; i < jumlahAwan; i++) {
//    awanX[i] = map(i, 0, jumlahAwan - 1, 0, width);
//    awanY[i] = random(50, 200);
//    awanSpeed[i] = random(0.3, 1.2);
//    awanSize[i] = random(1.2, 2.5);
//  }
//  for (int i = 0; i < jumlahBurung; i++) {
//    burungX[i] = random(width, width + 800);
//    burungY[i] = random(80, 250);
//    burungSpeed[i] = random(1.5, 3.5);
//  }
  
//  for (int i = 0; i < jumlahSapi; i++) {
//    sapiX[i] = random(50, 0); 
//    sapiY[i] = random(610, 650);      
//    sapiSpeed[i] = random(0.2, 0.6);
//    sapiArah[i] = (random(1) > 0.5) ? 1 : -1; 
//  }
  
//  for (int i = 0; i < jumlahRumput; i++) {
//    rumputX[i] = random(width);
//    rumputY[i] = random(700, height); 
//    rumputHeight[i] = random(10, 25);
//    rumputPhase[i] = random(TWO_PI);
//  }
//}

//void draw() {
//  background(255);
  
//  imageMode(CORNER);
//  image(bg, 0, 0, width, height);
  
//  imageMode(CENTER);

//  drawRumput(); 
//  drawBurungDiam();
  
//  updateAndDrawSapi();
//  drawKotakInfaq(); 

//  imageMode(CORNER);
//  for (int i = 0; i < jumlahAwan; i++) {
//    drawAwan(awanX[i], awanY[i], awanSize[i]);
//    awanX[i] -= awanSpeed[i];
//    if (awanX[i] < -200) awanX[i] = width + random(100, 300);
//  }
//  for (int i = 0; i < jumlahBurung; i++) {
//    drawBurung(burungX[i], burungY[i]);
//    burungX[i] -= burungSpeed[i];
//    if (burungX[i] < -50) burungX[i] = width + random(100, 400);
//  }
  
//  imageMode(CENTER);

//  // --- Logika Karakter Jalan & Duduk (Diperbaiki agar tidak kebablasan) ---
//  float targetAdilX = width / 2 - 100;  
//  float targetUstadzX = width / 2 - 10;

//  if (!sudahSampai) {
//    // Cek dulu APAKAH karakter SUDAH melewati atau TEPAT di target
//    if (adilX <= targetAdilX) {
//      // Jika ya, kunci posisinya dan berhenti
//      adilX = targetAdilX;
//      ustadzX = targetUstadzX;
//      sudahSampai = true;
//    } else {
//      // Jika belum, baru gerakkan karakter
//      adilX -= 1.5;
//      ustadzX -= 1.5;
//    }
//  }

//  if (!sudahSampai) {
//    if ((frameCounter / frameInterval) % 2 == 0) {
//      image(adilJalan1, adilX, adilY, scaledWidth, scaledHeight);
//      image(ustadzJalan1, ustadzX, ustadzY, scaledWidth, scaledHeight);
//    } else {
//      image(adilJalan2, adilX, adilY, scaledWidth, scaledHeight);
//      image(ustadzJalan2, ustadzX, ustadzY, scaledWidth, scaledHeight);
//    }
//  } else {
//    // === PERUBAHAN DI SINI: Skala dipisahkan ===
    
//    // Skala duduk untuk Adil (bisa diubah)
//    float dudukScaleAdil = 0.20; 
//    float dudukWidthAdil = adilDuduk1.width * dudukScaleAdil;
//    float dudukHeightAdil = adilDuduk1.height * dudukScaleAdil;
    
//    // Skala duduk untuk Ustadz (bisa diubah)
//    float dudukScaleUstadz = 0.10; // Dibuat sedikit lebih besar sebagai contoh
//    float dudukWidthUstadz = ustadzDuduk1.width * dudukScaleUstadz;
//    float dudukHeightUstadz = ustadzDuduk1.height * dudukScaleUstadz;

//    float dudukY = 600; 

//    if (statusUstadz.equals("jalan") && statusAdil.equals("jalan")) {
//      statusUstadz = "dudukTransisi";
//      dudukFrameCounter = 0;
//    }
    
//    // Menggunakan skala Ustadz
//    if (statusUstadz.equals("dudukTransisi")) {
//      if (dudukFrameCounter < dudukInterval) image(ustadzDuduk1, ustadzX, dudukY, dudukWidthUstadz, dudukHeightUstadz);
//      else statusUstadz = "dudukAkhir";
//    }
//    if (statusUstadz.equals("dudukAkhir")) {
//      image(ustadzDuduk2, ustadzX, dudukY, dudukWidthUstadz, dudukHeightUstadz);
//    }
    
//    if (statusAdil.equals("jalan")) {
//      image(adilJalan1, adilX, adilY, scaledWidth, scaledHeight);
//    }
    
//    if (dudukFrameCounter >= jedaAdilMulaiDuduk && statusAdil.equals("jalan")) {
//      statusAdil = "dudukTransisi";
//    }
    
//    // Menggunakan skala Adil
//    if (statusAdil.equals("dudukTransisi")) {
//      int adilFrame = dudukFrameCounter - jedaAdilMulaiDuduk;
//      if (adilFrame < dudukInterval) image(adilDuduk1, adilX, dudukY, dudukWidthAdil, dudukHeightAdil);
//      else statusAdil = "dudukAkhir";
//    }
//    if (statusAdil.equals("dudukAkhir")) {
//      image(adilDuduk2, adilX, dudukY, dudukWidthAdil, dudukHeightAdil);
//    }
//    dudukFrameCounter++;
//  }

//  frameCounter++;
//}

//// === FUNGSI GAMBAR ===

//void drawAwan(float x, float y, float s) {
//  noStroke();
//  fill(255, 255, 255, 220);
//  ellipse(x, y, 60 * s, 40 * s);
//  ellipse(x + 25 * s, y - 10 * s, 50 * s, 35 * s);
//  ellipse(x + 50 * s, y, 60 * s, 40 * s);
//}

//void drawBurung(float x, float y) {
//  fill(30);
//  noStroke();
//  triangle(x, y, x - 10, y - 5, x - 5, y);
//  triangle(x, y, x + 10, y - 5, x + 5, y);
//}

//void drawBurungDiam() {
//  for (int i = 0; i < burungDiamX.length; i++) {
//    float x = burungDiamX[i];
//    float y = burungDiamY[i] + 150; 
//    fill(30);
//    noStroke();
//    ellipse(x, y, 10, 10);
//    ellipse(x + 6, y - 3, 6, 6);
//    triangle(x + 9, y - 3, x + 13, y - 1, x + 9, y + 1);
//  }
//}

//void updateAndDrawSapi() {
//  for (int i = 0; i < jumlahSapi; i++) {
//    sapiX[i] += sapiSpeed[i] * sapiArah[i];

//    if (sapiX[i] < 50 || sapiX[i] > 200) { 
//      sapiArah[i] *= -1;
//    }
    
//    drawSapi(sapiX[i], sapiY[i], sapiArah[i]);
//  }
//}

//void drawSapi(float x, float y, int arah) {
//  pushMatrix();
//  translate(x, y);
//  scale(0.20); 
  
//  if (arah == -1) {
//    scale(-1, 1);
//  }

//  noStroke();
//  fill(255);
//  ellipse(0, 0, 150, 90);

//  fill(30);
//  ellipse(-30, -10, 40, 30);
//  ellipse(25, 15, 30, 25);
  
//  fill(255);
//  ellipse(75, -25, 60, 50);
  
//  fill(30);
//  ellipse(90, -30, 8, 8);

//  stroke(30);
//  strokeWeight(10);
//  line(-40, 20, -40, 60);
//  line(40, 20, 40, 60);
//  strokeWeight(8);
//  line(-30, 20, -30, 58);
//  line(30, 20, 30, 58);

//  popMatrix();
//}

//void drawKotakInfaq() {
//  float kotakX = 688;
//  float kotakY = 601;
//  float kotakWidth = 40;
//  float kotakHeight = 50;
//  fill(139, 69, 19);
//  stroke(90, 40, 10);
//  strokeWeight(2);
//  rect(kotakX, kotakY, kotakWidth, kotakHeight, 5);
//  stroke(0);
//  strokeWeight(3);
//  line(kotakX + 10, kotakY + 10, kotakX + kotakWidth - 10, kotakY + 10);
//  fill(255);
//  textAlign(CENTER, CENTER);
//  textSize(12);
//  text("INFAQ", kotakX + kotakWidth / 2, kotakY + kotakHeight / 2 + 5);
//}

//void drawRumput() {
//  for (int i = 0; i < jumlahRumput; i++) {
//    float sway = sin(frameCount * 0.03 + rumputPhase[i]) * 5; 
//    stroke(139, 190, 109, 140); 
//    line(rumputX[i], rumputY[i], rumputX[i] + sway, rumputY[i] - rumputHeight[i]);
//  }
//}




















// Variabel Latar dan Karakter
PImage bg;
PImage adilJalan1, adilJalan2, ustadzJalan1, ustadzJalan2;
PImage adilDuduk1, adilDuduk2, ustadzDuduk1, ustadzDuduk2;

float scale = 0.3;
float scaledWidth, scaledHeight;
float adilX, adilY, ustadzX, ustadzY;

int frameCounter = 0;
int frameInterval = 10;
boolean sudahSampai = false;

// Status transisi duduk
String statusAdil = "jalan", statusUstadz = "jalan";
int dudukFrameCounter = 0, dudukInterval = 30, jedaAdilMulaiDuduk = 0;

// Variabel Awan dan Burung Terbang
int jumlahAwan = 6;
float[] awanX = new float[jumlahAwan], awanY = new float[jumlahAwan];
float[] awanSpeed = new float[jumlahAwan], awanSize = new float[jumlahAwan];
int jumlahBurung = 5;
float[] burungX = new float[jumlahBurung], burungY = new float[jumlahBurung], burungSpeed = new float[jumlahBurung];

// Variabel Rumput Bergoyang
int jumlahRumput = 500;
float[] rumputX = new float[jumlahRumput];
float[] rumputY = new float[jumlahRumput];
float[] rumputHeight = new float[jumlahRumput];
float[] rumputPhase = new float[jumlahRumput];

// Burung diam di atap masjid
float[] burungDiamX = {580, 620, 650}, burungDiamY = {230, 225, 235};

// Variabel untuk Sapi (Jumlah diubah menjadi 5)
int jumlahSapi = 5;
float[] sapiX = new float[jumlahSapi];
float[] sapiY = new float[jumlahSapi];
float[] sapiSpeed = new float[jumlahSapi];
int[] sapiArah = new int[jumlahSapi];

void setup() {
  size(1336, 768);
  bg = loadImage("Traditional Mosque in Rural Landscape (1).png"); 

  adilJalan1 = loadImage("adiljalan1.png");
  adilJalan2 = loadImage("adiljalan2.png");
  ustadzJalan1 = loadImage("ustadzjalan1.png");
  ustadzJalan2 = loadImage("ustadzjalan2.png");
  adilDuduk1 = loadImage("Adilduduk1.png");
  adilDuduk2 = loadImage("Adilduduk2.png");
  ustadzDuduk1 = loadImage("Ustadduduk1.png");
  ustadzDuduk2 = loadImage("Ustadduduk2.png");

  scaledWidth = adilJalan1.width * scale;
  scaledHeight = adilJalan1.height * scale;

  adilX = width + 50;
  ustadzX = adilX + 100;
  adilY = 630;
  ustadzY = 630;

  for (int i = 0; i < jumlahAwan; i++) {
    awanX[i] = map(i, 0, jumlahAwan - 1, 0, width);
    awanY[i] = random(50, 200);
    awanSpeed[i] = random(0.3, 1.2);
    awanSize[i] = random(1.2, 2.5);
  }
  for (int i = 0; i < jumlahBurung; i++) {
    burungX[i] = random(width, width + 800);
    burungY[i] = random(80, 250);
    burungSpeed[i] = random(1.5, 3.5);
  }
  
  for (int i = 0; i < jumlahSapi; i++) {
    sapiX[i] = random(50, 0); 
    sapiY[i] = random(610, 650);      
    sapiSpeed[i] = random(0.2, 0.6);
    sapiArah[i] = (random(1) > 0.5) ? 1 : -1; 
  }
  
  for (int i = 0; i < jumlahRumput; i++) {
    rumputX[i] = random(width);
    rumputY[i] = random(700, height); 
    rumputHeight[i] = random(10, 25);
    rumputPhase[i] = random(TWO_PI);
  }
}

void draw() {
  background(255);
  
  imageMode(CORNER);
  image(bg, 0, 0, width, height);
  
  imageMode(CENTER);

  drawRumput(); 
  drawBurungDiam();
  
  updateAndDrawSapi();
  drawKotakInfaq(); 

  imageMode(CORNER);
  for (int i = 0; i < jumlahAwan; i++) {
    drawAwan(awanX[i], awanY[i], awanSize[i]);
    awanX[i] -= awanSpeed[i];
    if (awanX[i] < -200) awanX[i] = width + random(100, 300);
  }
  for (int i = 0; i < jumlahBurung; i++) {
    drawBurung(burungX[i], burungY[i]);
    burungX[i] -= burungSpeed[i];
    if (burungX[i] < -50) burungX[i] = width + random(100, 400);
  }
  
  imageMode(CENTER);

  // --- Logika Karakter Jalan & Duduk (Diperbaiki agar tidak kebablasan) ---
  float targetAdilX = width / 2 - 100;  
  float targetUstadzX = width / 2 - 10;

if (!sudahSampai) {
    // Cek dulu APAKAH karakter SUDAH melewati atau TEPAT di target
    if (adilX <= targetAdilX) {
      // Jika ya, kunci posisinya dan berhenti
      adilX = targetAdilX;
      ustadzX = targetUstadzX;
      sudahSampai = true;
    } else {
      // Jika belum, baru gerakkan karakter
      adilX -= 1.5;
      ustadzX -= 1.5;
    }
  }

  if (!sudahSampai) {
    if ((frameCounter / frameInterval) % 2 == 0) {
      image(adilJalan1, adilX, adilY, scaledWidth, scaledHeight);
      image(ustadzJalan1, ustadzX, ustadzY, scaledWidth, scaledHeight);
    } else {
      image(adilJalan2, adilX, adilY, scaledWidth, scaledHeight);
      image(ustadzJalan2, ustadzX, ustadzY, scaledWidth, scaledHeight);
    }
  } else {
    // === PERUBAHAN DI SINI: Skala dipisahkan ===
    
    // Skala duduk untuk Adil (bisa diubah)
    float dudukScaleAdil = 0.20; 
    float dudukWidthAdil = adilDuduk1.width * dudukScaleAdil;
    float dudukHeightAdil = adilDuduk1.height * dudukScaleAdil;
    
    // Skala duduk untuk Ustadz (bisa diubah)
    float dudukScaleUstadz = 0.10; // Dibuat sedikit lebih besar sebagai contoh
    float dudukWidthUstadz = ustadzDuduk1.width * dudukScaleUstadz;
    float dudukHeightUstadz = ustadzDuduk1.height * dudukScaleUstadz;

    float dudukY = 600; 

    if (statusUstadz.equals("jalan") && statusAdil.equals("jalan")) {
      statusUstadz = "dudukTransisi";
      dudukFrameCounter = 0;
    }
    
    // Menggunakan skala Ustadz
    if (statusUstadz.equals("dudukTransisi")) {
      if (dudukFrameCounter < dudukInterval) image(ustadzDuduk1, ustadzX, dudukY, dudukWidthUstadz, dudukHeightUstadz);
      else statusUstadz = "dudukAkhir";
    }
    if (statusUstadz.equals("dudukAkhir")) {
      image(ustadzDuduk2, ustadzX, dudukY, dudukWidthUstadz, dudukHeightUstadz);
    }
    
    if (statusAdil.equals("jalan")) {
      image(adilJalan1, adilX, adilY, scaledWidth, scaledHeight);
    }
    
    if (dudukFrameCounter >= jedaAdilMulaiDuduk && statusAdil.equals("jalan")) {
      statusAdil = "dudukTransisi";
    }
    
    // Menggunakan skala Adil
    if (statusAdil.equals("dudukTransisi")) {
      int adilFrame = dudukFrameCounter - jedaAdilMulaiDuduk;
      if (adilFrame < dudukInterval) image(adilDuduk1, adilX, dudukY, dudukWidthAdil, dudukHeightAdil);
      else statusAdil = "dudukAkhir";
    }
    if (statusAdil.equals("dudukAkhir")) {
      image(adilDuduk2, adilX, dudukY, dudukWidthAdil, dudukHeightAdil);
    }
    dudukFrameCounter++;
  }

  frameCounter++;
}

// === FUNGSI GAMBAR ===

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

void updateAndDrawSapi() {
  for (int i = 0; i < jumlahSapi; i++) {
    sapiX[i] += sapiSpeed[i] * sapiArah[i];

    if (sapiX[i] < 50 || sapiX[i] > 200) { 
      sapiArah[i] *= -1;
    }
    
    drawSapi(sapiX[i], sapiY[i], sapiArah[i]);
  }
}

void drawSapi(float x, float y, int arah) {
  pushMatrix();
  translate(x, y);
  scale(0.20); 
  
  if (arah == -1) {
    scale(-1, 1);
  }

  noStroke();
  fill(255);
  ellipse(0, 0, 150, 90);

  fill(30);
  ellipse(-30, -10, 40, 30);
  ellipse(25, 15, 30, 25);
  
  fill(255);
  ellipse(75, -25, 60, 50);
  
  fill(30);
  ellipse(90, -30, 8, 8);

  stroke(30);
  strokeWeight(10);
  line(-40, 20, -40, 60);
  line(40, 20, 40, 60);
  strokeWeight(8);
  line(-30, 20, -30, 58);
  line(30, 20, 30, 58);

  popMatrix();
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

void drawRumput() {
  for (int i = 0; i < jumlahRumput; i++) {
    float sway = sin(frameCount * 0.03 + rumputPhase[i]) * 5; 
    stroke(139, 190, 109, 140); 
    line(rumputX[i], rumputY[i], rumputX[i] + sway, rumputY[i] - rumputHeight[i]);
  }
}
