   
#property copyright "Copyright © 2021, E.S.A VORACITY"
//#property icon "esa.ico"
#property description "VORACITY"
#property description "OFFICIAL FREE LICENSE"
//#property description "FOR FIXED TIME TRADE"
#property description "6 Bulan ACTiVED"

#property version     "1.0" 
#property link      "https://trakteer.id/eka-agung-090"

#property indicator_chart_window
#property indicator_buffers 5
#property indicator_color1 clrRoyalBlue
#property indicator_width1 4
#property indicator_color2 clrCrimson
#property indicator_width2 4
#property indicator_color3 clrWhite
#property indicator_width3 3
#property indicator_color4 clrSpringGreen
#property indicator_width4 4
#property indicator_color5 clrOrangeRed
#property indicator_width5 4

///extern string note1 = "First Moving Average";

///extern string note5 = "0=sma, 1=ema, 2=smma, 3=lwma";
 //0=sma, 1=ema, 2=smma, 3=lwma
//string THE_PASSWORD = "PASSWORD!!";
//extern int LimitBARS=1000000;

//extern string note2 = "Higher Period From Curent";
//extern string note2 = "SMA";
extern string note1 = "Rasio Diff Volume";
extern int volRasio = 2;
extern string note2 = "Rasio Diff Body";
extern int BodyRasio = 5;
///////////////////////
extern string note3 = "Arrow Type";
extern string note4 = "0=Thick, 1=Thin, 2=Hollow, 3=Round";
extern string note5 = "4=Fractal, 5=Diagonal Thin";
extern string note6 = "6=Diagonal Thick, 7=Diagonal Hollow";
extern string note7 = "8=Thumb, 9=Finger";
extern int ArrowType=4;

///extern string note12 = "default settings: 0.02 / 0.2 / 7";
//int Step =0.02;
//int Maximum = 0.2;
//int Precision = 7;

//string Name=WindowExpertName();
//string MyName="PLEAIDES";
//string PASS="FOXHUNTVORACITY";

/*
extern string note12 = "--------------------------------------------";
extern string note13 = "turn on Alert = true; turn off = false";
extern bool AlertOn = true;
extern string note14 = "--------------------------------------------";
extern string note15 = "send Email Alert = true; turn off = false";
extern bool SendAnEmail=true;
*/
//
extern string ahi0=" ******* Alert settings:";
//int  SignalCandle           = 1;
extern bool PopupAlerts            = TRUE;
extern bool EmailAlerts            = FALSE;
extern bool PushNotificationAlerts = FALSE;
extern bool SoundAlerts            = FALSE;
extern string SoundFileLong        = "alert.wav";
extern string SoundFileShort       = "alert2.wav";
int lastAlert=88;

//

double CrossUp[];
double CrossDown[];
double CrossIndex[];
double CrossUp1[];
double CrossDown1[];
//string AlertPrefix,
//string MA1short_name, MA2short_name;

string GetTimeFrameStr() {
   switch(Period())
   {
      case 1 : string TimeFrameStr="M1"; break;
      case 5 : TimeFrameStr="M5"; break;
      case 15 : TimeFrameStr="M15"; break;
      case 30 : TimeFrameStr="M30"; break;
      case 60 : TimeFrameStr="H1"; break;
      case 240 : TimeFrameStr="H4"; break;
      case 1440 : TimeFrameStr="D1"; break;
      case 10080 : TimeFrameStr="W1"; break;
      case 43200 : TimeFrameStr="MN1"; break;
      default : TimeFrameStr=Period();
   } 
   return (TimeFrameStr);
   }

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   if (ArrowType == 0) {
      SetIndexStyle(0,DRAW_ARROW);
      SetIndexArrow(0, 233);
      SetIndexStyle(1,DRAW_ARROW);
      SetIndexArrow(1, 234);

   }
   else if (ArrowType == 1) {
      SetIndexStyle(0,DRAW_ARROW);
      SetIndexArrow(0, 225);
      SetIndexStyle(1,DRAW_ARROW);
      SetIndexArrow(1, 226);

   }
   else if (ArrowType == 2) {
      SetIndexStyle(0,DRAW_ARROW);
      SetIndexArrow(0, 241);
      SetIndexStyle(1,DRAW_ARROW);
      SetIndexArrow(1, 242);

   }
   else if (ArrowType == 3) {
      SetIndexStyle(0,DRAW_ARROW);
      SetIndexArrow(0, 221);
      SetIndexStyle(1,DRAW_ARROW);
      SetIndexArrow(1, 222);

   }
   else if (ArrowType == 4) {
      SetIndexStyle(0,DRAW_ARROW);
      SetIndexArrow(0, 217);
      SetIndexStyle(1,DRAW_ARROW);
      SetIndexArrow(1, 218);

   }
   else if (ArrowType == 5) {
      SetIndexStyle(0,DRAW_ARROW);
      SetIndexArrow(0, 228);
      SetIndexStyle(1,DRAW_ARROW);
      SetIndexArrow(1, 230);

   }
   else if (ArrowType == 6) {
      SetIndexStyle(0,DRAW_ARROW);
      SetIndexArrow(0, 236);
      SetIndexStyle(1,DRAW_ARROW);
      SetIndexArrow(1, 238);

   }
   else if (ArrowType == 7) {
      SetIndexStyle(0,DRAW_ARROW);
      SetIndexArrow(0, 246);


   }
   else if (ArrowType == 8) {
      SetIndexStyle(0,DRAW_ARROW);
      SetIndexArrow(0, 67);
      SetIndexStyle(1,DRAW_ARROW);
      SetIndexArrow(1, 68);

   }
   else if (ArrowType == 9) {
      SetIndexStyle(0,DRAW_ARROW);
      SetIndexArrow(0, 71);
      SetIndexStyle(1,DRAW_ARROW);
      SetIndexArrow(1, 72);
    }
   else if (ArrowType == 10) {
      SetIndexStyle(0,DRAW_ARROW);
      SetIndexArrow(0, 124);
      SetIndexStyle(1,DRAW_ARROW);
      SetIndexArrow(1, 124);
      

      
   }

   SetIndexStyle(2,DRAW_ARROW);
   SetIndexArrow(2, 119);
   SetIndexStyle(3,DRAW_ARROW);
   SetIndexArrow(3, 118);
   SetIndexStyle(4,DRAW_ARROW);
   SetIndexArrow(4, 118);
   SetIndexBuffer(0, CrossUp);
   SetIndexBuffer(1, CrossDown);
   SetIndexBuffer(2, CrossIndex);
   SetIndexBuffer(3, CrossUp1);
   SetIndexBuffer(4, CrossDown1);

//---- indicator short name
   ///switch(MA1Mode)
     ///{
      ///case 1 : MA1short_name="EMA";  break;
      ///case 2 : MA1short_name="SMMA"; break;
      ///case 3 : MA1short_name="LWMA"; break;
      ///default :
         ///MA1Mode=0;
         ///MA1short_name="SMA";
     ///}
   ///switch(MA2Mode)
     ///{
      ///case 1 : MA2short_name="EMA";  break;
      ///case 2 : MA2short_name="SMMA"; break;
      ///case 3 : MA2short_name="LWMA"; break;
      ///default :
         ///MA2Mode=0;
         ///MA2short_name="SMA";
     ///}

   //AlertPrefix=Symbol()+" ("+GetTimeFrameStr()+"):  ";
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//---- 

//----
   return(0);
  }
//+------------------------------------------------------------------+
bool NewBar()
{
   static datetime lastbar;
   datetime curbar = Time[0];
   if(lastbar!=curbar)
   {
      lastbar=curbar;
      return (true);
   }
   else
   {
      return(false);
   }
}   
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start() {
//if( TimeCurrent() > D'2022.03.01' ) return(0);
    // not yet expired, continue with normal logic
/*if(Name!=MyName)
    {
    Alert("Invalid File Name");
    return(0);
    }*/
//if (Period() != PERIOD_M1) {Alert("Invalid Time Frame");
  //  return(0);}
/*if(THE_PASSWORD !=PASS)
    {
    Alert("Invalid PASSWORD");
    return(0);
    }*/
int limit, i, counter;
Comment ("Copyright © 2023, E.S.A || ATROCITY || SUPPORT VER.S");
double Range, AvgRange;
int counted_bars=IndicatorCounted();
//---- check for possible errors
if(counted_bars<0) return(-1);
//---- last counted bar will be recounted
if(counted_bars>0) counted_bars--;
   
int minval = -1;
   
limit= Bars-counted_bars;
   //limit= LimitBARS;
      
for(i = 0; i < limit; i++) {
   
      counter=i;
      Range=0;
      AvgRange=0;
      for (counter=i ;counter<=i+9;counter++)
      {
         AvgRange=AvgRange+MathAbs(High[counter]-Low[counter]);
      }
      Range=AvgRange/10;
      ////
for(i = 0; i < limit; i++) {

double close1 = iClose(Symbol(), PERIOD_CURRENT, i+1);
double close2 = iClose(Symbol(), PERIOD_CURRENT, i+2);
double close3 = iClose(Symbol(), PERIOD_CURRENT, i+3);
/////////////////////////////////////////////////////
double high1 = iHigh(Symbol(), PERIOD_CURRENT, i+1);
double high2 = iHigh(Symbol(), PERIOD_CURRENT, i+2);
double high3 = iHigh(Symbol(), PERIOD_CURRENT, i+3);
/////////////////////////////////////////////////////
double low1 = iLow(Symbol(), PERIOD_CURRENT, i+1);
double low2 = iLow(Symbol(), PERIOD_CURRENT, i+2);
double low3 = iLow(Symbol(), PERIOD_CURRENT, i+3);
/////////////////////////////////////////////////////
double open1 = iOpen(Symbol(), PERIOD_CURRENT, i+1);
double open2 = iOpen(Symbol(), PERIOD_CURRENT, i+2);
double open3 = iOpen(Symbol(), PERIOD_CURRENT, i+3);
/////////////////////////////////////////////////////
double volume1 = iVolume(Symbol(), PERIOD_CURRENT, i+1);
double volume2 = iVolume(Symbol(), PERIOD_CURRENT, i+2);
double volume3 = iVolume(Symbol(), PERIOD_CURRENT, i+3);
/////////////////////////////////////////////////////
double body1 = (close1 - open1);
double body2 = (close2 - open2);
double body3 = (close3 - open3);
////////////////////////////////////////////////////
double body1true, body2true, body3true;
///////////////////////////////////////////////////
double volIncrease = (((volume1 - volume2) / volume2) * 100);
double volIncrease2 = (((volume2 - volume3) / volume3) * 100);// > volRasio
////////////////////////////////////////////////////
double voldecrease2 = (((volume3 - volume2) / volume2) * 100);// > volRasio
///////////////////////////////////////////////////

//if (body1 < 0) body1true = body1 * minval;
//else  body1true = body1;
//////////////////////////////////////////////////
//if (body2 < 0)body2true = body1 * minval;
//else  body2true = body2;
//////////////////////////////////////////////////
//if (body3 < 0)body3true = body3 * minval;
//else  body3true = body3;

////////////////////////////////////////////////
//double bodydiff1increase = (((body1true - body2true)/ body2true) * 100);
//double bodydiff2increase = (((body2true - body3true)/ body3true) * 100);


      if  (((close1 > open1) && (volume1 > volume2) && (volIncrease >= volRasio) && (close1 > high2) && (close2 < open2) && (body1 > body2) && (close3 < open3)) && (
           ((body2 > body3) && (volume2 < volume3) /*&& (voldecrease2 > volRasio)*/) || 
           ((body2 > body3) && (volume2 > volume3) /*&& (volIncrease2 > volRasio)*/) ||
           ((body2 < body3) && (volume2 < volume3) /*&& (voldecrease2 > volRasio)*/)
           
                   )){  
                   //CrossUp1[i-1] = Low[i-1] - Range*1.5;
                   CrossUp[i+1] = Low[i+1] - Range*1;
                   CrossIndex[i+1] = Low[i+1];
                   //Alerts ("Buy 3-5 BAR ",SoundFileShort);
                   if (NewBar() && lastAlert!=0) { lastAlert=0; doAlerts ("Buy 15 BAR ",SoundFileShort); }
                   }
      else if (((close1 < open1) && (volume1 > volume2) && (volIncrease >= volRasio) && (close1 < low2) && (close2 > open2) && (body1 < body2) && (close3 > open3)) && (
               ((body2 < body3) && (volume2 < volume3) /*&& (voldecrease2 > volRasio)*/) || 
               ((body2 < body3) && (volume2 > volume3) /*&& (voldecrease2 > volRasio)*/) ||
               ((body2 > body3) && (volume2 < volume3) /*&& (voldecrease2 > volRasio)*/)
           
                   )){  
                   //CrossDown1[i-1] = High[i-1] + Range*1.5;
                   CrossDown[i+1] = High[i+1] + Range*1;
                   CrossIndex[i+1] = High[i+1];
                   //Alerts("Sell 3-5 BAR ",SoundFileShort);
                   if (NewBar() && lastAlert!=1) { lastAlert=1; doAlerts("Sell 15 BAR ",SoundFileShort); }
              	    }
   }
 }
   return(0);
}

void doAlerts(string msg,string SoundFile) {
        msg="PLEAIDES "+Symbol()+", period "+TFtoStr(Period())+": "+msg+",servertime: "+TimeToStr(TimeCurrent());
 string emailsubject="MT4 alert on acc. "+AccountNumber()+", "+WindowExpertName()+" - Alert on "+Symbol()+", period "+TFtoStr(Period());
  if (PopupAlerts) Alert(msg);
  if (EmailAlerts) SendMail(emailsubject,msg);
  if (PushNotificationAlerts) SendNotification(msg);
  if (SoundAlerts) PlaySound(SoundFile);
}//void doAlerts(string msg,string SoundFile) {

string TFtoStr(int period) {
 if (period==0) period=Period();
 switch(period) {
  case 1     : return("M1");  break;
  case 5     : return("M5");  break;
  case 15    : return("M15"); break;
  case 30    : return("M30"); break;
  case 60    : return("H1");  break;
  case 240   : return("H4");  break;
  case 1440  : return("D1");  break;
  case 10080 : return("W1");  break;
  case 43200 : return("MN1"); break;
  default    : return(DoubleToStr(period,0));
}
 return("UNKNOWN");
}//string TFtoStr(int period) {