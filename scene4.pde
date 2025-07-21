//import processing.sound.*;

//class Scene4 {
//  PApplet p;

//  // Aset & Variabel
//  PImage bg, adilJalan1, adilJalan2, ustadzJalan1, ustadzJalan2;
//  SoundFile suaraJalanKaki;
//  String[] subtitleList;
//  int[] subtitleDurations;
//  int currentSubtitleIndex;
//  long lastSubtitleChangeTime;
//  int charsToShow;
//  String currentFullText;
  
//  // Variabel Lingkungan & Karakter
//  int jumlahAwan = 5; float[] awanX, awanY, awanSpeed, awanSize;
//  int jumlahBurung = 15; float[] burungX, burungY, burungSpeed;
//  float scale = 0.4f; float scaledWidth, scaledHeight;
//  float adilX, adilY, ustadzX, ustadzY; float karakterSpeed = 2.0f;
//  int frameCounter = 0; int frameInterval = 10;
//  int jumlahRumput = 700; float[] rumputX, rumputY, rumputHeight, rumputPhase;
//  int jumlahAyam = 4; float[] ayamX, ayamY, ayamSpeed; boolean[] ayamKanan;

//  Scene4(PApplet parent) {
//    p = parent;
    
//    // Inisialisasi Array
//    awanX = new float[jumlahAwan]; awanY = new float[jumlahAwan]; awanSpeed = new float[jumlahAwan]; awanSize = new float[jumlahAwan];
//    burungX = new float[jumlahBurung]; burungY = new float[jumlahBurung]; burungSpeed = new float[jumlahBurung];
//    rumputX = new float[jumlahRumput]; rumputY = new float[jumlahRumput]; rumputHeight = new float[jumlahRumput]; rumputPhase = new float[jumlahRumput];
//    ayamX = new float[jumlahAyam]; ayamY = new float[jumlahAyam]; ayamSpeed = new float[jumlahAyam]; ayamKanan = new boolean[jumlahAyam];

//    // Muat Aset Khusus Scene 4
//    suaraJalanKaki = new SoundFile(p, "jalanKaki.mp3");
//    suaraJalanKaki.amp(0.6f);
//    bg = p.loadImage("Jalanan.png");
//    adilJalan1 = p.loadImage("adiljalan1.png"); adilJalan2 = p.loadImage("adiljalan2.png");
//    ustadzJalan1 = p.loadImage("ustadzjalan1.png"); ustadzJalan2 = p.loadImage("ustadzjalan2.png");

//    initializeSubtitles();
//    initializeEnvironment();
//  }

//  void reset() {
//    frameCounter = 0;
//    currentSubtitleIndex = 0;
//    lastSubtitleChangeTime = p.millis();
//    charsToShow = 0;
//    currentFullText = "";

//    // Reset Posisi Karakter
//    scaledWidth = adilJalan1.width * scale;
//    scaledHeight = adilJalan1.height * scale;
//    adilX = p.width + 50;
    
//    // MODIFIKASI DI SINI: Ubah angka di akhir untuk mengatur jarak
//    ustadzX = adilX + scaledWidth - 310; 
    
//    adilY = p.height - scaledHeight - 40;
//    ustadzY = adilY;
    
//    // Mulai audio langkah kaki
//    if (!suaraJalanKaki.isPlaying()) {
//      suaraJalanKaki.loop();
//    }
//  }

//  void run() {
//    p.image(bg, 0, 0, p.width, p.height);
//    drawEnvironment();
//    updateAndDrawCharacters();
//    drawSubtitle();
//    frameCounter++;
//  }

//  // === SEMUA FUNGSI ASLI ANDA ADA DI SINI, HANYA DIBUNGKUS ===
//  void drawEnvironment(){for(int i=0;i<jumlahAwan;i++){drawAwan(awanX[i],awanY[i],awanSize[i]);awanX[i]-=awanSpeed[i];if(awanX[i]<-300)awanX[i]=p.width+300;}for(int i=0;i<jumlahBurung;i++){drawBurung(burungX[i],burungY[i]);burungX[i]-=burungSpeed[i];if(burungX[i]<-30){burungX[i]=p.width+p.random(100,400);burungY[i]=p.random(80,250);}}for(int i=0;i<jumlahRumput;i++){float sway=p.sin(frameCounter*0.03f+rumputPhase[i])*5;p.stroke(139,190,109,140);p.line(rumputX[i],rumputY[i],rumputX[i]+sway,rumputY[i]-rumputHeight[i]);}for(int i=0;i<jumlahAyam;i++){drawAyam(ayamX[i],ayamY[i],ayamKanan[i]);if(ayamKanan[i]){ayamX[i]+=ayamSpeed[i];if(ayamX[i]>p.width+20)ayamX[i]=-20;}else{ayamX[i]-=ayamSpeed[i];if(ayamX[i]<-20)ayamX[i]=p.width+20;}}}
//  void updateAndDrawCharacters() {
//    // Gerakkan karakter ke kiri
//    adilX -= karakterSpeed;
//    ustadzX -= karakterSpeed;

//    // Animasi jalan
//    if ((frameCounter / frameInterval) % 2 == 0) {
//      p.image(adilJalan1, adilX, adilY, scaledWidth, scaledHeight);
//      p.image(ustadzJalan1, ustadzX, ustadzY, scaledWidth, scaledHeight);
//    } else {
//      p.image(adilJalan2, adilX, adilY, scaledWidth, scaledHeight);
//      p.image(ustadzJalan2, ustadzX, ustadzY, scaledWidth, scaledHeight);
//    }
    
//    // BARU: Pemicu untuk pindah ke adegan 5 saat karakter keluar layar
//    if (adilX < -scaledWidth) {
//      suaraJalanKaki.stop(); // Hentikan suara langkah kaki sebelum pindah
//      ((scene1)p).goToNextScene();
//    }
//  }
//  void drawAwan(float x,float y,float s){p.noStroke();p.fill(255,230);p.ellipse(x,y,100*s,60*s);p.ellipse(x+40*s,y-20*s,80*s,50*s);p.ellipse(x+80*s,y,100*s,60*s);}
//  void drawBurung(float x,float y){p.stroke(50);p.strokeWeight(2);p.noFill();p.arc(x,y,20,15,p.PI,p.TWO_PI);p.arc(x+20,y,20,15,p.PI,p.TWO_PI);}
//  void drawAyam(float x,float y,boolean kanan){p.pushMatrix();p.translate(x,y);if(!kanan)p.scale(-1,1);p.noStroke();p.fill(255,255,200);p.ellipse(0,0,20,15);p.ellipse(10,-5,10,10);p.fill(255,150,0);p.triangle(15,-5,18,-3,15,-1);p.fill(255,0,0);p.ellipse(12,-10,4,4);p.ellipse(10,-12,4,4);p.stroke(200,120,0);p.line(-5,8,-5,12);p.line(5,8,5,12);p.popMatrix();}
//  void initializeSubtitles(){subtitleList=new String[]{"Adil: Menang sekali, kalahnya sepuluh kali. Uang habis, saya panik.","Adil: Satu-satunya jalan ya pinjaman online. Mudah, tapi bunganya mencekik.","Adil: Gali lubang, tutup lubang, sampai akhirnya tak ada lagi yang bisa digali.","Pak Ustadz: Setan memang pandai menghias maksiat hingga terlihat indah.","Pak Ustadz: Tapi di setiap kesulitan, Allah sudah janjikan solusinya.","Adil: Tapi bagaimana caranya saya menyelesaikan semua ini, Pak? Mustahil rasanya.","Pak Ustadz: Ingat firman-Nya, Nak... 'Fa inna ma'al 'usri yusra'.","Pak Ustadz: 'Karena sesungguhnya sesudah kesulitan itu ada kemudahan'.","Pak Ustadz: Langkah pertamamu adalah bertaubat dengan sungguh-sungguh.","Adil: Lalu utang-utang saya?","Pak Ustadz: Kedua, kita hadapi, jangan lari. Bicaralah pada orang tuamu.","Pak Ustadz: Kita cari jalan bersama, sedikit demi sedikit pasti akan lunas.","Pak Ustadz: Dan yang terpenting, jangan tinggalkan shalat.","Pak Ustadz: Kamu kuat, Nak. Kamu bisa melewati ini dengan pertolongan-Nya.",""};subtitleDurations=new int[subtitleList.length];int bT=1500,tPC=80;for(int i=0;i<subtitleList.length;i++)subtitleDurations[i]=bT+(subtitleList[i].length()*tPC);}
//  void initializeEnvironment(){for(int i=0;i<jumlahAwan;i++){awanX[i]=p.random(p.width);awanY[i]=p.random(50,150);awanSpeed[i]=p.random(0.3f,1.0f);awanSize[i]=p.random(1.2f,2.2f);}for(int i=0;i<jumlahBurung;i++){burungX[i]=p.random(p.width,p.width+800);burungY[i]=p.random(80,250);burungSpeed[i]=p.random(2.5f,4.5f);}for(int i=0;i<jumlahRumput;i++){rumputX[i]=p.random(p.width);rumputY[i]=p.random(500,p.height);rumputHeight[i]=p.random(10,25);rumputPhase[i]=p.random(p.TWO_PI);}for(int i=0;i<jumlahAyam;i++){ayamX[i]=p.random(p.width);ayamY[i]=p.random(600,710);ayamSpeed[i]=p.random(0.5f,1.5f);ayamKanan[i]=p.random(1)>0.5;}}
//  void drawSubtitle(){if(subtitleList[currentSubtitleIndex].isEmpty())return;if(p.millis()-lastSubtitleChangeTime>subtitleDurations[currentSubtitleIndex]){if(currentSubtitleIndex<subtitleList.length-1){currentSubtitleIndex++;currentFullText="";}}String fT=subtitleList[currentSubtitleIndex];if(!fT.equals(currentFullText)){currentFullText=fT;charsToShow=0;lastSubtitleChangeTime=p.millis();}long eT=p.millis()-lastSubtitleChangeTime;int mC=p.min(fT.length(),(int)(eT/50));if(mC>charsToShow)charsToShow=mC;String vT=fT.substring(0,p.min(charsToShow,fT.length()));p.textSize(24);float pad=20,bW=p.min(p.textWidth(vT)+pad*2,p.width*0.8f),bH=80,bX=(p.width-bW)/2,bY=p.height-bH-30;p.fill(0,160);p.noStroke();p.rect(bX,bY,bW,bH,10);p.fill(255);p.textAlign(p.CENTER,p.CENTER);p.text(vT,bX,bY,bW,bH);}
//}
