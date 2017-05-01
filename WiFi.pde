//   0,     1,     2,      3,   4,     5,     6,     7,     8, 9, 10,11,  12,       13,    14,  15,    16,      17,       18,      19,     20,      21,    22,    23,   24,    25,     26,    27,  28    
//OBJECTID,BORO,the_geom,FID_1,TYPE,PROVIDER,NAME,LOCATION,LAT,LON,X,Y,LOCATION_T,REMARKS,CITY,SSID,SOURCEID,ACTIVATED,BoroCode,BoroName,NTACode,NTAName,CounDist,ZIP,BoroCD,CT2010,BCTCB2010,BIN,BBL

// 0
// POINT (-73.8981682368399 40.74955730896312)

// LIBRARIES
import processing.pdf.*;

// GLOBAL VARIABLES
PShape baseMap;
String csv[];
String phone_csv[];
String myData[][];
String myData_phone[][];
PFont f;

float[] nycBounds = {
  //-74.1138,  40.6447,  -73.8583,  40.8393
  //-74.028282,40.690791,-73.820229,40.869651
  
  // 5 boros
  -74.266205,40.495004,-73.67157,40.91455
};

PImage bg;

// SETUP
void setup() {
  //size(1280, 720);
  size(1000, 720);
  noLoop();
  f = createFont("Avenir-Medium", 12);
  baseMap = loadShape("5_Boroughs_Labels_New_York_City_Map2.svg");
  //baseMap = loadShape("wifi_map2.svg");
  //baseMap = loadShape("5_Boroughs_Labels_New_York_City_Map.svg");
  //bg = loadImage("wifi_map.png");
  
  // load data sets (csv)
  csv = loadStrings("NYC_Free_Public_WiFi_03292017.csv");
  phone_csv = loadStrings("Public_Pay_Telephone_1152015.csv");
  
  myData = new String[csv.length][29];
  for(int i=1; i<csv.length; i++) {
    myData[i] = csv[i].split(",");
  }
  
  myData_phone = new String[phone_csv.length][17];
  for(int i=1; i<phone_csv.length; i++) {
    myData_phone[i] = phone_csv[i].split(",");
  }  
  
}


// DRAW
void draw() {
  beginRecord(PDF, "wifi_nyc.pdf");
  shape(baseMap, 0, 0, width, height);
  noStroke();
  
  // phone
   for(int i=1; i<myData_phone.length; i++){
      //fill(0, 255, 0, 50);
      fill(#dfc27d, 90);
      textMode(MODEL);
      noStroke();
    
    // -74.0024247425479 40.73318045181088)
    //println(myData_phone[i][0]);
    String lat_long[] = myData_phone[i][0].split(" ");
    //println(myData_phone[i][0].split("(")[1].split(")")[0].split(' '));

    float graphLong = map(float(lat_long[0]), nycBounds[0], nycBounds[2], 0, width);
    float graphLat = map(float(lat_long[1]), nycBounds[3], nycBounds[1], 0, height);
    //float markerSize = 0.05*sqrt(float(myData[i][2]))/PI;
    float markerSize = 2; //sqrt(float(myData[i][2]));

    //println(i, graphLong, graphLat);

    rect(graphLong, graphLat, markerSize, markerSize);
    stroke(0);
    noFill();

    
    if(i<0){
      fill(0);
      textFont(f);
      text(myData_phone[i][4], graphLong + markerSize + 5, graphLat + 4);
      noFill();
      stroke(0);
      line(graphLong+markerSize/2, graphLat, graphLong+markerSize, graphLat);
    }
  }
  
  // wifi
  for(int i=1; i<myData.length; i++){
    fill(#80cdc1, 80);
    //fill(255, 0, 0, 50);
    textMode(MODEL);
    noStroke();

    float graphLong = map(float(myData[i][9]), nycBounds[0], nycBounds[2], 0, width);
    float graphLat = map(float(myData[i][8]), nycBounds[3], nycBounds[1], 0, height);
    //float markerSize = 0.05*sqrt(float(myData[i][2]))/PI;
    float markerSize = 4; //sqrt(float(myData[i][2]));

    //println(i, graphLong, graphLat);

    ellipse(graphLong, graphLat, markerSize, markerSize);
    stroke(0);
    noFill();

    
    if(i<0){
      fill(0);
      textFont(f);
      text(myData[i][7], graphLong + markerSize + 5, graphLat + 4);
      noFill();
      stroke(0);
      line(graphLong+markerSize/2, graphLat, graphLong+markerSize, graphLat);
    }
  }
 

  
  
  endRecord();
  println("PDF Saved!");
}