% Code by Tedi-Marie Usher (UF/NCSU) with guidance from John E. Daniels (UNSW)
% written in 2012 

clear all;

y = .25;   % distance from sample to detector in m
i = [ 0 1 0 ]; %direction of the beam is y
angle = 5.5;  % angle you want to rotate the sample(electric field vector) 
            % away from the detector in degrees
E1 = [ 0 -tand(angle) 1 ];
E = E1/(norm(E1));

lamda = 0.1430e-10; % wavelength in m (86.7 keV 11-ID-B)
% lamda = 0.2114e-10; %wavelength in m (58.66 keV 11-ID-B)
% lamda = 0.11798e-10; %wavelength in m (105.091 keV 11-ID-C)
pixel = 200e-6;  % detector pixel size in m

x1 = (-1024:1024); %puts zero at the center of the array horizontally
z2 = (-1024:1024)'; %puts zero at the center of the array vertically
z1 = flipud(z2);
x = pixel*x1;
z = pixel*z1;

a = ones(2049,2049); %# of pixels in detector
eta = ones(2049,2049); 
eta2 = ones(2049,2049); 
% d = ones(2001,2001,3); 


for u = (1:2049);
    for v = (1:2049);
    
%         d(u,v,1)= x(v); %good to know how to use 3D matrices, but not necessary
%         d(u,v,2)= y;
%         d(u,v,3)= z(u);
%         f = [ d(u,v,1) d(u,v,2) d(u,v,3) ];

        a(u,v)= sqrt((z(u))^2 + (x(v))^2);  %distance to arbitrary pixel
        
        f = [ x(v) y z(u) ]; %final scattered beam
        
        q = f/(norm(f)) - i; %unit vector in scattering vector direction
        
        eta(u,v) = acosd((dot(E,q))/(norm(E)*norm(q)));
                
        if eta(u,v) > 89.99;
           eta2(u,v) = -eta(u,v) + 180;
        elseif eta(u,v) < 89.99;
            eta2(u,v) = eta(u,v);
        end  
        
    end
end

theta = (atand(a./y))/2;        
Q1 = (4*pi*sind(theta))./lamda;

 
if 1==1
    % Shows the distribution of Q and E in 10 degree steps where positive 
    % and negative are different
    figure(1) 
    contourf(flipud(eta),34,'linecolor','none')
    caxis([0 170])
    colorbar
    colormap(jet(17))
    
    % Shows the distribution of Q and E in 5 degree steps where positive
    % and negative are the same
    figure(2)
    contourf(flipud(eta2),17,'linecolor','none')
    caxis([0 90])
    colorbar
    colormap(jet(18))

    % Shows the distribution of Q values on the detector.
    figure(3)
    contourf(flipud(Q1),10)
    caxis([1e11 4e11])
    colorbar
      
end


  figure(4)
    contourf(flipud(theta),17,'linecolor','none')
    caxis([0 90])
    colorbar
% % 
% % %     figure(5)
% % %     contourf(flipud(eta),34,'linecolor','none')
% % %     caxis([0 170])
% % %     colorbar
% % %     colormap(jet(17))
% % %     contourf(flipud(Q1),17)
% % %     caxis([0 4e11])
% % %     colorbar
% % 
% % 
% % % contourf(flipud(eta2),20);
% % % linewidth=0;
% % 
% % % figure2 = contourf(flipud(eta2),20);
% % 
% % % eta(u,v) = acosd((dot(E,([x(u) y z(v) ]-i))/(norm(E)*norm(([x(u) y z(v) ]-i))));
% %   
% % %each element in matrix a is the distance from that point to the center of
% % %the detector
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % % b = ones(11,11); 
% % % y = 5; % distance from sample to detector
% % % for u = (1:11);
% % %     for v = (1:11);
% % %         b(u,v)= atand((a(u,v))/y);
% % %     end
% % % end
% % % 
% % %each element in matrix b is the angle between the scattered path and the 
% % %incident path
% % 
