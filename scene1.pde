import processing.sound.*;

class Scene1 {
  PApplet p;
  PImage bg, karakterAdil;
  int startTime;

  // Variabel awan & burung
  int jumlahAwan = 5;
  float[] awanX, awanY, awanSpeed, awanSize;
  int jumlahBurung = 20;
  float[] burungX, burungY, burungSpeed, burungWaveOffset;

  // Variabel Subtitle
  String[] subtitleList;
  int currentSubtitleIndex = 0;
  int lastSubtitleChangeTime = 0;
  int charsToShow = 0;
  String currentFullText = "";
  
  // Variabel ombak & sungai
  float waveFrequency = 0.04f;
  int waterLevel = 550, waterBottom = 768;
  float leftBankTopX = 620, leftBankBottomX = -700;
  int waterUpperMidY = 620, waterMidY = 690;
  float rightBankTopX = 900, rightBankUpperMidX = 1230, rightBankMidX = 1100, rightBankBottomX = 850;

  // Constructor
  Scene1(PApplet parent) {
    p = parent;
    startTime = p.millis();
    
    // Inisialisasi Array
    awanX = new float[jumlahAwan]; awanY = new float[jumlahAwan]; awanSpeed = new float[jumlahAwan]; awanSize = new float[jumlahAwan];
    burungX = new float[jumlahBurung]; burungY = new float[jumlahBurung]; burungSpeed = new float[jumlahBurung]; burungWaveOffset = new float[jumlahBurung];

    // Muat Aset Gambar
    bg = p.loadImage("tanpaPembatas2.png");
    karakterAdil = p.loadImage("adildiam.png");
    
    subtitleList = new String[] { "Adil: Untuk apa aku terus hidup..." };

    // Inisialisasi Lingkungan
    for (int i = 0; i < jumlahAwan; i++) {
      awanX[i] = p.map(i, 0, jumlahAwan - 1, 0, p.width);
      awanY[i] = p.random(30, 150);
      awanSpeed[i] = p.random(0.3f, 1.2f);
      awanSize[i] = p.random(0.8f, 1.5f);
    }
    for (int i = 0; i < jumlahBurung; i++) {
      burungX[i] = p.random(p.width, p.width + 800);
      burungY[i] = p.random(80, 250);
      burungSpeed[i] = p.random(1.5f, 3.5f);
      burungWaveOffset[i] = p.random(p.TWO_PI);
    }
  }

  // Metode run()
  void run() {
    p.image(bg, 0, 0, p.width, p.height);
    drawAwanAndBurung();
    drawWaterWaves();
    drawPembatasJembatan2();
    drawKarakter();
    drawPembatasJembatan();
    drawSubtitle();
    
    // Setelah 6 detik, panggil fungsi di sketch utama untuk pindah adegan
    if (p.millis() - startTime > 6000) {
      ((scene1)p).goToNextScene(); 
    }
  }
  
  // === SEMUA FUNGSI GAMBAR ASLI DARI FILE ANDA ===
  
  void drawAwanAndBurung() {
    for (int i = 0; i < jumlahAwan; i++) {
      drawAwan(awanX[i], awanY[i], awanSize[i]);
      awanX[i] -= awanSpeed[i];
      if (awanX[i] < -300) {
        awanX[i] = p.width + p.random(50, 150);
        awanY[i] = p.random(30, 150);
      }
    }
    for (int i = 0; i < jumlahBurung; i++) {
      float yOffset = p.sin(p.frameCount * 0.05f + burungWaveOffset[i]) * 15;
      drawBurung(burungX[i], burungY[i] + yOffset);
      burungX[i] -= burungSpeed[i];
      if (burungX[i] < -30) {
        burungX[i] = p.width + p.random(100, 400);
        burungY[i] = p.random(80, 250);
      }
    }
  }

  void drawKarakter() {
    float scaleAdil = 0.4f;
    float scaledWidthAdil = karakterAdil.width * scaleAdil;
    float scaledHeightAdil = karakterAdil.height * scaleAdil;
    float adilX = (p.width - scaledWidthAdil) / 2;
    float adilY = p.height - scaledHeightAdil - 180;
    p.image(karakterAdil, adilX, adilY, scaledWidthAdil, scaledHeightAdil);
  }

  void drawAwan(float x, float y, float s) {
    p.noStroke(); p.fill(255, 200);
    p.ellipse(x, y, 100 * s, 60 * s); p.ellipse(x + 40 * s, y - 20 * s, 80 * s, 50 * s);
    p.ellipse(x + 80 * s, y, 100 * s, 60 * s); p.ellipse(x + 40 * s, y + 20 * s, 90 * s, 50 * s);
    p.ellipse(x - 50 * s, y + 15 * s, 80 * s, 45 * s); p.ellipse(x + 130 * s, y + 10 * s, 90 * s, 55 * s);
  }

  void drawBurung(float x, float y) {
    p.stroke(50); p.strokeWeight(2); p.noFill();
    p.arc(x, y, 20, 15, p.PI, p.TWO_PI); p.arc(x + 20, y, 20, 15, p.PI, p.TWO_PI);
  }

  void drawWaterWaves() {
    p.noFill();
    for (int y_base = waterLevel; y_base < waterBottom; y_base += 7) {
      float perspective = p.map(y_base, waterLevel, waterBottom, 0, 1);
      float currentAmplitude = p.lerp(1.5f, 4, perspective);
      float currentSpeed = p.lerp(0.02f, 0.04f, perspective);
      p.strokeWeight(p.lerp(1.5f, 2.5f, perspective));
      p.stroke(255, p.map(perspective, 0, 1, 90, 40));
      float currentWaveStartX = p.map(y_base, waterLevel, waterBottom, leftBankTopX, leftBankBottomX);
      float currentWaveEndX;
      if (y_base < waterUpperMidY) currentWaveEndX = p.map(y_base, waterLevel, waterUpperMidY, rightBankTopX, rightBankUpperMidX);
      else if (y_base < waterMidY) currentWaveEndX = p.map(y_base, waterUpperMidY, waterMidY, rightBankUpperMidX, rightBankMidX);
      else currentWaveEndX = p.map(y_base, waterMidY, waterBottom, rightBankMidX, rightBankBottomX);
      p.beginShape();
      for (float x = currentWaveStartX; x <= currentWaveEndX; x += 10) {
        float y = y_base + p.sin(x * waveFrequency + p.frameCount * currentSpeed) * currentAmplitude;
        p.vertex(x, y);
      }
      p.endShape();
    }
  }

  void drawPembatasJembatan() {
    float baseY = 470, tinggiTiang = 70, tebalPapan = 14, bayanganOffset = 3;
    p.noStroke(); p.fill(120, 75, 45); p.rect(0, baseY, p.width, tebalPapan);
    p.fill(90, 55, 30, 80); p.rect(0, baseY + tebalPapan, p.width, bayanganOffset);
    p.fill(120, 75, 45); p.rect(0, baseY + tinggiTiang, p.width, tebalPapan);
    p.fill(90, 55, 30, 80); p.rect(0, baseY + tinggiTiang + tebalPapan, p.width, bayanganOffset);
    int jumlahTiang = 12; float jarakTiang = p.width / float(jumlahTiang);
    for (int i = 0; i <= jumlahTiang; i++) {
      p.fill(135, 80, 50); p.rect(i * jarakTiang - 7, baseY, 14, tinggiTiang + tebalPapan);
    }
  }

  void drawPembatasJembatan2() {
    float baseY = 400, tinggiTiang = 70, tebalPapan = 14, bayanganOffset = 3;
    p.noStroke(); p.fill(120, 75, 45); p.rect(0, baseY, p.width, tebalPapan);
    p.fill(90, 55, 30, 80); p.rect(0, baseY + tebalPapan, p.width, bayanganOffset);
    p.fill(120, 75, 45); p.rect(0, baseY + tinggiTiang, p.width, tebalPapan);
    p.fill(90, 55, 30, 80); p.rect(0, baseY + tinggiTiang + tebalPapan, p.width, bayanganOffset);
    int jumlahTiang = 12; float jarakTiang = p.width / float(jumlahTiang);
    for (int i = 0; i <= jumlahTiang; i++) {
      p.fill(135, 80, 50); p.rect(i * jarakTiang - 7, baseY, 14, tinggiTiang + tebalPapan);
    }
  }
  
  void drawSubtitle() {
    String fullText = subtitleList[currentSubtitleIndex];
    if (!fullText.equals(currentFullText)) {
      currentFullText = fullText;
      charsToShow = 0;
      lastSubtitleChangeTime = p.millis();
    }
    int elapsed = p.millis() - lastSubtitleChangeTime;
    int maxChars = p.min(fullText.length(), elapsed / 30);
    if (maxChars > charsToShow) charsToShow = maxChars;
    String visibleText = fullText.substring(0, p.min(charsToShow, fullText.length()));
    p.textSize(24);
    float padding = 20;
    float boxWidth = p.textWidth(visibleText) + padding * 2;
    float boxHeight = 60;
    float boxX = (p.width - boxWidth) / 2;
    float boxY = p.height - boxHeight - 30;
    p.fill(0, 160); p.noStroke(); p.rect(boxX, boxY, boxWidth, boxHeight, 10);
    p.fill(255); p.textAlign(p.CENTER, p.CENTER);
    p.text(visibleText, p.width / 2, boxY + boxHeight / 2);
  }
}
