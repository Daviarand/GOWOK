//import processing.sound.*;

//class Scene3 {
//  PApplet p;

//  // Aset
//  PImage bg, karakterAdil, adilJalan1, adilJalan2, ustadzJalan1, ustadzJalan2, ustadzDiam;
//  SoundFile suaraJalanKaki;

//  // State Internal
//  int state;
//  int frameCounter;
//  int conversationTimer;
//  boolean showSubtitles;
//  float adilX, adilY, ustadzX, ustadzY;
  
//  // Subtitle
//  String[] subtitleList;
//  int[] subtitleDurations;
//  int currentSubtitleIndex;
//  long lastSubtitleChangeTime;
//  int charsToShow;
//  String currentFullText;

//  // Variabel Lingkungan
//  int jumlahAwan = 5; float[] awanX, awanY, awanSpeed, awanSize;
//  int jumlahBurung = 20; float[] burungX, burungY, burungSpeed, burungWaveOffset;
  
//  final float scale = 0.4f;
//  final int frameInterval = 10;

//  Scene3(PApplet parent) {
//    p = parent;
    
//    // Inisialisasi Array
//    awanX = new float[jumlahAwan]; awanY = new float[jumlahAwan]; awanSpeed = new float[jumlahAwan]; awanSize = new float[jumlahAwan];
//    burungX = new float[jumlahBurung]; burungY = new float[jumlahBurung]; burungSpeed = new float[jumlahBurung]; burungWaveOffset = new float[jumlahBurung];

//    // Muat Aset
//    bg = p.loadImage("tanpaPembatas2.png");
//    karakterAdil = p.loadImage("adildiam.png");
//    adilJalan1 = p.loadImage("adiljalan1.png");
//    adilJalan2 = p.loadImage("adiljalan2.png");
//    ustadzJalan1 = p.loadImage("ustadzjalan1.png");
//    ustadzJalan2 = p.loadImage("ustadzjalan2.png");
//    ustadzDiam = p.loadImage("ustaddiam.png");
//    suaraJalanKaki = new SoundFile(p, "jalanKaki.mp3");
//    suaraJalanKaki.amp(0.6f);

//    initializeSubtitles();
//    initializeEnvironment();
//  }

//  void reset() {
//    state = 1;
//    frameCounter = 0;
//    conversationTimer = 120; // Jeda 2 detik sebelum turun
//    showSubtitles = false;
//    currentSubtitleIndex = 0;
//    lastSubtitleChangeTime = 0;
//    charsToShow = 0;
//    currentFullText = "";

//    // Reset Posisi Karakter
//    float adilScaledHeight = karakterAdil.height * scale;
//    adilX = (p.width - (karakterAdil.width * scale)) / 2;
//    adilY = p.height - adilScaledHeight - 180; // Posisi awal di atas pagar
//    float ustadzScaledHeight = ustadzJalan1.height * scale;
//    ustadzX = adilX + 150;
//    ustadzY = 630 - ustadzScaledHeight;
//  }

//  void run() {
//    p.image(bg, 0, 0, p.width, p.height);
//    drawAwanAndBurung();
//    drawWaterWaves();
    
//    switch (state) {
//      case 1: updateStateConversation(); break;
//      case 2: updateStateAdilGettingDown(); break;
//      case 3: updateStateWalkingAway(); break;
//    }
    
//    drawSceneLayers();
//    if (showSubtitles) {
//      drawSubtitle();
//    }
//    frameCounter++;
//  }

//  // === METODE UNTUK SETIAP STATE INTERNAL ===
//  void updateStateConversation() {
//    conversationTimer--;
//    if (conversationTimer <= 0) state = 2;
//  }
//  void updateStateAdilGettingDown() {
//    adilY = p.lerp(adilY, ustadzY, 0.08f);
//    float destX = ustadzX - (karakterAdil.width * scale) + 320;
//    adilX = p.lerp(adilX, destX, 0.08f);
//    if (p.abs(adilY - ustadzY) < 1 && p.abs(adilX - destX) < 1) {
//      adilY = ustadzY;
//      adilX = destX;
//      state = 3;
//      suaraJalanKaki.loop();
//      showSubtitles = true;
//      lastSubtitleChangeTime = p.millis();
//    }
//  }
//  void updateStateWalkingAway() {
//    adilX -= 2;
//    ustadzX -= 2;
    
//    // BARU: Pemicu untuk pindah ke adegan 4 saat karakter keluar dari layar
//    if (ustadzX < - (ustadzJalan1.width * scale)) {
//      suaraJalanKaki.stop(); // Hentikan suara langkah kaki sebelum pindah
//      ((scene1)p).goToNextScene();
//    }
//  }

//  // === METODE-METODE GAMBAR ===
//  void drawSceneLayers() {
//    drawPembatasJembatan2();
//    drawUstadz();
//    if (state < 2) {
//      drawPembatasJembatan();
//      drawAdil();
//    } else {
//      drawAdil();
//      drawPembatasJembatan();
//    }
//  }
//  void drawAdil() {
//    float w=karakterAdil.width*scale, h=karakterAdil.height*scale;
//    if (state < 3) p.image(karakterAdil, adilX, adilY, w, h);
//    else {
//      if ((frameCounter/frameInterval)%2==0) p.image(adilJalan1, adilX, adilY, w, h);
//      else p.image(adilJalan2, adilX, adilY, w, h);
//    }
//  }
//  void drawUstadz() {
//    float w=ustadzJalan1.width*scale, h=ustadzJalan1.height*scale;
//    if (state < 3) p.image(ustadzDiam, ustadzX, ustadzY, w, h);
//    else {
//      if ((frameCounter/frameInterval)%2==0) p.image(ustadzJalan1, ustadzX, ustadzY, w, h);
//      else p.image(ustadzJalan2, ustadzX, ustadzY, w, h);
//    }
//  }
  
//  // (Salin semua fungsi gambar lingkungan dari Scene1/Scene2 ke sini)
//  // drawAwanAndBurung, drawAwan, drawBurung, drawWaterWaves, drawPembatasJembatan, drawPembatasJembatan2
//  void drawAwanAndBurung(){for(int i=0;i<jumlahAwan;i++){drawAwan(awanX[i],awanY[i],awanSize[i]);awanX[i]-=awanSpeed[i];if(awanX[i]<-300){awanX[i]=p.width+p.random(50,150);awanY[i]=p.random(30,150);}}for(int i=0;i<jumlahBurung;i++){float yOffset=p.sin(p.frameCount*0.05f+burungWaveOffset[i])*15;drawBurung(burungX[i],burungY[i]+yOffset);burungX[i]-=burungSpeed[i];if(burungX[i]<-30){burungX[i]=p.width+p.random(100,400);burungY[i]=p.random(80,250);}}}
//  void drawAwan(float x,float y,float s){p.noStroke();p.fill(255,200);p.ellipse(x,y,100*s,60*s);p.ellipse(x+40*s,y-20*s,80*s,50*s);p.ellipse(x+80*s,y,100*s,60*s);p.ellipse(x+40*s,y+20*s,90*s,50*s);p.ellipse(x-50*s,y+15*s,80*s,45*s);p.ellipse(x+130*s,y+10*s,90*s,55*s);}
//  void drawBurung(float x,float y){p.stroke(50);p.strokeWeight(2);p.noFill();p.arc(x,y,20,15,p.PI,p.TWO_PI);p.arc(x+20,y,20,15,p.PI,p.TWO_PI);}
//  void drawWaterWaves(){p.noFill();for(int y_base=550;y_base<768;y_base+=7){float p_val=p.map(y_base,550,768,0,1),amp=p.lerp(1.5f,4,p_val),speed=p.lerp(0.02f,0.04f,p_val);p.strokeWeight(p.lerp(1.5f,2.5f,p_val));p.stroke(255,p.map(p_val,0,1,90,40));float startX=p.map(y_base,550,768,620,-700),endX;if(y_base<620)endX=p.map(y_base,550,620,900,1230);else if(y_base<690)endX=p.map(y_base,620,690,1230,1100);else endX=p.map(y_base,690,768,1100,850);p.beginShape();for(float x=startX;x<=endX;x+=10)p.vertex(x,y_base+p.sin(x*0.04f+p.frameCount*speed)*amp);p.endShape();}}
//  void drawPembatasJembatan(){float bY=470,h=70,t=14;p.noStroke();p.fill(120,75,45);p.rect(0,bY,p.width,t);p.fill(90,55,30,80);p.rect(0,bY+t,p.width,3);p.fill(120,75,45);p.rect(0,bY+h,p.width,t);p.fill(90,55,30,80);p.rect(0,bY+h+t,p.width,3);for(int i=0;i<=12;i++){p.fill(135,80,50);p.rect(i*(p.width/12f)-7,bY,14,h+t);}}
//  void drawPembatasJembatan2(){float bY=400,h=70,t=14;p.noStroke();p.fill(120,75,45);p.rect(0,bY,p.width,t);p.fill(90,55,30,80);p.rect(0,bY+t,p.width,3);p.fill(120,75,45);p.rect(0,bY+h,p.width,t);p.fill(90,55,30,80);p.rect(0,bY+h+t,p.width,3);for(int i=0;i<=12;i++){p.fill(135,80,50);p.rect(i*(p.width/12f)-7,bY,14,h+t);}}
  
//  // === METODE SUBTITLE ===
//  void initializeSubtitles() {
//    subtitleList = new String[] {
//      "Adil: Saya... saya malu, Pak Ustadz. Saya sudah mengecewakan semua orang.",
//      "Pak Ustadz: Rasa malu karena telah berbuat dosa adalah awal dari sebuah taubat, Nak.",
//      "Pak Ustadz: Itu pertanda hatimu masih hidup dan penuh cahaya.",
//      "Adil: Semuanya dimulai dari iseng, Pak... Coba-coba judi online.",
//      "Adil: Katanya bisa dapat uang cepat.",
//      "Pak Ustadz: Dan dunia yang fana ini memang penuh dengan tipu daya.",
//      "Pak Ustadz: Tapi pintu taubat selalu terbuka.",
//      ""
//    };
//    subtitleDurations = new int[subtitleList.length];
//    int baseTime = 1500, timePerChar = 60;
//    for (int i = 0; i < subtitleList.length; i++) {
//      subtitleDurations[i] = baseTime + (subtitleList[i].length() * timePerChar);
//    }
//  }
//  void initializeEnvironment(){for(int i=0;i<jumlahAwan;i++){awanX[i]=p.map(i,0,jumlahAwan-1,0,p.width);awanY[i]=p.random(30,150);awanSpeed[i]=p.random(0.3f,1.2f);awanSize[i]=p.random(0.8f,1.5f);}for(int i=0;i<jumlahBurung;i++){burungX[i]=p.random(p.width,p.width+800);burungY[i]=p.random(80,250);burungSpeed[i]=p.random(1.5f,3.5f);burungWaveOffset[i]=p.random(p.TWO_PI);}}
//  void drawSubtitle(){if(subtitleList[currentSubtitleIndex].isEmpty())return;long elapsed=p.millis()-lastSubtitleChangeTime;if(elapsed>subtitleDurations[currentSubtitleIndex]){if(currentSubtitleIndex<subtitleList.length-1){currentSubtitleIndex++;currentFullText="";}}String fT=subtitleList[currentSubtitleIndex];if(!fT.equals(currentFullText)){currentFullText=fT;charsToShow=0;lastSubtitleChangeTime=p.millis();}long eT=p.millis()-lastSubtitleChangeTime;int mC=p.min(fT.length(),(int)(eT/50));if(mC>charsToShow)charsToShow=mC;String vT=fT.substring(0,p.min(charsToShow,fT.length()));p.textSize(24);float pad=20,bW=p.min(p.textWidth(vT)+pad*2,p.width*0.8f),bH=80,bX=(p.width-bW)/2,bY=p.height-bH-30;p.fill(0,160);p.noStroke();p.rect(bX,bY,bW,bH,10);p.fill(255);p.textAlign(p.CENTER,p.CENTER);p.text(vT,bX,bY,bW,bH);}
//}
