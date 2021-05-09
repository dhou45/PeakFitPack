% Code by Tedi-Marie Usher (UF/NCSU) written in 2012 

y = .35;   % distance from sample to detector in m
i = [ 0 1 0 ]; %direction of the beam is y
angle = 7;  % angle you want to rotate the sample(electric field vector) 
            % away from the detector in degrees
E1 = [ 0 -tand(angle) 1 ];
E = E1/(norm(E1));
 lamda = 0.1430e-10; % wavelength in m (86.7 keV 11-ID-B)
% lamda = 0.2114e-10; %wavelength in m (58.66 keV 11-ID-B)
% lamda = 0.11798e-10; %wavelength in m (115 keV 11-ID-C)

pixel = 200e-6;   
numpixels = 1024; %number of pixels from center to top edge

z = pixel*numpixels;

theta = (atand(z/y))/2;        
Q1 = (4*pi*sind(theta))/lamda;
Q = Q1*1e-10;


