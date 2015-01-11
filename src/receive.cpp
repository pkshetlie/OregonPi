#include <cstdio>
#include <fstream>
#include <time.h>
#include "libs/RCSwitch.h"
#include "libs/RcOok.h"
#include "libs/Sensor.h"

using namespace std;
int main(int argc, char *argv[])
{
  int RXPIN = 7;
  int TXPIN = 0;
  ofstream myfile;
  if(wiringPiSetup() == -1)
    return 0;

  RCSwitch *rc = new RCSwitch(RXPIN,TXPIN);

  while (1)
  {
    if ( rc->OokAvailable() )
    {
      char message[100];

      rc->getOokCode(message);
      printf("%s\n",message);

      Sensor *s = Sensor::getRightSensor(message);
      if ( s != NULL )
      {
        time_t seconds = time(NULL);
        struct tm * timeinfo = localtime(&seconds);


        myfile.open("rapport.txt",ios::app);
        myfile << s->getTemperature() << ";" << s->getHumidity() << ";" << timeinfo->tm_hour << ":" << timeinfo->tm_min<<endl;
        myfile.close();
        printf("Temp : %f\n",s->getTemperature());
        printf("Humidity : %f\n",s->getHumidity());
        printf("Channel : %d\n",s->getChannel());
      }
      delete s;
    }
    delay(1000);
  }
}

