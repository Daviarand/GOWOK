import processing.sound.*;

class Scene5 {
  PApplet p;

  String[] subtitleList;
  int[] subtitleDurations;
  int currentSubtitleIndex;
  int lastSubtitleChangeTime;
  int charsToShow;
  String currentFullText;

  PImage bg, adilJalan1, adilJalan2, ustadzJalan1, ustadzJalan2;
  PImage adilDuduk1, adilDuduk2, ustadzDuduk1, ustadzDuduk2;
  float scale = 0.3f;
  float scaledWidth, scaledHeight;
  float adilX, adilY, ustadzX, ustadzY;
  int frameCounter, frameInterval = 10;
  boolean sudahSampai;
  String statusAdil = "jalan", statusUstadz = "jalan";
  int dudukFrameCounter = 0, dudukInterval = 30, jedaAdilMulaiDuduk = 0;
  int jumlahAwan = 6;
  float[] awanX, awanY, awanSpeed, awanSize;
  int jumlahBurung = 5;
  float[] burungX, burungY, burungSpeed;
  int jumlahRumput = 500;
  float[] rumputX, rumputY, rumputHeight, rumputPhase;
  float[] burungDiamX = {580, 620, 650}, burungDiamY = {230, 225, 235};
  int jumlahSapi = 5;
  float[] sapiX, sapiY, sapiSpeed;
  int[] sapiArah;
boolean sudahDuduk = false;
float posisiDudukY = 300; // atau berapa pun posisi duduk mereka



  SoundFile suaraJalanKaki;

  Scene5(PApplet parent) {
    p = parent;

    awanX = new float[jumlahAwan]; awanY = new float[jumlahAwan]; awanSpeed = new float[jumlahAwan]; awanSize = new float[jumlahAwan];
    burungX = new float[jumlahBurung]; burungY = new float[jumlahBurung]; burungSpeed = new float[jumlahBurung];
    sapiX = new float[jumlahSapi]; sapiY = new float[jumlahSapi]; sapiSpeed = new float[jumlahSapi]; sapiArah = new int[jumlahSapi];
    rumputX = new float[jumlahRumput]; rumputY = new float[jumlahRumput]; rumputHeight = new float[jumlahRumput]; rumputPhase = new float[jumlahRumput];

    bg = p.loadImage("Traditional Mosque in Rural Landscape (1).png");
    adilJalan1=p.loadImage("adiljalan1.png"); adilJalan2=p.loadImage("adiljalan2.png");
    ustadzJalan1=p.loadImage("ustadzjalan1.png"); ustadzJalan2=p.loadImage("ustadzjalan2.png");
    adilDuduk1=p.loadImage("Adilduduk1.png"); adilDuduk2=p.loadImage("Adilduduk2.png");
    ustadzDuduk1=p.loadImage("Ustadduduk1.png"); ustadzDuduk2=p.loadImage("Ustadduduk2.png");
    suaraJalanKaki = new SoundFile(p, "jalanKaki.mp3");
    suaraJalanKaki.amp(0.6f);

    initializeSubtitles();
  }

  void reset() {
    scaledWidth = adilJalan1.width * scale;
    scaledHeight = adilJalan1.height * scale;
    adilX = p.width + 50;
    ustadzX = adilX + 100;
    adilY = 630;
    ustadzY = 630;
    frameCounter = 0;
    sudahSampai = false;
    statusAdil = "jalan";
    statusUstadz = "jalan";
    dudukFrameCounter = 0;

    for (int i = 0; i < jumlahAwan; i++) {awanX[i]=p.map(i,0,jumlahAwan-1,0,p.width);awanY[i]=p.random(50,200);awanSpeed[i]=p.random(0.3f,1.2f);awanSize[i]=p.random(1.2f,2.5f);}
    for (int i = 0; i < jumlahBurung; i++) {burungX[i]=p.random(p.width,p.width+800);burungY[i]=p.random(80,250);burungSpeed[i]=p.random(1.5f,3.5f);}
    for (int i = 0; i < jumlahSapi; i++) {sapiX[i]=p.random(50,0);sapiY[i]=p.random(610,650);sapiSpeed[i]=p.random(0.2f,0.6f);sapiArah[i]=(p.random(1)>0.5)?1:-1;}
    for (int i = 0; i < jumlahRumput; i++) {rumputX[i]=p.random(p.width);rumputY[i]=p.random(700,p.height);rumputHeight[i]=p.random(10,25);rumputPhase[i]=p.random(p.TWO_PI);}

    if(!suaraJalanKaki.isPlaying()){
      suaraJalanKaki.loop();
    }

    currentSubtitleIndex = 0;
    lastSubtitleChangeTime = p.millis();
    charsToShow = 0;
    currentFullText = "";
  }

  void initializeSubtitles() {
    subtitleList = new String[]{
      "Adil: Terima kasih sudah mau mendengar saya, Pak Ustadz.",
      "Adil: Hati saya memang masih kacau… tapi entah kenapa, duduk di sini rasanya lebih ringan.",
      "Pak Ustadz: Masjid memang tempat yang paling baik untuk menenangkan hati, Nak.",
      "Pak Ustadz: Di sini, kita lebih dekat pada-Nya, dan pada saat kita mendekat, Allah pasti menyambut.",
      "Adil: Saya masih takut, Pak. Takut menghadapi semuanya… Takut dihakimi orang… Takut gagal lagi...",
      "Pak Ustadz: Rasa takut itu wajar. Tapi jangan biarkan ia menenggelamkanmu.",
      "Pak Ustadz: Kita semua pernah jatuh, Adil. Tapi orang yang kuat adalah yang mau bangkit kembali.",
      "Pak Ustadz: Dengar itu, Nak? Panggilan-Nya… Allah masih memanggilmu untuk kembali.",
      "Adil: Saya… boleh ikut salat, Pak?",
      "Pak Ustadz: Bukan hanya boleh. Hatimu sudah sangat rindu untuk bersujud, Nak.",
      "Pak Ustadz: Ayo… kita wudhu dulu, lalu kita salat berjamaah.",
      ""
    };

    subtitleDurations = new int[subtitleList.length];
    int baseTime = 1500;
    int timePerChar = 75;

    for (int i = 0; i < subtitleList.length; i++) {
      subtitleDurations[i] = baseTime + (subtitleList[i].length() * timePerChar);
    }
  }

  void drawSubtitle() {
    if (subtitleList[currentSubtitleIndex].isEmpty()) return;

    if (p.millis() - lastSubtitleChangeTime > subtitleDurations[currentSubtitleIndex]) {
      if (currentSubtitleIndex < subtitleList.length - 1) {
        currentSubtitleIndex++;
        currentFullText = "";
      }
    }

    String fullText = subtitleList[currentSubtitleIndex];

    if (!fullText.equals(currentFullText)) {
      currentFullText = fullText;
      charsToShow = 0;
      lastSubtitleChangeTime = p.millis();
    }

    int maxChars = p.min(fullText.length(), (p.millis() - lastSubtitleChangeTime) / 70);
    if (maxChars > charsToShow) charsToShow = maxChars;

    String vis = fullText.substring(0, p.min(charsToShow, fullText.length()));

    p.textSize(24);
    float pad = 20;
    float bW = p.min(p.textWidth(vis) + pad * 2, p.width * 0.8f);
    float bH = 80;
    float bX = (p.width - bW) / 2;
    float bY = p.height - bH - 30;

    p.fill(0, 160);
    p.noStroke();
    p.rect(bX, bY, bW, bH, 10);

    p.fill(255);
    p.textAlign(p.CENTER, p.CENTER);
    p.text(vis, bX, bY, bW, bH);
  }


  // Metode run() (menggantikan draw())
  void run() {
    p.background(255);
    p.imageMode(p.CORNER);
    p.image(bg, 0, 0, p.width, p.height);
    p.imageMode(p.CENTER);
    drawRumput();
    drawBurungDiam();
    updateAndDrawSapi();
    drawKotakInfaq();
    p.imageMode(p.CORNER);
    for (int i = 0; i < jumlahAwan; i++) {drawAwan(awanX[i], awanY[i], awanSize[i]);awanX[i]-=awanSpeed[i];if(awanX[i]<-200)awanX[i]=p.width+p.random(100,300);}
    for (int i = 0; i < jumlahBurung; i++) {drawBurung(burungX[i], burungY[i]);burungX[i]-=burungSpeed[i];if(burungX[i]<-50)burungX[i]=p.width+p.random(100,400);}
    p.imageMode(p.CENTER);
    
    float targetAdilX = p.width/2.f - 100;
    float targetUstadzX = p.width/2.f - 10;
    if (!sudahSampai) {
      if (adilX<=targetAdilX) {
        adilX=targetAdilX;ustadzX=targetUstadzX;sudahSampai=true;suaraJalanKaki.stop();
      } else {
        adilX-=2.5;ustadzX-=2.5;
      }
    }
    if (!sudahSampai) {
      if ((frameCounter/frameInterval)%2==0){p.image(adilJalan1,adilX,adilY,scaledWidth,scaledHeight);p.image(ustadzJalan1,ustadzX,ustadzY,scaledWidth,scaledHeight);}
      else {p.image(adilJalan2,adilX,adilY,scaledWidth,scaledHeight);p.image(ustadzJalan2,ustadzX,ustadzY,scaledWidth,scaledHeight);}
    } else {
      float dudukScaleAdil=0.20f, dWA=adilDuduk1.width*dudukScaleAdil, dHA=adilDuduk1.height*dudukScaleAdil;
      float dudukScaleUstadz=0.10f, dWU=ustadzDuduk1.width*dudukScaleUstadz, dHU=ustadzDuduk1.height*dudukScaleUstadz;
      float dudukY = 600;
      if(statusUstadz.equals("jalan")&&statusAdil.equals("jalan")){statusUstadz="dudukTransisi";dudukFrameCounter=0;}
      if(statusUstadz.equals("dudukTransisi")){if(dudukFrameCounter<dudukInterval)p.image(ustadzDuduk1,ustadzX,dudukY,dWU,dHU);else statusUstadz="dudukAkhir";}
      if(statusUstadz.equals("dudukAkhir")){p.image(ustadzDuduk2,ustadzX,dudukY,dWU,dHU);}
      if(statusAdil.equals("jalan")){p.image(adilJalan1,adilX,adilY,scaledWidth,scaledHeight);}
      if(dudukFrameCounter>=jedaAdilMulaiDuduk&&statusAdil.equals("jalan")){statusAdil="dudukTransisi";}
      if(statusAdil.equals("dudukTransisi")){int adilFrame=dudukFrameCounter-jedaAdilMulaiDuduk;if(adilFrame<dudukInterval)p.image(adilDuduk1,adilX,dudukY,dWA,dHA);else statusAdil="dudukAkhir";}
      if(statusAdil.equals("dudukAkhir")){p.image(adilDuduk2,adilX,dudukY,dWA,dHA);}
      dudukFrameCounter++;
    }
    frameCounter++;
    
if (statusAdil.equals("dudukAkhir") && statusUstadz.equals("dudukAkhir")) {
  drawSubtitle();
}


if (currentSubtitleIndex == subtitleList.length - 1) {
  if (p.millis() - lastSubtitleChangeTime > 2000) {
    ((scene1)p).goToNextScene();
  }
}

    
  }

  // === SEMUA FUNGSI GAMBAR ASLI ANDA ADA DI SINI, TIDAK DIUBAH ===
  void drawAwan(float x,float y,float s){p.noStroke();p.fill(255,220);p.ellipse(x,y,60*s,40*s);p.ellipse(x+25*s,y-10*s,50*s,35*s);p.ellipse(x+50*s,y,60*s,40*s);}
  void drawBurung(float x,float y){p.fill(30);p.noStroke();p.triangle(x,y,x-10,y-5,x-5,y);p.triangle(x,y,x+10,y-5,x+5,y);}
  void drawBurungDiam(){for(int i=0;i<burungDiamX.length;i++){float x=burungDiamX[i],y=burungDiamY[i]+150;p.fill(30);p.noStroke();p.ellipse(x,y,10,10);p.ellipse(x+6,y-3,6,6);p.triangle(x+9,y-3,x+13,y-1,x+9,y+1);}}
  void updateAndDrawSapi(){for(int i=0;i<jumlahSapi;i++){sapiX[i]+=sapiSpeed[i]*sapiArah[i];if(sapiX[i]<50||sapiX[i]>200){sapiArah[i]*=-1;}drawSapi(sapiX[i],sapiY[i],sapiArah[i]);}}
  void drawSapi(float x,float y,int arah){p.pushMatrix();p.translate(x,y);p.scale(0.20f);if(arah==-1){p.scale(-1,1);}p.noStroke();p.fill(255);p.ellipse(0,0,150,90);p.fill(30);p.ellipse(-30,-10,40,30);p.ellipse(25,15,30,25);p.fill(255);p.ellipse(75,-25,60,50);p.fill(30);p.ellipse(90,-30,8,8);p.stroke(30);p.strokeWeight(10);p.line(-40,20,-40,60);p.line(40,20,40,60);p.strokeWeight(8);p.line(-30,20,-30,58);p.line(30,20,30,58);p.popMatrix();}
  void drawKotakInfaq(){float kX=688,kY=601,kW=40,kH=50;p.fill(139,69,19);p.stroke(90,40,10);p.strokeWeight(2);p.rect(kX,kY,kW,kH,5);p.stroke(0);p.strokeWeight(3);p.line(kX+10,kY+10,kX+kW-10,kY+10);p.fill(255);p.textAlign(p.CENTER,p.CENTER);p.textSize(12);p.text("INFAQ",kX+kW/2,kY+kH/2+5);}
  void drawRumput(){for(int i=0;i<jumlahRumput;i++){float sway=p.sin(p.frameCount*0.03f+rumputPhase[i])*5;p.stroke(139,190,109,140);p.line(rumputX[i],rumputY[i],rumputX[i]+sway,rumputY[i]-rumputHeight[i]);}}
}
