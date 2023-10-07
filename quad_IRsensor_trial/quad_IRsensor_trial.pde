import processing.serial.*; //includes serial object library
Serial response; //creates local serial object from serial
String sm_data = null ; //a variable to collect serial data
String ping; //a variable to show status of IR sensor

int new_line = 10; //ASCII code for carage return in Serial
float my_val ; //to storeing serial converted ASCII serial data 
int stat;
int [] digi;
int i;
int [] occupiedflag;
button [] b = new button [4];

color base;
color booked;
color engaged;

int wideX;
int longY;

boolean clk;

void setup() {
    size(800,400);

    wideX=120;
    longY=100;

    b[0] = new button(520,80);
    b[1] = new button(390,80);
    b[2] = new button(260,80);
    b[3] = new button(130,80);
    //scaled it to 4 also change size and coordinates

    occupiedflag = new int[4];
    occupiedflag[0]= 0;
    occupiedflag[1]= 0;
    occupiedflag[2]= 0;
    occupiedflag[3]= 0;

    //scale it to 4 also change size and coordinates


    base = color(0,255,0); //green color
    engaged = color(255,0,0); //red color
    booked = color(255,255,0); //yellow color


    //link Processing to Serial Port (required one or the correct one)
    String portdata = Serial.list() [0]; //find correct Serial Port; 
    response = new Serial(this,portdata,9600);

}

void draw() {
    while (response.available() > 0) {
        sm_data = response.readStringUntil(new_line); //STRIPS data from Serial Port

        if(sm_data != null) {
        background(0);
        stroke(255,0,255);
        

        my_val = float(sm_data);// takes data from serial and turns into Numbers
        stat = int(my_val);



    }//data was on the serial port

    println("float->"+my_val+" int->"+stat);

    splitter(stat);
    window_write();

    for(i=0;i<4;i++) { //loop is present and scaleing done to 4
        if (b[i].tog) {
            b[i].update_button();//yellowing
            b[i].labels(i);
            if (digi[i]==0) {
               //when car occupies the slot
               occupiedflag[i] = 1;
                b[i].occupied();
                b[i].labels(i);

            }

            else if (occupiedflag[i]==1 && digi[i]==1) {
                //when car leaves after occuping the slot
                //digi[i] trips down from 0 to 1
                //sign show go directly to   
                b[i].display(); 
                b[i].labels(i);
                b[i].tog = !b[i].tog;
                occupiedflag[i] = 0;
                
            }
        }
        else {
            b[i].display(); 
            b[i].labels(i);

        }
    } 


}//do something if there is data on this port

}

void window_write(){
    //upper half what serial monitor is sending
    fill(255,255,255);
    textSize(16);
    text(stat, 20,20);
    //scaling reqiured here
    text("Sensor S4: "+ digi[3],20,33);
    text("Sensor S3: "+ digi[2],20,46);
    text("Sensor S2: "+ digi[1],20,59);
    text("Sensor S1: "+ digi[0],20,72);
    //to here
    fill(255,255,0);
    textSize(30);
    text("CAR PARKING AND WASHING BOOKING KIOSK",120,40);


}

void splitter(int n) {
    int x;
    int i=0;
    digi = new int[4]; //scaling done

    x=n;

    while(x!=0) {
        digi[i] =x%10;
        x=x/10;
        i++;
    }


}

void mousePressed() {
    for(i=0;i<4;i++) { //Scaling done
                if ((mouseX > b[i].x_cor) &&
                (mouseX <= (b[i].x_cor+b[i].wideX)) &&
                (mouseY > b[i].y_cor) &&
                (mouseY <= (b[i].y_cor+b[i].longY)) &&
                (digi[i]==1)) {
                    
                        b[i].tog = !b[i].tog;
                    
                }
    }
}








