//import processing.sound.*;

//class Scene2 {
//  PApplet p;
  
//  // Aset khusus Scene 2
//  PImage bg, karakterAdil, ustadzJalan1, ustadzJalan2, ustadzDiam;
//  SoundFile suaraJalanKaki;

//  // Variabel Subtitle
//  String[] subtitleList; int[] subtitleDurations; int currentSubtitleIndex;
//  int lastSubtitleChangeTime; int charsToShow; String currentFullText;

//  // Variabel State Internal
//  float ustadzX, ustadzY; boolean ustadzBerjalan;
//  boolean conversationStarted; int frameCounter;
//  final int frameInterval = 10; final float scale = 0.4f;

//  // Variabel Lingkungan
//  int jumlahAwan = 5; float[] awanX, awanY, awanSpeed, awanSize;
//  int jumlahBurung = 20; float[] burungX, burungY, burungSpeed, burungWaveOffset;
//  float waveFrequency=0.04f; int waterLevel=550, waterBottom=768; float leftBankTopX=620, leftBankBottomX=-700;
//  int waterUpperMidY=620, waterMidY=690; float rightBankTopX=900, rightBankUpperMidX=1230, rightBankMidX=1100, rightBankBottomX=850;

//  Scene2(PApplet parent) {
//    p = parent;
    
//    // Inisialisasi Array
//    awanX = new float[jumlahAwan]; awanY = new float[jumlahAwan]; awanSpeed = new float[jumlahAwan]; awanSize = new float[jumlahAwan];
//    burungX = new float[jumlahBurung]; burungY = new float[jumlahBurung]; burungSpeed = new float[jumlahBurung]; burungWaveOffset = new float[jumlahBurung];
    
//    // Muat Aset
//    bg = p.loadImage("tanpaPembatas2.png"); karakterAdil = p.loadImage("adildiam.png");
//    ustadzJalan1 = p.loadImage("ustadzjalan1.png"); ustadzJalan2 = p.loadImage("ustadzjalan2.png");
//    ustadzDiam = p.loadImage("ustaddiam.png"); suaraJalanKaki = new SoundFile(p, "jalanKaki.mp3");
//    suaraJalanKaki.amp(0.6f);

//    initializeSubtitles();
    
//    // Inisialisasi Lingkungan
//    for (int i=0; i<jumlahAwan; i++) {
//      awanX[i]=p.map(i,0,jumlahAwan-1,0,p.width); awanY[i]=p.random(30,150);
//      awanSpeed[i]=p.random(0.3f,1.2f); awanSize[i]=p.random(0.8f,1.5f);
//    }
//    for (int i=0; i<jumlahBurung; i++) {
//      burungX[i]=p.random(p.width, p.width+800); burungY[i]=p.random(80,250);
//      burungSpeed[i]=p.random(1.5f,3.5f); burungWaveOffset[i]=p.random(p.TWO_PI);
//    }
//  }

//  void reset() {
//    currentSubtitleIndex = 0; lastSubtitleChangeTime = p.millis(); charsToShow = 0; currentFullText = "";
//    ustadzBerjalan = true; conversationStarted = false; frameCounter = 0;
//    ustadzX = p.width; ustadzY = 630 - (ustadzJalan1.height * scale);
//    if (!suaraJalanKaki.isPlaying()) suaraJalanKaki.loop();
//  }

//  void run() {
//    p.image(bg, 0, 0, p.width, p.height);
//    drawAwanAndBurung(); drawWaterWaves(); drawPembatasJembatan2();
//    drawKarakter(); drawUstadz(); drawPembatasJembatan();
//    drawSubtitle();
    
//    // BARU: Pemicu untuk pindah ke adegan berikutnya setelah subtitle terakhir selesai
//    if (currentSubtitleIndex == subtitleList.length - 1) {
//      // Tunggu sebentar setelah subtitle terakhir (kosong) muncul
//      if (p.millis() - lastSubtitleChangeTime > 2000) {
//        ((scene1)p).goToNextScene();
//      }
//    }
//  }

//  // === SEMUA FUNGSI GAMBAR ASLI ANDA ADA DI SINI ===
//  void drawKarakter() {
//    float sW=karakterAdil.width*scale, sH=karakterAdil.height*scale;
//    float adilX=(p.width-sW)/2, adilY=p.height-sH-180;
//    p.image(karakterAdil, adilX, adilY, sW, sH);
//  }
  
//  void drawUstadz() {
//    float adilX = (p.width - (karakterAdil.width * scale)) / 2;
//    if (ustadzBerjalan) {
//      ustadzX -= 2;
//      if (ustadzX <= adilX + 150) {
//        ustadzBerjalan = false; suaraJalanKaki.stop();
//        conversationStarted = true; currentSubtitleIndex = 1; currentFullText = ""; lastSubtitleChangeTime = p.millis();
//      }
//      if((p.frameCount/frameInterval)%2==0) p.image(ustadzJalan1,ustadzX,ustadzY,ustadzJalan1.width*scale,ustadzJalan1.height*scale);
//      else p.image(ustadzJalan2,ustadzX,ustadzY,ustadzJalan2.width*scale,ustadzJalan2.height*scale);
//      frameCounter++;
//    } else {
//      p.image(ustadzDiam,ustadzX,ustadzY,ustadzDiam.width*scale,ustadzDiam.height*scale);
//    }
//  }

//  void initializeSubtitles() {
//    subtitleList=new String[]{"Adil: Untuk apa aku terus hidup...","Pak Ustadz: Assalamu'alaikum, Nak.","Adil: Pergi! Jangan dekati saya!","Pak Ustadz: Turunlah, Nak. Apapun masalahmu, ini bukan jalannya.","Pak Ustadz: Hidupmu jauh lebih berharga dari itu.","Adil: Berharga? Hidup yang hancur karena utang?","Adil: Hidup yang isinya hanya gali lubang tutup lubang? Bapak tidak akan mengerti!","Pak Ustadz: Bapak mungkin tidak mengerti sepenuhnya apa yang kamu rasakan...","Pak Ustadz: Tapi Bapak tahu, setiap kesulitan pasti ada jalan keluarnya.","Adil: TIDAK ADA JALAN KELUAR UNTUKKU!","Adil: Utangku puluhan juta, nama baik keluarga hancur! Lebih baik aku akhiri saja!","Pak Ustadz: Nak... Dengarkan Bapak. Allah berfirman dalam Al-Qur'an...","Pak Ustadz: '...wa laa tai'asuu min rawhillah...'","Pak Ustadz: '...innahu laa yai'asu min rawhillahi illal qaumul kaafiruun.'","Pak Ustadz: Artinya, '...dan janganlah kamu berputus asa dari rahmat Allah.'","Pak Ustadz: 'Sesungguhnya tiada berputus asa dari rahmat Allah, melainkan kaum yang kafir.'","Pak Ustadz: Apakah kamu mau termasuk orang yang putus asa dari rahmat-Nya?","Pak Ustadz: Masalahmu besar, Bapak percaya. Tapi rahmat dan ampunan Allah jauh lebih besar.","Pak Ustadz: Mari, turunlah. Ikut Bapak ke masjid, kita tenangkan hati bersama.",""};
//    subtitleDurations = new int[subtitleList.length];
//    int baseTime = 1500, timePerChar = 75;
//    for (int i = 0; i < subtitleList.length; i++) subtitleDurations[i] = baseTime + (subtitleList[i].length() * timePerChar);
//  }
  
//  void drawSubtitle() {
//    if (subtitleList[currentSubtitleIndex].isEmpty()) return;
//    if (conversationStarted) {
//      if (p.millis() - lastSubtitleChangeTime > subtitleDurations[currentSubtitleIndex]) {
//        if (currentSubtitleIndex < subtitleList.length - 1) { currentSubtitleIndex++; currentFullText = ""; }
//      }
//    }
//    String fullText = subtitleList[currentSubtitleIndex];
//    if (!fullText.equals(currentFullText)) { currentFullText = fullText; charsToShow = 0; lastSubtitleChangeTime = p.millis(); }
//    int maxChars = p.min(fullText.length(), (p.millis() - lastSubtitleChangeTime) / 70);
//    if(maxChars > charsToShow) charsToShow = maxChars;
//    String vis = fullText.substring(0, p.min(charsToShow, fullText.length()));
//    p.textSize(24); float pad=20, bW=p.min(p.textWidth(vis)+pad*2, p.width*0.8f), bH=80, bX=(p.width-bW)/2, bY=p.height-bH-30;
//    p.fill(0,160); p.noStroke(); p.rect(bX,bY,bW,bH,10); p.fill(255); p.textAlign(p.CENTER, p.CENTER);
//    p.text(vis, bX, bY, bW, bH);
//  }

//  // (Salin fungsi drawAwanAndBurung, drawAwan, drawBurung, drawWaterWaves, drawPembatasJembatan, dan drawPembatasJembatan2 dari Scene1)
//  void drawAwanAndBurung() {
//    for (int i = 0; i < jumlahAwan; i++) {
//      drawAwan(awanX[i], awanY[i], awanSize[i]);
//      awanX[i] -= awanSpeed[i];
//      if (awanX[i] < -300) { awanX[i] = p.width + p.random(50, 150); awanY[i] = p.random(30, 150); }
//    }
//    for (int i = 0; i < jumlahBurung; i++) {
//      float yOffset = p.sin(p.frameCount * 0.05f + burungWaveOffset[i]) * 15;
//      drawBurung(burungX[i], burungY[i] + yOffset);
//      burungX[i] -= burungSpeed[i];
//      if (burungX[i] < -30) { burungX[i] = p.width + p.random(100, 400); burungY[i] = p.random(80, 250); }
//    }
//  }
//  void drawAwan(float x, float y, float s) {
//    p.noStroke(); p.fill(255, 200); p.ellipse(x, y, 100 * s, 60 * s); p.ellipse(x + 40 * s, y - 20 * s, 80 * s, 50 * s);
//    p.ellipse(x + 80 * s, y, 100 * s, 60 * s); p.ellipse(x + 40 * s, y + 20 * s, 90 * s, 50 * s);
//    p.ellipse(x - 50 * s, y + 15 * s, 80 * s, 45 * s); p.ellipse(x + 130 * s, y + 10 * s, 90 * s, 55 * s);
//  }
//  void drawBurung(float x, float y) {
//    p.stroke(50); p.strokeWeight(2); p.noFill(); p.arc(x, y, 20, 15, p.PI, p.TWO_PI); p.arc(x + 20, y, 20, 15, p.PI, p.TWO_PI);
//  }
//  void drawWaterWaves() {
//    p.noFill();
//    for (int y_base = waterLevel; y_base < waterBottom; y_base += 7) {
//      float persp = p.map(y_base, waterLevel, waterBottom, 0, 1), amp = p.lerp(1.5f, 4, persp), speed = p.lerp(0.02f, 0.04f, persp);
//      p.strokeWeight(p.lerp(1.5f, 2.5f, persp)); p.stroke(255, p.map(persp, 0, 1, 90, 40));
//      float startX = p.map(y_base, waterLevel, waterBottom, leftBankTopX, leftBankBottomX), endX;
//      if (y_base < waterUpperMidY) endX = p.map(y_base, waterLevel, waterUpperMidY, rightBankTopX, rightBankUpperMidX);
//      else if (y_base < waterMidY) endX = p.map(y_base, waterUpperMidY, waterMidY, rightBankUpperMidX, rightBankMidX);
//      else endX = p.map(y_base, waterMidY, waterBottom, rightBankMidX, rightBankBottomX);
//      p.beginShape();
//      for (float x = startX; x <= endX; x += 10) p.vertex(x, y_base + p.sin(x * waveFrequency + p.frameCount * speed) * amp);
//      p.endShape();
//    }
//  }
//  void drawPembatasJembatan() {
//    float bY=470, h=70, t=14; p.noStroke(); p.fill(120,75,45); p.rect(0,bY,p.width,t); p.fill(90,55,30,80); p.rect(0,bY+t,p.width,3);
//    p.fill(120,75,45); p.rect(0,bY+h,p.width,t); p.fill(90,55,30,80); p.rect(0,bY+h+t,p.width,3);
//    for(int i=0; i<=12; i++){p.fill(135,80,50); p.rect(i*(p.width/12f)-7,bY,14,h+t);}
//  }
//  void drawPembatasJembatan2() {
//    float bY=400, h=70, t=14; p.noStroke(); p.fill(120,75,45); p.rect(0,bY,p.width,t); p.fill(90,55,30,80); p.rect(0,bY+t,p.width,3);
//    p.fill(120,75,45); p.rect(0,bY+h,p.width,t); p.fill(90,55,30,80); p.rect(0,bY+h+t,p.width,3);
//    for(int i=0; i<=12; i++){p.fill(135,80,50); p.rect(i*(p.width/12f)-7,bY,14,h+t);}
//  }
//}
