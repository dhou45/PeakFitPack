% Convert the current file names to uniform digits for SPring-8 data
files = dir('*.gr');
%or use the following in general
%files = dir;
%files = files(~ismember({files.name},{'.','..'}));

for id = 1:length(files)
    % Get the file name (minus the extension)
    [~, f] = fileparts(files(id).name);
    % Convert to number
      num = str2double(f);
      if ~isnan(num)
      	if ~strcmp(sprintf('%05d', num), f)
          movefile(files(id).name, sprintf('%05d.gr', num));
        end
      end
end

%check the total digits numbers
files = dir('*.fq');
%or use the following in general
%files = dir;
%files = files(~ismember({files.name},{'.','..'}));

for id = 1:length(files)
    % Get the file name (minus the extension)
    [~, f] = fileparts(files(id).name);
    % Convert to number
      num = str2double(f);
      if ~isnan(num)
      	if ~strcmp(sprintf('%05d', num), f)
          movefile(files(id).name, sprintf('%05d.fq', num));
        end
      end
end




# read SPring8 .fq files, and save as .mat

endframe=3151;

m=[];
list = dir ('*.fq*');
names_cell = {list.name};
m=[readSPring8x('00000.fq', 3) m];
a=[1:25:endframe];
a= [0 a];
for name = names_cell
       m= [m readSPring8(name{1}, 3)];
end
m=[a; m];
save('FQ.mat', 'm');


# read SPring8 .gr files, and save as .mat

endframe=3126;

m=[];
list = dir ('*.gr*');
names_cell = {list.name};
m=[readSPring8x('00000.gr') m];
a=[1:25:endframe];
a= [0 a];
for name = names_cell
       m= [m readSPring8(name{1})];
end
m=[a; m];
save('Gr.mat', 'm');



# read SPring8 .fq files, and save as .mat for BNT_5exc_001_heating

m=[];
list = dir ('*.fq*');
names_cell = {list.name};
m=[readSPring8x('0000.fq', 3) m];
a=[1:25:1526];
a= [0 a];
for name = names_cell
       m= [m readSPring8(name{1}, 3)];
end
m=[a; m];
save('FQ.mat', 'm');


% read SPring8 .fq files, and save as .mat for BTO_SolGel_002_heat

m=[];
list = dir ('*.fq*');
names_cell = {list.name};
m=[readSPring8x('00000.fq', 3) m];
a=[1:25:1751];
a= [0 a];
for name = names_cell
       m= [m readSPring8(name{1}, 3)];
end
m=[a; m];
save('FQ.mat', 'm');



% read SPring8 .gr files, and save as .mat for BTO_SolGel_002_heat all frame
clear
m=[];
list = dir ('*.gr');
names_cell = {list.name};
first_file_cell = names_cell(1);
first_file = first_file_cell{1};
m=[readSPring8x(first_file, 3) m];
a=[1:1:length(list)];
a= [0 a];
for name = names_cell
       m= [m readSPring8(name{1}, 3)];
end
m=[a; m];
save('GR.mat', 'm');

% Save only 1-10 Angstrom range, and 150-650 frames
frame_start = 1;
frame_end = 600;
m2= m([1 102:1002],[1 frame_start+1:frame_end+1]);
save('GR_Sub.mat', 'm2');


# read SPring8 .fq files, and save as .mat for BTO_SolGel_002_heat all frame
clear
m=[];
list = dir ('*.fq');
names_cell = {list.name};
first_file_cell = names_cell(1);
first_file = first_file_cell{1};
m=[readSPring8x(first_file, 3) m];
a=[1:1:length(list)];
a= [0 a];
for name = names_cell
       m= [m readSPring8(name{1}, 3)];
end
m=[a; m];
save('FQ.mat', 'm');


% read .gr files, and delete the header
% importfile1, import gr file, and convert to .xy format

m=[];
list = dir ('*.gr*');
names_cell = {list.name};
for name = names_cell
       importfile1(name{1});
end


m=[];
list = dir ('*.xy*');
names_cell = {list.name};
for name = names_cell
       importfile1_xy(name{1});
end



% check RDF min values
m=[];
list = dir ('*.xy');
names_cell = {list.name};
first_file_cell = names_cell(1);
first_file = first_file_cell{1};
for name = names_cell
       m= [m readSPring8_getMin(name{1}, 1)];
end

offset_value= min(min(m))


