/*  Demo of draw circle's APP
    drawCircle(int poX, int poY, int r,INT16U color);
    fillCircle(int poX, int poY, int r,INT16U color);
*/

#include <stdint.h>
#include <TFTv2.h>
#include <SPI.h>

int ApertureDiameter = 12;
int delayMS = 400;

int x_size = 240;
int y_size = 320;

int x_offset = 0;
int y_offset = 0;

int x_centre = x_size / 2;
int y_centre = y_size / 2;

int NA_radius = 50;

void setup()
{
  Tft.TFTinit();                                      //init TFT library

  Serial.begin(250000);

  delay(100);

  Tft.fillCircle(x_centre, y_centre, ApertureDiameter / 2, WHITE);
  delay(100);
  Tft.fillCircle(x_centre, y_centre, ApertureDiameter / 2, BLACK);

  Serial.println(-1.0);
}

void loop()
{

  char data[2];

  if (Serial.available() > 0) {
    char cmd = Serial.read();
    switch (cmd) {


      case 'T': // Setup Delay Time
        Serial.readBytes(data, 2);
        delayMS = (int)data[1] * 10;
        break;

      case 'N': // Setup Delay Time
        Serial.readBytes(data, 2);
        NA_radius = (int)data[1];
        Tft.fillCircle(x_centre, y_centre, NA_radius, WHITE);
        delay(100);
        Tft.fillCircle(x_centre, y_centre, NA_radius, BLACK);
        break;


      case 'A': // Setup Aperture Diameter
        Serial.readBytes(data, 2);
        ApertureDiameter = (int)data[1];
        Tft.fillCircle(x_centre, y_centre, ApertureDiameter / 2, WHITE);
        delay(100);
        Tft.fillCircle(x_centre, y_centre, ApertureDiameter / 2, BLACK);
        break;

      case 'X': // Setup Aperture x Centre
        Serial.readBytes(data, 2);
        x_centre = (int)data[1]*2;
       
        Tft.fillCircle(x_centre, y_centre, ApertureDiameter / 2, WHITE);
        delay(100);
        Tft.fillCircle(x_centre, y_centre, ApertureDiameter / 2, BLACK);
        break;

      case 'Y': // Setup Aperture y Centre
        Serial.readBytes(data, 2);
        y_centre = data[1]*2;
        
        Tft.fillCircle(x_centre, y_centre, ApertureDiameter / 2, WHITE);
        delay(100);
        Tft.fillCircle(x_centre, y_centre, ApertureDiameter / 2, BLACK);

        break;


      case 'I': // image

        //x_centre = x_size / 2 + x_offset;
        //y_centre = y_size / 2 + y_offset;

        for (int x = 0; x < x_size; x = x + ApertureDiameter / 2) {
          for (int y = 0; y < y_size; y = y + ApertureDiameter / 2) {

            unsigned int x_sq = ((x - x_centre) * (x - x_centre));
            unsigned int y_sq = ((y - y_centre) * (y - y_centre));
            unsigned int absxy = x_sq + y_sq;

            if (absxy < (NA_radius * NA_radius)) {
              Tft.fillCircle(x, y, ApertureDiameter / 2, WHITE);
              delay(delayMS);
              Tft.fillCircle(x, y, ApertureDiameter / 2, BLACK);
              //Serial.print(((x - x_centre) * (x - x_centre)))         ;

            }
          }
        }
        break;
    }
  }




}

/*********************************************************************************************************
  END FILE
*********************************************************************************************************/
