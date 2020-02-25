#include <Arduino.h>

#include <Wire.h>
#include <MS5611.h>
#include "I2Cdev.h"
#include "MPU6050.h"
#include <SPI.h>
#include <SD.h>

// Arduino Wire library is required if I2Cdev I2CDEV_ARDUINO_WIRE implementation
// is used in I2Cdev.h
#if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
    #include "Wire.h"
#endif

#define OUTPUT_READABLE_ACCELGYRO

#define LED_PIN 13
#define BUZ_PIN 8

unsigned long time;
const int chipSelect = 4;
MPU6050 accelgyro;
//MPU6050 accelgyro(0x69); // <-- use for AD0 high
int16_t ax, ay, az;
int16_t gx, gy, gz;
int16_t rx, ry, rz;

MS5611 ms5611;
double referencePressure;
bool blinkState = false;
const char* fileName = "datalog.txt";

void checkSettings();

void setup() {
  // join I2C bus (I2Cdev library doesn't do this automatically)
  #if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
      Wire.begin();
  #elif I2CDEV_IMPLEMENTATION == I2CDEV_BUILTIN_FASTWIRE
      Fastwire::setup(400, true);
  #endif

  
  Serial.begin(115200);

  // Initialize MS5611 sensor
  Serial.println("Initialize MS5611 Sensor");

  while(!ms5611.begin())
  {
    Serial.println("Could not find a valid MS5611 sensor, check wiring!");
    delay(500);
  }

  // Get reference pressure for relative altitude
  referencePressure = ms5611.readPressure();

  // Check settings
  checkSettings();
  
   // initialize device
  //   Serial.println("Initializing I2C devices...");
  accelgyro.initialize();

    // verify connection
  //   Serial.println("Testing device connections...");
  //  Serial.println(accelgyro.testConnection() ? "MPU6050 connection successful" : "MPU6050 connection failed");
  pinMode(LED_PIN, OUTPUT);
    
  //    Serial.print("Initializing SD card...");
  if (!SD.begin(chipSelect)) {// see if the card is present and can be initialized:
    // Serial.println("Card failed, or not present");
    // don't do anything more:
    return;
  }
  // Serial.println("card initialized.");

  // Write header

  File dataFile= SD.open(fileName, FILE_WRITE);

  // if the file is available, write to it:
  if (dataFile) {
    dataFile.println(String("relAlt,absAlt,realPressure,temp,accelX,accelY,accelZ,gyroX,gyroY,gyroZ,rotX,rotY,rotZ,timer"));
    dataFile.close();
  }

}

void checkSettings() {
 // Serial.print("Oversampling: ");
 // Serial.println(ms5611.getOversampling());
}

void loop() {

  // read raw accel measurements from device
  // accelgyro.getAcceleration(&ax, &ay, &az);
  accelgyro.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
  accelgyro.getRotation(&rx, &ry, &rz);
 
  // Read raw pressure and temp values
  // uint32_t rawTemp = ms5611.readRawTemperature();
  // uint32_t rawPressure = ms5611.readRawPressure();

  // Read true temperature & Pressure
  double realTemperature = ms5611.readTemperature();
  long realPressure = ms5611.readPressure();

  // Calculate altitude
  float absoluteAltitude = ms5611.getAltitude(realPressure);
  float relativeAltitude = ms5611.getAltitude(realPressure, referencePressure);


  //change variables to strings
  String c = String(',');
  String absAlt = String(absoluteAltitude);
  String relAlt = String(relativeAltitude);
  String realpressure = String(realPressure);
  String temp = String(realTemperature );
  String accelVals = String(ax) + c + String(ay) + c + String(az);
  String gyroVals = String(gx) + c + String(gy) + c + String(gz);
  String rotVals = String(rx) + c + String(ry) + c + String(rz);
  String timer = String(millis());


  String baro_data = String(
    relAlt + c + absAlt + c + 
    realpressure + c + temp + c + 
    accelVals + c + gyroVals + c + 
    rotVals + c + timer) ;

  Serial.println(baro_data);

  File dataFile= SD.open(fileName, FILE_WRITE);
  if (dataFile) {
    dataFile.println(baro_data);
    dataFile.close();
  }
/*
  if (millis() > 10000) { //change this number to change alarm delay (1s = 1000ms)
    tone (BUZ_PIN,1000); // change the second number to alter the tone of the peizo alarm
  } else { 
    noTone(BUZ_PIN);
  }
*/
}
