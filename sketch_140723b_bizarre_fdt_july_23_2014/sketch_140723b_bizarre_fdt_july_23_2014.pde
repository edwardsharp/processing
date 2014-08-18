int colonnes = 300;
int rangees = 310;
float largeurColonnes;
float hauteurRangees;
color[][] tableau2D;
int timeStamp;
int timeStampMots;
String[] tMots = {
  "obscure", "root", "executable", "header", "the",
  "problem", "with", "universals", "anti-forensics",
  "embedded", "malware", "plastic", "pill", "jars",
  "slamming", "our", "doors", "trapped", "under",
  "the", "rubble", "pile", "the", "boundaries", "as", 
  "my", "own", "emotion", "rocks", "&", "dust", "on", 
  "my", "face", "and", "where", "i", "sleep", "at", 
  "night", "my", "own", "private", "achromatic", 
  "prison", "dark", "alleyways", "and", "elevators", 
  "used", "as", "negotiating", "spaces", "for", 
  "my", "self", "which", "is", "under", "realistic", 
  "scrutiny", "anyway", "personal", "property", 
  "architected", "on", "pleasure", "profit", 
  "principals", "do", "not", "give", "that", "guy",
  "money",
  "of",
"a",
"situation",
"or",
"condition",
"extremely",
"bad",
"unpleasant",
"and",
"degrading",
"abject",
"poverty",
"synonyms",
"wretched",
"miserable",
"hopeless",
"pathetic",
"pitiful",
"pitiable",
"piteous",
"sorry",
"woeful",
"lamentable",
"degrading",
"appalling",
"atrocious",
"awful",
"abject",
"poverty",
"of",
"an",
"unhappy",
"state",
"of",
"mind",
"experienced",
"to",
"the",
"maximum",
"degree",
"his",
"letter",
"plunged",
"her",
"into",
"abject",
"misery",
"of",
"a",
"person",
"or",
"their",
"behavior",
"completely",
"without",
"pride",
"or",
"dignity",
"self",
"abasing",
"an",
"abject",
"apology",
"synonyms",
"contemptible",
"base",
"low",
"vile",
"worthless",
"debased",
"degraded",
"despicable",
"ignominious",
"mean",
"unworthy",
"ignoble",
"an",
"abject",
"sinner",
"obsequious",
"groveling",
"fawning",
"toadyish",
"servile",
"cringing",
"sycophantic",
"submissive",
"craven",
"an",
"abject",
"apology", 
"carbon", "copy", "hear","tz","obscure", "root", "executable", "header", 
"the", "problem", "with", "universals", "anti","forensics", "embedded", 
"malware", "plastic", "pill", "jars", "slamming", "our", "doors", "trapped", 
"under", "the", "rubble", "pile", "the", "boundaries", "as", "my", "own", 
"emotion", "rocks","dust", "on", "my", "face", "and", "where", "i", "sleep", 
"at", "night", "my", "own", "private", "achromatic", "prison", "dark", 
"alleyways", "and", "elevators", "used", "as", "negotiating", "spaces", 
"formy", "self", "which", "is", "under", "realistic", "scrutiny", 
"anywaypersonal", "property", "architected", "on", "pleasure", "profit", 
"principals", "do", "not", "give", "that", "guy", "moneydown", "stream", 
"wastesensing", "a", "quite", "exhaustive", "overhaul", "coming", "on", 
"to", "my", "ideology", "glitter", "swirling", "around", "in", "tanks", 
"takes", "power", "applied", "to", "move", "air", "particles", "that", 
"collide", "with", "small", "colorful", "bits", "of", "new", "reality", 
"that", "represent", "practice", "and", "stars", "and", "stripe", "that", 
"start", "again", "charging", "charging", "charging", "charging", "for", 
"their", "productivity", "charging", "for", "their", "scandal", "not", 
"enough", "violence", "is", "what", "i","m", "toldi", "turned", "my", 
"hairdryer", "to", "it","s", "highest", "setting", "napping", "in", 
"the", "bathroom", "turn", "the", "grill", "to", "it","s", "highest", 
"setting", "mark", "ourselves", "again", "and", "again", "with", "the", 
"hot", "knife", "until", "we", "remember", "our", "heroines", "we", 
"can", "show", "it", "off", "without", "misunderstanding", "remember", 
"what", "it", "felt", "like", "to", "do", "nothing", "and", "be", 
"fine", "about", "nothing", "challenge", "the", "pleasure", 
"principal", "cash", "out", "my", "purest", "pursuit", "expectations", 
"explode", "lose", "your", "soul", "for", "your", "country", "yell", 
"all", "along", "the", "way", "home", "from", "school", "reveal", 
"structured", "sub","grids", "that", "carried", "power", "along", 
"lines", "too", "thin", "and", "strung", "about", "haphazardly", 
"after", "the", "sky", "replaced", "the", "order", "of", "the", 
"telephone", "poles", "the", "becoming", "and", "going", "of", 
"structured", "sub","grids", "that", "carried", "power", "along", 
"lines", "too", "thin", "and", "strung", "about", "haphazardly", 
"because", "of", "the", "storm", "all", "terrain", "is", "dodgy", 
"in", "that", "there", "is", "a", "more", "efficient", "way", "of", 
"lighting", "these", "bombs", "off", "well", "he", "shot", "some", 
"stuff", "up", "to", "the", "moon", "there","s", "a", "formal", 
"way", "to", "fuck", "it", "all", "just", "do", "it", "and", "apply", 
"rigorously", "daily", "at", "regular", "intervals", "until", 
"swelling", "abbess", "rescinds", "into", "the", "depths", "of", 
"direct", "quotation", "having", "nothing", "at", "all", "to", "do", 
"with", "context", "but", "yet", "somehow", "linked", "but", "U",
"shaped", "lines", "over", "matte", "the", "image", "of", "your", 
"memory", "the", "formal", "way", "to", "fuck", "it", "all","apply", 
"rigorously", "daily", "at", "regular", "intervals", "until", 
"swelling", "abbess", "rescinds", "into", "depths", "of", "direct", 
"quotation", "having", "nothing", "at", "all", "to", "do", "with", 
"context", "but", "yet", "somehow", "linked", "but", "U","shaped", 
"lines", "over", "matte", "the", "image", "of", "memory", "having", 
"nothing", "at", "all", "to", "do", "with", "context", "but", "yet", 
"somehow", "linked", "like", "K","shaped", "lines", "over", "the", 
"matte", "image", "of", "memory", "recumbent", "growth", "is", "to", 
"be", "excepted", "and", "anticipation", "is", "anguish", "even", 
"though", "the", "winters", "are", "worse", "they", "say", "it","s", 
"both", "coming", "soon","salvation","destruction", "recumbent", 
"growth", "is", "to", "be", "excepted", "and", "anticipation", "is", 
"anguish", "even", "though", "the", "winters", "are", "worse","coming", 
"soon","salvation","destruction", "turbulent", "youth", "diaries", "are", 
"like", "clouds", "they", "were", "talking", "to", "each", "other", 
"but", "mouths", "werenot", "moving", "it","s", "handheld"
}; 


void setup() {
  size(displayWidth, displayHeight);
  if (frame != null) {
    frame.setResizable(true);
  }
  smooth();
  background(255);
  
  timeStamp = millis();
  timeStampMots = millis();

  largeurColonnes = width/colonnes;
  hauteurRangees = height/rangees;
  tableau2D = new color[colonnes][rangees];

//  for (int i = 0; i < colonnes; i++) {
//    for (int j = 0; j < rangees; j++) {
//      tableau2D[i][j] = color(/*random(0, 255), random(0, 255),*/ random(0, 150));
//    }
//  }
}

void draw() {
  
  writeTxt();
  noStroke();

  int tempsEcoule = millis() - timeStamp;
  int tempsEcouleMots = millis() - timeStampMots;

//  for (int i = 0; i < colonnes; i++) {
//    for (int j = 0; j < rangees; j++) {
//      fill(tableau2D[i][j]);
//      rect(i*largeurColonnes, j*hauteurRangees, largeurColonnes, hauteurRangees);
//    }
//  }

  if (tempsEcoule >= 50) {
    for (int i = 0; i < colonnes; i++) {
      for (int j = 0; j < rangees; j++) {
        tableau2D[i][j] = color(/*random(0, 255), random(0, 255),*/ random(0, 150));
      }
    }
    timeStamp = millis();
  }

  int tempsRand = int(random(10000));
  if (tempsEcouleMots >= tempsRand) {
    
    background(255);
    timeStampMots = millis();
    
  }
}

void writeTxt(){
  fill(0);
    textSize(50);
    //int x = 666;
    int x = int(random(0, width-75));
    //int y = 266;
    int y = int(random(30, height-30));
    int valR = int(random(0, tMots.length));
    text(tMots[valR], x, y);
}
//
//boolean sketchFullScreen() {
//  return true;
//}
