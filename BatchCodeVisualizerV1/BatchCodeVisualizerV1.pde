ParticleEngine engine;
Particle dragging;
Particle lastParticle;
processing.data.JSONObject results;
processing.data.JSONArray resultsFile;

HashMap<String, String> TitleNames = new HashMap<String, String>();
HashMap<String, Integer> TitleSalaries = new HashMap<String, Integer>();
HashMap<String, Integer> NameSalaries = new HashMap<String, Integer>();
ArrayList<String> batchNames = new ArrayList<String>();

color color1 = color(251, 180, 174);
color color2 = color(179, 205, 227);
color color3 = color(242, 242, 242);
color color4 = color(204, 235, 197);
void setup() {
  size(800, 700);
  engine = new ParticleEngine();
  smooth();
  resultsFile = loadJSONArray("refreshJobsresults1.json");
  JSONObject batchName = new JSONObject();
  batchName = resultsFile.getJSONObject(0);
  String keys = "";
  engine.addParticle(new Particle("SDEGISE", random(0, 600), random(0, 600), 0, 0, 30, color(0)));
  engine.addParticle(new Particle("SDEGISP", random(0, 600), random(0, 600), 0, 0, 30, color(0)));
  for (int i = 0; i < batchName.keys ().size(); i++) {
    keys = batchName.keys().toArray()[i].toString();
    batchNames.add(keys);
    if (keys.contains("drew") == false) {
     // println(keys);
      engine.addParticle(new Particle(keys, random(0, 600), random(0, 600), 0, 0, 30, color(0)));
     // engine.connectParticles("RefreshJob.bat", keys, color(0));
    }
  }
  for (int a = 0; a < batchNames.size (); a++) {
    String keys2 = batchNames.get(a);
    JSONObject B2 = batchName.getJSONObject(keys2);
   // println(B2);
    //    for (int j = 0; j < B2.keys().size(); j++) {
    //      String keys3 = B2.keys().toArray()[j].toString();
    String ja = (String) B2.getJSONArray("LinkedBatchJobs").toString();
    if (ja.contains(".bat")) {
     // println(ja);
      ja = ja.replace("\n", "").replace("[", "").replace("]", "").replace(" ", "").replace("\"", "");
      for (String retval : ja.split (",")) {
        if (engine.findParticle(retval) != null) {
          engine.connectParticles(keys2, retval, color(0));
        }
      }
    }
    try {
      JSONObject sq = B2.getJSONObject("LinkedSQLJobs");
      for (int j = 0; j < B2.keys ().size(); j++) {
        String keys3 = B2.keys().toArray()[j].toString();
        JSONObject sq2 = sq.getJSONObject(keys3);
       // println(sq2.getString("Database"));
            println("test");
        if (keys3.contains("\\")) {
          keys3 = keys3.replace("\\", "");
        }
        if (engine.findParticle(keys3) == null) {
          engine.addParticle(new Particle(keys3, random(0, 600), random(0, 600), 0, 0, 30, color(0)));
        }
        engine.connectParticles(keys3, keys2, color(0));
        println("Connect " + keys3 + " " + keys2);
        if (sq2.getString("Database").equals("SDEGISE")) {
          engine.connectParticles(keys3, "SDEGISE", color(0));
        }
        if (sq2.getString("Database").equals("SDEGISP")) {
          engine.connectParticles(keys3, "SDEGISP", color(0));
        }
      }
    }
    catch (Exception e) {
    }
  }
  //  String test = B2.getString("LinkedBatchJobs");
  //   for (int b = 0; b < ja.size(); b++) {
  //   ja.keys().toArray()[i].toString();

  // println(keys3);
  //   }
  //  }
}

// engine.connectParticles(ja.getString(k), keys, color(0));





void draw() {
  //frameRate(60);
  background(245, 250, 242);
  for (int w=0; w<950; w+=10) {
    stroke(240, 240, 240, 50);
    strokeWeight(1);   
    line(0, w+10, width, w+10); //horiz
  }
  for (int w=0; w<950; w+=10) {
    stroke(240, 240, 240, 50);
    strokeWeight(1);   
    line(w+10, 0, w+10, height); //horiz
  }
  engine.update();
  engine.draw();
}
void mousePressed(MouseEvent e) {
  if (e.getClickCount()==2) {
    engine.unPin(true);
  }
  engine.update();
  dragging = engine.particleAt(mouseX, mouseY);
  if (dragging!=null) {
    dragging.dragged = true;
    lastParticle = dragging;
  }
}

void mouseReleased() {
  if (dragging!=null) {
    if (dragging.label != "Book1" && dragging.label != "Book2") {
      dragging.pin(mouseX, mouseY);
    }
    dragging.dragged=false;
    dragging = null;
  }
}

