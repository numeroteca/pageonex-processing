String[] imagesb;
String[] dates;
String[] Names;
String[] newspaperName;

//Variables to control
int theYear = 12; //year
int theMonth = 5; //month  
int DayMonthInit = 1; //day we atart counting in the month
int DayMonthLast = 31; //last day we take in account

int dateDay = DayMonthInit;


int posXinit = 0; //790 pixels is the width of one front page imape
String stheMonth  = nf(theMonth, 2); //convert the month to a 2 digit
int i = 0;
int f = 0;
int posDate = posXinit + 4;


String Country = "es"; // "es" for Spain "us" for USA
String nameMain = "12m15m-mayo2012-b"; //name of the folder
int heightFrontPage = 1100; //height of the newspaper. the width is 750px. 1500px for US newspaper. 1100px for Spanish
int separation = 100; //separation between rows
int heightRow =heightFrontPage + separation ; 
int numberNewspapers = 8; //Important to include here the number of newspaper to make the funcionts work properly when builing the svg
int initial = 0;

int count = 0;

void setup() {

  size(200, 300);
  String[] inits = loadStrings("svg-init.txt"); //"header" of the svg
  String[] ends = loadStrings("svg-end.txt"); //"footer" of the svg
  String[] imagesb;
  String[] Names;
  newspaperName = new String[numberNewspapers];
/*
  grabFrontPages ("newyork_times");
  grabFrontPages ("washington_post");
  
  writeFrontPages ("newyork_times","NY times");
  writeFrontPages ("washington_post","Washington Post");
*/
  //find the name of thewspaper your want at http://kiosko.net
  
  /*grabFrontPages ("abc");
  grabFrontPages ("larazon");*/
  
 /* Example of spanish newspapers*/
 
  grabFrontPages ("elpais");
  grabFrontPages ("elmundo");
  grabFrontPages ("abc");
 grabFrontPages ("lavanguardia");
 grabFrontPages ("larazon");
  grabFrontPages ("elperiodico");
 grabFrontPages ("la_gaceta");
grabFrontPages ("20minutos_madrid");
  
  //  writeFrontPages ("abc", "ABC");    
 // writeFrontPages ("larazon","La Razón");

  writeFrontPages ("elpais","El País");
  writeFrontPages ("elmundo", "El Mundo");
  writeFrontPages ("abc", "ABC");    
  writeFrontPages ("lavanguardia", "La Vanguardia");
  writeFrontPages ("larazon","La Razón");
  writeFrontPages ("elperiodico","El Periódico");
  writeFrontPages ("la_gaceta","La Gaceta");
   writeFrontPages ("20minutos_madrid","20minutos");
  
  /* Example of US newspapers
  grabFrontPages ("latimes");
  grabFrontPages ("sf_chronicle");
  grabFrontPages ("mercure_news");
  grabFrontPages ("sacramento_bee");
  grabFrontPages ("laopinion");
  grabFrontPages ("union_tribune");
  grabFrontPages ("orange_register");
  

  writeFrontPages ("latimes","Los Angeles Times");
  writeFrontPages ("sf_chronicle", "SF Chronicle");
  writeFrontPages ("mercure_news", "Mercure News");    
  writeFrontPages ("sacramento_bee", "Sacramento Bee");
  writeFrontPages ("laopinion","La Opinión");
  writeFrontPages ("union_tribune","Union Tribune");
  writeFrontPages ("orange_register","Orange Register");*/

  writeDates (0, posDate); //writes the dates
  writeNames (); //writes the name of the newspapers, has to be run at the same time that all the "writeFrontPages ()"

  writeFinaleSVG ();
  background(0);
  text("Thanks for using Front-page-matrix", 5, 150);
  text("Be aware: if you use it again, you will\nerase the previous .svg file.", 5, 170);
  textSize(40);
  text("Done", 50, 90);
}

void grabFrontPages (String folder) { 

  String prefix= "http://img.kiosko.net/20"+theYear+"/"+stheMonth +"/";
  String sufix= "/"+Country+"/"+ folder +".750.jpg";

  //finds the images and download them on the /svg/img/ folder
  String extension = sufix.substring(sufix.length()-4);
  for (int i=DayMonthInit;i<DayMonthLast+1;i++) {
    if (i<10) { //for images under 10 convert to a 2 number string
      String si = nf(i, 2);
      String filename ="/svg/img/"+ folder + "/" + theYear + stheMonth + si + "-" + folder + extension;
      String url = prefix + si + sufix;
      println("Downloading " + url+ " to " + filename);
      saveStream(filename, url);
    } 
    else { //for images above 10
      String filename = "/svg/img/"+ folder + "/" + theYear + stheMonth + i + "-" + folder + extension;
      String url = prefix + i + sufix;
      println("Downloading " + url + " to " + filename );
      saveStream(filename, url);
    }
  }
}

void writeFrontPages (String name, String realName) { //writes the files to make the matrix
  int posY = heightRow*count;
  String idImagen = "a";
  

  if (i==0) { 
    imagesb = new String[DayMonthLast-DayMonthInit+1];
    i++;
  }
  else {
    imagesb = expand(imagesb, (DayMonthLast-DayMonthInit+1)*(i+1));
    i++;
  }

  for (int e=DayMonthInit; e<DayMonthLast+1; e++) { 
    if (e<10) {
      String se = nf(e, 2);
      imagesb[initial]= "<image y=\"" + posY + "\" x=\""+ posXinit + "\" id=\"imagenb"+ name + idImagen + theYear +stheMonth + "\" height=\""+heightFrontPage+"\" width=\"750\" " 
        + "xlink:href=\"./img/" + name + "/" + theYear + stheMonth + se + "-" + name + ".jpg\" " + "/>";
      println("e=" + e + "---------");
    }
    else {
      imagesb[initial]= "<image y=\"" + posY+ "\" x=\""+ posXinit + "\" id=\"imagenb"+ idImagen + "_b" + theYear + stheMonth +  "\" height=\""+heightFrontPage+"\" width=\"750\" " +" xlink:href=\"./img/" +name
        + "/"+theYear+stheMonth+ e + "-" + name + ".jpg\" " + "/>";

      println("writing  "+ "e= "+ e + ""+ imagesb[initial]);
    }
    posXinit = posXinit + 790;
    idImagen = idImagen + 1;
    initial = initial + 1 ;
  }

  saveStrings("\\txt\\" + name + "-only-images-" + stheMonth + ".txt", imagesb);
  saveStrings("\\txt\\" + "store-images" + ".txt", imagesb);
  println("strings saved ");
  println("name is: " + name);
  println("count is: " + count);
  
  newspaperName[count]= realName;
  count = count+1;
  posXinit = 0; //modify this so that it can e changed globally
}


void writeDates (int posY, int posDate) {
  String idImagen = "a";
  dates = new String[DayMonthLast-DayMonthInit+1];

  for (int e=DayMonthInit; e<DayMonthLast+1; e++) { 

    int posDateRect = posDate -4;
    dates[f]="<text xml:space=\"preserve\" " + "style=\"font-size:250px;font-style:normal;font-weight:normal;line-height:120%;letter-spacing:0px;word-spacing:0px;fill:#cccccc;fill-opacity:1;stroke:none;font-family:sans-serif\""+
      " x=\""+ posDate + "\" y=\"-275\" id=\"txt" + idImagen + theYear +stheMonth 
      + "\" sodipodi:linespacing=\"127%\"><tspan sodipodi:role=\"line\" id=\"tspan3001\"" 
      + " x=\""+ posDate + "\" y=\"-275\">"+ theMonth +"."+ dateDay +"</tspan></text>"+
      "<rect style=\"fill:#cccccc;fill-opacity:1;stroke:none;\" id=\"rect" + idImagen + theYear + stheMonth + "\" width=\"750\" height=\"20\" x=\"" + posDateRect +"\" y=\"-230\" />";

    dateDay=dateDay+1;
    posDate = posDate + 790;
    idImagen = idImagen + 1;
    f=f+1;
    //println(dates);
  }
  saveStrings("\\txt\\" + "store-dates" + ".txt", dates);
}


void writeNames () {
  println("count: " + count);
  println("newspaperName[*]: " + newspaperName);
  Names = new String[numberNewspapers]; //viene un "7" en estos corchetes, ccamio a 8 a ver qué pasa
  int verticalText = heightFrontPage - 50;
  
  for (int i=0; i<count; i++) { 
    
    Names[i]="<text xml:space=\"preserve\" " +
    "style=\"font-size:250px;font-style:normal;font-weight:normal;line-height:120%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:sans-serif\""+
      " x=\"-100\" y=\""+ verticalText+"\" id=\"txt"
      + "\" sodipodi:linespacing=\"127%\"><tspan sodipodi:role=\"line\" id=\"tspan3001\"" 
      + " x=\"-100\" y=\""+ verticalText+"\" style=\"text-align:end;text-anchor:end\">"+ newspaperName[i]+"</tspan></text>";
    
    verticalText = verticalText + heightRow;
    posDate = posDate + 790;
  }
  saveStrings("\\txt\\" + "store-names" + ".txt", Names);
}





void writeFinaleSVG () { //writes the files to make the matrix.svg
  String[] inits = loadStrings("svg-init.txt"); //"header" of the svg
    String[] frontPages = loadStrings("/txt/store-images.txt");
  String[] datesStorage = loadStrings("/txt/store-dates.txt");
  String[] namesStorage = loadStrings("/txt/store-names.txt");
  String[] ends = loadStrings("svg-end.txt"); //"footer" of the svg

  String[] finale = new String[frontPages.length + inits.length + datesStorage.length + namesStorage.length  + ends.length];

  arrayCopy(inits, 0, finale, 0, inits.length); // copy svg-init.txt into the finale array
  arrayCopy(frontPages, 0, finale, inits.length, frontPages.length); //copy all the images into the finale array
  arrayCopy(datesStorage, 0, finale, inits.length+frontPages.length, datesStorage.length); //copy all the dates into the finale array
  arrayCopy(namesStorage, 0, finale, inits.length+frontPages.length+datesStorage.length, namesStorage.length);  //copy all the newspapers' names into the finale array
  arrayCopy(ends, 0, finale, inits.length+frontPages.length+datesStorage.length+namesStorage.length, ends.length); //copy svg-end.txt into the finale array

  saveStrings("\\svg\\"+ nameMain +"-create-svg_year-"+theYear +"_from-" + stheMonth +"-" + DayMonthInit + "_to-"+ stheMonth +"-" + DayMonthLast + ".svg", finale);
}

