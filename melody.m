n=10; length=20; harmon=10; df=0.1; 
t=(1:length*44100)/44100; 
y=0; 
for i = 0:n 
  for j = 1:harmon 
    y=y+sin(2*3.1415927*(55+i*df)*j*t); 
  end 
end
sound(y/(n*harmon),44100);