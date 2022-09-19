clc;
clear;
clearvars;

  [tel,fs]= audioread('tel.wav');
  disp("*******************VERİLEN SES*******************");
  fprintf("Örnekleme Frekansı(fs) -------> %d kHz",fs);

  nSamp=length(tel);
  t = (1/fs)*(1:nSamp);
  
  
  figure (1);
  subplot(4,3,1); plot(t,tel); xlabel("zaman"); ylabel("genlik");
  subplot(4,3,2); stem(t,tel); xlabel("frekans"); ylabel("genlik");
  
  sound(tel,fs);
  pause(3);
  
  Len=length(tel);
  d=floor(Len/8);
  
  tel1=tel(1:d);
  y1=abs(fft(tel1));
  k = length(y1);
  f1 = fs*(0:k-1)/k;
  u = floor(length (y1)/2);
  subplot(4,3,3); plot(f1(1:u),y1(1:u));
  
  for i=1:7
    
      if i ~= 3
      tel1 = tel(d*i:d*(i+1));
      y1 = abs(fft(tel1));
      k = length(y1);
      f1 = fs*(0:k-1)/k;
      u = floor(length (y1)/2);
      subplot(4,3,i+3); plot(f1(1:u),y1(1:u));
      end

    end
  
  
  [num,fsamp] = audioread('no.wav');
  disp("**************GİRDİĞİM NUMARANIN SESİ****************");
  sound(num,fsamp);

  fprintf("Örnekleme Frekansı(fs) -------> %d kHz",fsamp);
  nSamp=length(num);
  t2 = (1/fsamp)*(1:nSamp);
 
  Len=length(num);
  
  d = floor(Len/11);
  
  figure(2);
  subplot(2,1,1);  plot(num); title("plot grafiği");
  subplot(2,1,2);  stem(num); title("stem grafiği");
  
  num1 = num(1:d);
  y1 = abs(fft(num1));
  k = length(y1);
  u = floor(length (y1)/2);
  f1 = fsamp*(0:k-1)/k ;

  figure(3);
  
  subplot(3,4,1); plot(f1(1:u),y1(1:u)); xlabel("Frekans"); ylabel("Genlik"); title("1");
  
  for i=1:11
    
    num1 = num(d*i:d*(i+1));
    y1 = abs(fft(num1));
    k = length(y1);
    u = floor(length (y1)/2);
    
    f1 = fsamp*(0:k-1)/k;
    subplot(3,4,i+1) ; plot(f1(1:u),y1(1:u)); xlabel("Frekans"); ylabel("Genlik"); title(i+1); 
   


end;