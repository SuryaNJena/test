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

    void display() {

        strokeWeight(8);
        stroke(255);
        fill(0, 255, 0); //green color
        rect(x_cor, y_cor, wideX, longY);
        //displays text "VACANT" when button is green
        fill(255,255,255);
        textSize(15);
        text("VACANT", x_cor+10, y_cor+10, 60, 35);
        
    }

    void update_button() {

        strokeWeight(8);
        stroke(255);
        fill(255, 255, 0); //yellow color
        rect(x_cor, y_cor, wideX, longY);
        //displays text "BOOKED" when button is yellow
        fill(0);
        textSize(13);
        text("BOOKED", x_cor+10, y_cor+10, 50, 30);
        

    }
    
    void occupied() {
        strokeWeight(8);
        stroke(255);
        fill(230, 35, 70); //reddish color
        rect(x_cor, y_cor, wideX, longY);
        //displays text "BOOKED" when button is yellow
        fill(255);
        textSize(13);
        text("OCCUPIED", x_cor+10, y_cor+10, 60, 30);
    }

    void labels(int k) {
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