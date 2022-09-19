clc;  clear;  clear all;


  disp('**************x[n] AYRIK ZAMANLI ÝÞARETÝ**************');
  n = input('x[n] için boyut giriniz : ');
  for i=1:n
   xn(i) = input('indis:'); %indisleri tuttugum bir matris olusturdum
    fprintf('x[%d] deðeri:',i);
    x(i)= input(''); %girilen indisteki deðeri alýyoruz
  end

  disp('**************h[m] AYRIK ZAMANLI ÝÞARETÝ**************');
  m = input('h[m] için boyut giriniz : ');
  for i=1:m
   hm(i) = input('indis:');
   fprintf('h[%d] deðeri:',i);
    h(i)= input('');
  end

  [y,yn] = myConv(x,xn,h,hm);
  ynew = conv(x,h);
  
  figure;
  subplot(4,2,1) ; stem(xn,x) ; xlabel('n'); ylabel('x[n]'); title('x[n] ');
  subplot(4,2,2) ; stem(hm,h) ; xlabel('n'); ylabel('h[n]'); title('h[n] ');
  subplot(4,2,3) ; stem(yn,y) ; xlabel('n'); ylabel('y[n]'); title('y[n] with myConv');
  subplot(4,2,4) ; stem(yn,ynew) ; xlabel('n'); ylabel('y[n]'); title('y[n] with conv');
  fprintf('x[n]---------------------->'); disp(x);
  fprintf('h[n]---------------------->'); disp(h);
  fprintf('myConv-------------------->'); disp(y);
  fprintf('Hazýr conv fonksiyonu----->'); disp(ynew);

  recObj = audiorecorder;
  disp('Start speaking for 5 secs.');
  recordblocking(recObj, 5);
  disp('End of Recording.');
  x1 = getaudiodata(recObj);
  disp('wait for 2 secs.');
  pause(2);
  recObj = audiorecorder;
  disp('Start speaking for 10 secs.');
  recordblocking(recObj, 10);
  disp('End of Recording.');
  x2 = getaudiodata(recObj);


  Y2= zeros(1,801);
  Y2(1)=1;
  Y2(401)=0.4;
  Y2(801)=0.4;


  conv_Y1 = conv(x1,Y2);
  subplot(4,2,7); stem(conv_Y1); xlabel('n'); ylabel('conv_Y1[n]');title('conv_Y1[n]');
  conv_Y2 = conv(x2,Y2);
  subplot(4,2,8); stem(conv_Y2); xlabel('n'); ylabel('conv_Y2[n]');title('conv_Y2[n]');

  for i=1:1:length(x1)
   x1len(i)= i;
  end
  for i=1:1:length(x2)
   x2len(i)= i;
  end
  for i=1:1:length(Y2)
    y2len(i)=i;
  end
  [my_Y1,x1len] = myConv(x1,x1len,Y2,y2len);
  subplot(4,2,5); stem(my_Y1); xlabel('n'); ylabel('my_Y1[n]');title('my_Y1[n]');
  [my_Y2,x2len] = myConv(x2,x2len,Y2,y2len);
  subplot(4,2,6); stem(my_Y2); xlabel('n'); ylabel('my_Y2[n]');title('my_Y2[n]');
  
  disp('5 saniyelik ses');
  sound(x1);
  pause(1);
  disp('5 saniyelik sesin myConv ile konvolüsyon yapýlmýþ hali');
  sound(my_Y1);
  pause(1);
  disp('5 saniyelik sesin conv fonksiyonu ile konvolüsyon yapýlmýþ hali');
  sound(conv_Y1);
  pause(1);
  disp('10 saniyelik ses');
  sound(x2);
  pause(1);
  disp('10 saniyelik sesin myConv ile konvolüsyon yapýlmýþ hali');
  sound(my_Y2);
  pause(1);
  disp('10 saniyelik sesin conv fonksiyonu ile konvolüsyon yapýlmýþ hali');
  sound(conv_Y2);

function [y,yn] = myConv(x,xn,h,hm)
  l1= length(x);
  l2=length(h);
  
  startPoint = xn(1) + hm(1);
  endPoint = xn(l1) + hm(l2);
  yn = startPoint:endPoint;
  y = hesap(x,h)
  
  end
  
function [y] = hesap(x,h)
  l1= length(x);
  l2=length(h);
  N=l1+l2-1;
  y = zeros(1, N);
  
  for i=1:l1
    for j=1:l2
      y(i+j-1) = y(i+j-1) + x(i)*h(j) ;
    end
  end
  
  end