/* autogenerated by Processing revision 1292 on 2023-04-24 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import processing.serial.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class quad_IRsensor_trial extends PApplet {

 //includes serial object library
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

int base;
int booked;
int engaged;

int wideX;
int longY;

boolean clk;

public void setup() {
    /* size commented out by preprocessor */;

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

public void draw() {
    while (response.available() > 0) {
        sm_data = response.readStringUntil(new_line); //STRIPS data from Serial Port

        if(sm_data != null) {
        background(0);
        stroke(255,0,255);
        

        my_val = PApplet.parseFloat(sm_data);// takes data from serial and turns into Numbers
        stat = PApplet.parseInt(my_val);



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

public void window_write(){
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

public void splitter(int n) {
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

public void mousePressed() {
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








class button {

    int x_cor;
    int y_cor;
    int wideX = 120;
    int longY = 100;
    String lab = null;
    boolean tog = false;
    

    button( int x_pla,int y_pla) {
        x_cor = x_pla;
        y_cor = y_pla;
    
    }

    public void display() {

        strokeWeight(8);
        stroke(255);
        fill(0, 255, 0); //green color
        rect(x_cor, y_cor, wideX, longY);
        //displays text "VACANT" when button is green
        fill(255,255,255);
        textSize(15);
        text("VACANT", x_cor+10, y_cor+10, 60, 35);
        
    }

    public void update_button() {

        strokeWeight(8);
        stroke(255);
        fill(255, 255, 0); //yellow color
        rect(x_cor, y_cor, wideX, longY);
        //displays text "BOOKED" when button is yellow
        fill(0);
        textSize(13);
        text("BOOKED", x_cor+10, y_cor+10, 50, 30);
        

    }
    
    public void occupied() {
        strokeWeight(8);
        stroke(255);
        fill(230, 35, 70); //reddish color
        rect(x_cor, y_cor, wideX, longY);
        //displays text "BOOKED" when button is yellow
        fill(255);
        textSize(13);
        text("OCCUPIED", x_cor+10, y_cor+10, 60, 30);
    }

    public void labels(int k) {
        if (k==0) {
            lab = "S1";
        }
        else if (k==1) {
            lab = "S2";
        }
        else if (k==2) {
            lab = "S3";
        }
        else if (k==3) {
            lab = "S4";
        }
        else {
            lab = null;
        }
        fill(0);
        textSize(13);
        text("SENSOR:"+lab, x_cor+10, y_cor+25, 70, 30);
        
    }


}


  public void settings() { size(800, 400); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "quad_IRsensor_trial" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
