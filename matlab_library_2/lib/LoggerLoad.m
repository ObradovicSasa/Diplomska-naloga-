function [ OutPut ] = LoggerLoad()
%LOGGERLOAD Summary of this function goes here
%
%   Date modefied:5.8.2013
%       Popravljena sens vrtica za magnetometer, giroskop, temperaturo
%   Date modefied:22.7.2013
%       -Spisana funkcija;
%       -Pri funkciji device_set popravljena vrednost pri
%         signed vektorju(1,8) iz 1 na 0

%%
[FileName,PathName] = uigetfile('*.bin','Select the BIN file');

terms = strsplit(FileName, '.');
binFile=[PathName,FileName];
metaFile=[PathName, char(terms(1,1)),'.meta'];

[Data, Names]=bin2decMY( binFile, metaFile );
%%
AllNames =     {'TIMESTAMP',   'BATVOL',   'SYSTEMP', 'EXTRIG',...
                           'INAN01',       'INAN02',       'INAN03',       'INAN04',...
                           'ACC1X',    'ACC1Y',    'ACC1Z',...
                           'GYR1X',    'GYR1Y',    'GYR1Z',    'GYR1T',...
                           'MAG1X',    'MAG1Y',    'MAG1Z',...
                           'ACC2X',    'ACC2Y',    'ACC2Z',...
                           'CHECKSUM',     'ENDMARKER'};
mask=zeros(1,length(AllNames));
i=1;
for j=1:length(mask)
    if strcmp(AllNames(1,j), Names(1,i))
        mask(1,j)=1;
        i=i+1;
    end
end
    
    

[settings, ~] = settingsdlg(...
    'Description', 'Check/Uncheck proper signals',... 
    'title'      , 'Logger signals import',...
    'separator'  , 'Constrained',...    
    {'Time'; 'time'}, true,...
    {'Battery Voltage'; 'bat'}, false,...
    {'Systemp'; 'sys'}, false,...
    {'Trigger'; 'trig'}, false,...
    'separator'  , 'Analog Input',...
    {'MC'; 'MC'}, [false,true],...
    {'MC1'; 'mc1'}, true,...
    {'MC2'; 'mc2'}, true,...
    {'MC3'; 'mc3'}, true,...
    {'MC4'; 'mc4'}, true,...
    'separator'  , 'Accelerometer #1',...
    {'ACC1'; 'ACC1'}, [true,false],...
    {'X axis'; 'accX_1'}, true,...
    {'Y axis'; 'accY_1'}, true,...
    {'Z axis'; 'accZ_1'}, true,...
    'separator'  , 'Gyroscope',...    
    {'GYR'; 'GYR'}, [false,true],...
    {'X axis'; 'gyrX'},  true,...
    {'Y axis'; 'gyrY'}, true,...
    {'Z axis'; 'gyrZ'}, true,...
    {'T axis'; 'gyrT'}, false,...
    'separator'  , 'Magnetometer',...    
    {'MAG'; 'MAG'}, [false,true],...
    {'X axis'; 'magX'}, true,...
    {'Y axis'; 'magY'}, true,...
    {'Z axis'; 'magZ'}, true,...
    'separator'  , 'Accelerometer #2',...    
    {'ACC2'; 'ACC2'}, [false,true],...
    {'X axis'; 'accX_2'}, true,...
    {'Y axis'; 'accY_2'}, true,...
    {'Z axis'; 'accZ_2'}, true,...
    'separator'  , 'Other',...    
    {'Check sum'; 'checksum'}, false,...
    {'End marker'; 'endmarker'}, false);

maskOut=zeros(1,length(mask));
i=1;
if settings.time==1 && i==1
    maskOut(1,i)=1;
    i=i+1;
else i=i+1;
end
if settings.bat==1 && i==2
    maskOut(1,i)=1;
    i=i+1;
else i=i+1;
end
if settings.sys==1&& i==3
    maskOut(1,i)=1;
    i=i+1;
else i=i+1;
end
if settings.trig==1&& i==4
    maskOut(1,i)=1;
    i=i+1;
else i=i+1;
end
if settings.MC==1&& i==5
    maskOut(1,i)=[settings.mc1];
    maskOut(1,i+1)=[settings.mc2];
    maskOut(1,i+2)=[settings.mc3];
    maskOut(1,i+3)=[settings.mc4];
    i=i+4;
else i=i+4;
end
if settings.ACC1==1&& i==9
    maskOut(1,i)=[settings.accX_1];
    maskOut(1,i+1)=[settings.accY_1];
    maskOut(1,i+2)=[settings.accZ_1];
    i=i+3;
else i=i+3;
end
if settings.GYR==1&& i==12
    maskOut(1,i)=[settings.gyrX];
    maskOut(1,i+1)=[settings.gyrY];
    maskOut(1,i+2)=[settings.gyrZ];
    maskOut(1,i+3)=[settings.gyrT];
    i=i+4;
else i=i+4;
end
if settings.MAG==1&& i==16
    maskOut(1,i)=[settings.magX];
    maskOut(1,i+1)=[settings.magY];
    maskOut(1,i+2)=[settings.magZ];
    i=i+3;
else i=i+3;
end
if settings.ACC2==1&& i==19
    maskOut(1,i)=[settings.accX_2];
    maskOut(1,i+1)=[settings.accY_2];
    maskOut(1,i+2)=[settings.accZ_2];
    i=i+3;
else i=i+3;
end
if settings.checksum==1&& i==22
    maskOut(1,i)=1;
    i=i+1;
else i=i+1;
end
if settings.endmarker==1&& i==23
    maskOut(1,i)=1;
end
[~,s1]=find(mask==1);
[~,s2]=find(maskOut==1);
OutPut=zeros(length(Data),length(s2));
for j=1:length(s2)
    [~,s3]=find(s1==s2(1,j));
    if isempty(s3)
        error('Signal dose not exsite.')
    end
    OutPut(:,j)=Data(:,s3);
end

OutPut(:,1)=(OutPut(:,1)-OutPut(1,1))/1000000;            %Pretvorba v sekunde

end
%%



%-------------------------------------------------------------------------------------------------------------------------------------------------
%BIN2DEC function
function [ output,columnsNames ] = bin2decMY( dataFile, metaFile, destPath )
%   bin2dec bin -> values converter
%   reads tmg logger binary data file and converts bin data to values

fid = fopen(dataFile);
p1=(fread(fid,[1 inf],'uint16'));
fclose(fid);

[columnsNames, args] = device_set(metaFile);

s = size(args);
ms = s(2);
cursor = 1;
column = 0;
line = zeros(1,max(size(columnsNames)));

%line length in bytes
linelen = sum(args(1, :));
%samples
vseh = floor(max(size(p1))/linelen)*2;

output = zeros(vseh, ms);
linen = 1;
while cursor < max(size(p1))
    column = column + 1;
    
    if column > ms
        column = 1;
    end
    
    bytes = args(1, column);
    signed = args(2, column);
    sens = args(3, column);
    bias = args(4, column);
    
    raw = 0;
    if bytes == 2
        raw = p1(cursor);
    elseif bytes == 4
        raw = 65536*p1(cursor+1) + p1(cursor);
    else
        raw = -1;
    end

    if signed
        raw = (raw-(sign((raw-32767))+1)*1/2*65536);
    end
    
    value = raw*sens+bias;

    line(1,column) = value;
    
    if column == ms
        output(linen, :) = line;
        linen = linen+1;
    end
        
    cursor = cursor + bytes/2; 
end

% write csv
if nargin == 3
    dlmwrite(destPath, output, ',');
end

end
%%
%DEVICE_SET function
function [ names, out ] = device_set( filename )
%DEVICE_SET parses device.set & .meta files. 
%   returns list of column names, array of column lenghts in bytes, array
%   of signs, array of sensitivities and array of biases

names =     {'TIMESTAMP',   'BATVOL',   'SYSTEMP',   'EXTRIG',    'INAN01',       'INAN02',       'INAN03',       'INAN04',       'ACC1X',    'ACC1Y',       'ACC1Z',    'GYR1X',    'GYR1Y',    'GYR1Z',    'GYR1T',    'MAG1X',    'MAG1Y',    'MAG1Z',      'ACC2X',      'ACC2Y',      'ACC2Z',    'CHECKSUM',     'ENDMARKER'};
log =            [                    1,                1,                   1,                1,                 1,                    1,                     1,                    1,                  1,               1,                  1,               1,               1,                1,              0,                 1,                 1,                 1,                 1,                 1,                 1,                        0,                           1];
bytes =        [                    4,                2,                   2,                2,                 2,                    2,                     2,                    2,                  2,                2,                 2,               2,               2,                2,              2,                 2,                 2,                 2,                 2,                 2,                 2,                        0,                           2];
signed =     [                     0,               1,                   1,                1,                  0,                    0,                    0,                    0,                   1,                1,                 1,               1,              1,                1,               1,                1,                  1,                 1,                 1,                1,                  1,                       1,                            1];
sens =        [                      1,               1,                   1,               1, 3300/4096,  3300/4096,  3300/4096,  3300/4096,     0.012/16,  0.012/16,  0.012/16,              1,               1,                1,               1,                1,                 1,                  1,  0.001/16,  0.001/16,    0.001/16,                       1,                           1];
bias =        [                      0,                0,                  0,               0,                    0,                   0,                    0,                    0,                    0,                0,                0,              0,               0,                 0,              0,                0,                 0,                  0,                 0,                0,                  0,                       0,                           0];

fid = fopen(filename);
line = fgetl(fid);


while ischar(line)
    tline = strrep(strtrim(line), '\t', ' ');
    fnd = strfind(tline, '//');
    ok = 0;
    if max(size(fnd)) == 0
        ok = 1;
    elseif fnd(1) > 1
        ok = 1;
    else
        ok = 0;
    end
    if  ok == 1
        % if line not commented
        settings = strsplit(tline);
        param = settings(1);
        v = str2double(settings(2));
        
        if strcmp(param, 'SAMPLING_DATA_RATE')
            
        elseif strcmp(param, 'FILE_LOG_TIMESTAMP')
            if v == 0
                log(1) = 0;
            else
                log(1) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_BATVOLT')
            if v == 0
                log(2) = 0;
            else
                log(2) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_SYSTEMP')
            if v == 0
                log(3) = 0;
            else
                log(3) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_EXTRIG')
            if v == 0
                log(4) = 0;
            else
                log(4) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_INAN01')
            if v == 0
                log(5) = 0;
            else
                log(5) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_INAN02')
            if v == 0
                log(6) = 0;
            else
                log(6) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_INAN03')
            if v == 0
                log(7) = 0;
            else
                log(7) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_INAN04')
            if v == 0
                log(8) = 0;
            else
                log(8) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_ACC1X')
            if v == 0
                log(9) = 0;
            else
                log(9) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_ACC1Y')
            if v == 0
                log(10) = 0;
            else
                log(10) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_ACC1Z')
            if v == 0
                log(11) = 0;
            else
                log(11) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_GYR1X')
            if v == 0
                log(12) = 0;
            else
                log(12) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_GYR1Y')
            if v == 0
                log(13) = 0;
            else
                log(13) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_GYR1Z')
            if v == 0
                log(14) = 0;
            else
                log(14) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_GYR1T')
            if v == 0
                log(15) = 0;
            else
                log(15) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_MAG1X')
            if v == 0
                log(16) = 0;
            else
                log(16) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_MAG1Y')
             if v == 0
                log(17) = 0;
            else
                log(17) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_MAG1Z')
            if v == 0
                log(18) = 0;
            else
                log(18) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_ACC2X')
            if v == 0
                log(19) = 0;
            else
                log(19) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_ACC2Y')
            if v == 0
                log(20) = 0;
            else
                log(20) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_ACC2Z')
            if v == 0
                log(21) = 0;
            else
                log(21) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_CHECKSUM')
            if v == 0
                log(22) = 0;
            else
                log(22) = 1;
            end
        elseif strcmp(param, 'FILE_LOG_ENDMARKER')
            if v == 0
                log(23) = 0;
            else
                log(23) = 1;
            end
        elseif strcmp(param, 'DEV_LM75BGD_EN')
            sens(1,3)=1/280;
            
        elseif strcmp(param, 'DEV_LIS331HH_EN')
            
        elseif strcmp(param, 'DEV_LIS331HH_FS')
            if v == 0
                sens(1,9:11) = 0.003/16;
            elseif v == 1
                sens(1,9:11) = 0.006/16;
            elseif v == 3
                sens(1,9:11) = 0.012/16;
            end
        elseif strcmp(param, 'DEV_ITG3200_EN')
            if v==1
                sens(1,12:15) =1/14.375;
            end
            
        elseif strcmp(param, 'DEV_ITG3200_FI')
            
        elseif strcmp(param, 'DEV_LSM303DLM_AEN')
            
        elseif strcmp(param, 'DEV_LSM303DLM_MEN')
            
        elseif strcmp(param, 'DEV_LSM303DLM_AFS')
            if v == 0
                sens(1,19:21) = 0.001/16;
            elseif v == 1
                sens(1,19:21) = 0.002/16;
            elseif v == 3
                sens(1,19:21) = 0.0039/16;
            end
        elseif strcmp(param, 'DEV_LSM303DLM_MFS')
            %       1 gauss= 10^-4 Tesla       (1 G=100 uT)
            %       Earth Magnetic field at it's surfice = 0.31?0.58 G
            if v == 1
                sens(16) = 1/1100;
                sens(17) = 1/1100;
                sens(18) = 1/980;
            elseif v == 2
                sens(16) = 1/855;
                sens(17) = 1/855;
                sens(18) = 1/760;
            elseif v == 3
                sens(16) = 1/670;
                sens(17) = 1/670;
                sens(18) = 1/600;
            elseif v == 4
                sens(16) = 1/450;
                sens(17) = 1/450;
                sens(18) = 1/400;
            elseif v == 5
                sens(16) = 1/400;
                sens(17) = 1/400;
                sens(18) = 1/355;
            elseif v == 6
                sens(16) = 1/330;
                sens(17) = 1/330;
                sens(18) = 1/295;
            elseif v == 7
                sens(16) = 1/230;
                sens(17) = 1/230;
                sens(18) = 1/205;
            end
        elseif strcmp(param, 'BATM_INT')
            
        elseif strcmp(param, 'BATM_FUL')
            
        elseif strcmp(param, 'BATM_MED')
            
        elseif strcmp(param, 'BATM_LOW')
            
        elseif strcmp(param, 'RF_OWN_ADDR')
            
        elseif strcmp(param, 'RF_P0R_ADDR')
            
        elseif strcmp(param, 'RF_CHANNEL')
            
        elseif strcmp(param, 'RF_CARRIER_TEST')
                
        end
    end
    line = fgetl(fid);
end

fclose(fid);
namesout = {};
out = [];
s = size(names);

% filter columns...
for i=1:max(s)
    if log(i) == 1
        namesout = [namesout, names(i)];
        out = [out,[bytes(i); signed(i); sens(i); bias(i)]];
    end
end
names = namesout;
end
%%
%STRSPLIT function
function terms = strsplit(s, delimiter)
%STRSPLIT Splits a string into multiple terms
%
%   terms = strsplit(s)
%       splits the string s into multiple terms that are separated by
%       white spaces (white spaces also include tab and newline).
%
%       The extracted terms are returned in form of a cell array of
%       strings.
%
%   terms = strsplit(s, delimiter)
%       splits the string s into multiple terms that are separated by
%       the specified delimiter. 
%   
%   Remarks
%   -------
%       - Note that the spaces surrounding the delimiter are considered
%         part of the delimiter, and thus removed from the extracted
%         terms.
%
%       - If there are two consecutive non-whitespace delimiters, it is
%         regarded that there is an empty-string term between them.         
%
%   Examples
%   --------
%       % extract the words delimited by white spaces
%       ts = strsplit('I am using MATLAB');
%       ts <- {'I', 'am', 'using', 'MATLAB'}
%
%       % split operands delimited by '+'
%       ts = strsplit('1+2+3+4', '+');
%       ts <- {'1', '2', '3', '4'}
%
%       % It still works if there are spaces surrounding the delimiter
%       ts = strsplit('1 + 2 + 3 + 4', '+');
%       ts <- {'1', '2', '3', '4'}
%
%       % Consecutive delimiters results in empty terms
%       ts = strsplit('C,Java, C++ ,, Python, MATLAB', ',');
%       ts <- {'C', 'Java', 'C++', '', 'Python', 'MATLAB'}
%
%       % When no delimiter is presented, the entire string is considered
%       % as a single term
%       ts = strsplit('YouAndMe');
%       ts <- {'YouAndMe'}
%

%   History
%   -------
%       - Created by Dahua Lin, on Oct 9, 2008
%

%% parse and verify input arguments


assert(ischar(s) && ndims(s) == 2 && size(s,1) <= 1, ...
    'strsplit:invalidarg', ...
    'The first input argument should be a char string.');

if nargin < 2
    by_space = true;
else
    d = delimiter;
    assert(ischar(d) && ndims(d) == 2 && size(d,1) == 1 && ~isempty(d), ...
        'strsplit:invalidarg', ...
        'The delimiter should be a non-empty char string.');
    
    d = strtrim(d);
    by_space = isempty(d);
end
    
%% main

s = strtrim(s);

if by_space
    w = isspace(s);            
    if any(w)
        % decide the positions of terms        
        dw = diff(w);
        sp = [1, find(dw == -1) + 1];     % start positions of terms
        ep = [find(dw == 1), length(s)];  % end positions of terms
        
        % extract the terms        
        nt = numel(sp);
        terms = cell(1, nt);
        for i = 1 : nt
            terms{i} = s(sp(i):ep(i));
        end                
    else
        terms = {s};
    end
    
else    
    p = strfind(s, d);
    if ~isempty(p)        
        % extract the terms        
        nt = numel(p) + 1;
        terms = cell(1, nt);
        sp = 1;
        dl = length(delimiter);
        for i = 1 : nt-1
            terms{i} = strtrim(s(sp:p(i)-1));
            sp = p(i) + dl;
        end         
        terms{nt} = strtrim(s(sp:end));
    else
        terms = {s};
    end        
end
end
%%
%SETTINGSDLG function
function [settings, button] = settingsdlg(varargin)
% SETTINGSDLG             Default dialog to produce a settings-structure
%
% settings = SETTINGSDLG('fieldname', default_value, ...) creates a modal
% dialog box that returns a structure formed according to user input. The
% input should be given in the form of 'fieldname', default_value - pairs,
% where 'fieldname' is the fieldname in the structure [settings], and
% default_value the initial value displayed in the dialog box. 
%
% SETTINGSDLG uses UIWAIT to suspend execution until the user responds.
%
% settings = SETTINGSDLG(settings) uses the structure [settings] to form
% the various input fields. This is the most basic (and limited) usage of
% SETTINGSDLG.
%
% [settings, button] = SETTINGSDLG(settings) returns which button was
% pressed, in addition to the (modified) structure [settings]. Either 'ok',
% 'cancel' or [] are possible values. The empty output means that the
% dialog was closed before either Cancel or OK were pressed. 
%
% SETTINGSDLG('title', 'window_title') uses 'window_title' as the dialog's
% title. The default is 'Adjust settings'. 
%
% SETTINGSDLG('description', 'brief_description',...) starts the dialog box
% with 'brief_description', followed by the input fields.   
%
% SETTINGSDLG( {'display_string', 'fieldname'}, default_value,...) uses the
% 'display_string' in the dialog box, while assigning the corresponding
% user-input to fieldname 'fieldname'. 
%
% SETTINGSDLG(..., 'checkbox_string', true, ...) displays a checkbox in
% stead of the default edit box, and SETTINGSDLG('fieldname', {'string1', 
% 'string2'},... ) displays a popup box with the strings given in 
% the second cell-array.
%
% Additionally, you can put [..., 'separator', 'seperator_string',...]
% anywhere in the argument list, which will divide all the arguments into
% sections, with section headings 'seperator_string'.
%
% You can also modify the display behavior in the case of checkboxes. When
% defining checkboxes with a 2-element logical array, the second boolean
% determines whether all fields below that checkbox are initially disabled
% (true) or not (false). 
%
% Example:
%
% [settings, button] = settingsdlg(...
%     'Description', 'This dialog will set the parameters used by FMINCON()',... 
%     'title'      , 'FMINCON() options',...
%     'separator'  , 'Unconstrained/General',...
%     {'This is a checkbox'; 'Check'}, [true, true],...
%     {'Tolerance X';'TolX'}, 1e-6,...
%     {'Tolerance on Function';'TolFun'}, 1e-6,...
%     'Algorithm'  , {'active-set','interior-point'},...
%     'separator'  , 'Constrained',...    
%     {'Tolerance on Constraints';'TolCon'}, 1e-6)
% 
% See also inputdlg, dialog, errordlg, helpdlg, listdlg, msgbox, questdlg, textwrap, 
% uiwait, warndlg.
    
% Author:
% Name       : Rody P.S. Oldenhuis
% E-mail     : oldenhuis@gmail.com
% Affiliation: Delft University of Technology
%
% please report any bugs or suggestions to oldnhuis@gmail.com
    
    %% initialize
        
    % errortraps
    narg = nargin;
    error(nargchk(1, inf, narg));
        
    % parse input (+errortrap) 
    have_settings = 0;
    if isstruct(varargin{1})
        settings = varargin{1}; have_settings = 1; end
    if (narg == 1)
        if isstruct(varargin{1})
            parameters = fieldnames(settings);
            values = cellfun(@(x)settings.(x), parameters, 'uniformoutput', false);
        else
            error('settingsdlg:incorrect_input',...
                'When pasing a single argument, that argument must be a structure.')
        end
    else
        parameters = varargin(1+have_settings : 2 : end);
        values     = varargin(2+have_settings : 2 : end);
    end
    
    % initialize data    
    button = [];
    fields = cell(numel(parameters),1);
    tags   = fields;
    
    % fill [settings] with default values & collect data
    for ii = 1:numel(parameters)
        
        % extract fields & tags
        if iscell(parameters{ii})
            tags{ii}   = parameters{ii}{1};
            fields{ii} = parameters{ii}{2};            
        else 
            % more errortraps
            if ~ischar(parameters{ii})
                error('settingsdlg:nonstring_parameter',...
                'Arguments should be given as [''parameter'', value,...] pairs.')
            end
            tags{ii}   = parameters{ii};
            fields{ii} = parameters{ii};            
        end
        
        % more errortraps
        if ~ischar(fields{ii})
            error('settingsdlg:fieldname_not_char',...
                'Fieldname should be a string.')
        end
        if ~ischar(tags{ii})
            error('settingsdlg:tag_not_char',...
                'Display name should be a string.')
        end
        
        % NOTE: 'Separator' is now in 'fields' even though 
        % it will not be used as a fieldname
        
        % make sure all fieldnames are properly formatted
        % (alternating capitals, no whitespace)
        if ~strcmpi(fields{ii}, {'Separator';'Title';'Description'})
            whitespace = isspace(fields{ii});
            capitalize = circshift(whitespace,[0,1]);
            fields{ii}(capitalize) = upper(fields{ii}(capitalize));
            fields{ii} = fields{ii}(~whitespace);
            % insert associated value in output
            if iscell(values{ii})
                settings.(fields{ii}) = values{ii}{1};
            elseif (length(values{ii}) > 1)
                settings.(fields{ii}) = values{ii}(1);
            else
                settings.(fields{ii}) = values{ii};
            end
        end        
    end
    
    % avoid (some) confusion
    clear parameters
    
    % use default colorscheme from the OS
    bgcolor = get(0, 'defaultUicontrolBackgroundColor');
    % get default fontsize
    fontsize = get(0, 'defaultuicontrolfontsize');       
    % edit-bgcolor is platform-dependent. 
    % MS/Windows: white. 
    % UNIX: same as figure bgcolor
%     if ispc, edit_bgcolor = 'White';
%     else     edit_bgcolor = bgcolor;
%     end
% not really applicable since defaultUicontrolBackgroundColor 
% doesn't really work on unix 
edit_bgcolor = 'White';
    
    % look for 'Title', 'Description'
    title = 'Adjust settings';    title_ind = strcmpi(fields,'Title');       
    if any(title_ind)
        title = values{title_ind}; 
        values(title_ind) = [];
        fields(title_ind) = [];
        tags(title_ind) = [];
    end
    description = [];   description_ind = strcmpi(fields,'Description'); 
    if any(description_ind)
        description = values{description_ind};
        values(description_ind) = [];        
        fields(description_ind) = [];
        tags(description_ind) = [];
    end
    
    % look for 'WindowWidth', 'ControlWidth'
    total_width = 325;      width_ind = strcmpi(fields, 'WindowWidth');       
    if any(width_ind)
        total_width       = values{width_ind}; 
        values(width_ind) = [];
        fields(width_ind) = [];
        tags(width_ind)   = [];
    end
    control_width = 100;    ctrlwidth_ind = strcmpi(fields, 'ControlWidth');       
    if any(ctrlwidth_ind)
        control_width         = values{ctrlwidth_ind}; 
        values(ctrlwidth_ind) = [];
        fields(ctrlwidth_ind) = [];
        tags(ctrlwidth_ind)   = [];
    end
    
    % calculate best height for all uicontrol()
    control_height = max(18, (fontsize+6));
    % calculate figure height (will be adjusted later according to description)
    total_height   = numel(fields)*1.25*control_height + ... % to fit all controls
                     1.5*control_height + 20; % to fit "OK" and "Cancel" buttons
                 
    % total number of separators
    num_separators = nnz(strcmpi(fields,'Separator'));
        
    % get screensize and determine proper figure position
    scz = get(0, 'ScreenSize');               % put the window in the center of the screen
    scx = round(scz(3)/2-control_width/2);    % (this will usually work fine, except on some  
    scy = round(scz(4)/2-control_width/2);    % multi-monitor setups)   
    
    % draw figure in background
    fighandle = figure(...
         'integerhandle'   , 'off',...         % use non-integers for the handle (prevents accidental plots from going to the dialog)
         'Handlevisibility', 'off',...         % only visible from within this function
         'position'        , [scx, scy, total_width, total_height],...% figure position
         'visible'         , 'off',...         % hide the dialog while it is being constructed
         'backingstore'    , 'off',...         % DON'T save a copy in the background         
         'resize'          , 'off', ...        % but just keep it resizable
         'renderer'        , 'zbuffer', ...    % best choice for speed vs. compatibility
         'WindowStyle'     ,'modal',...        % window is modal
         'units'           , 'pixels',...      % better for drawing
         'DockControls'    , 'off',...         % force it to be non-dockable
         'name'            , title,...         % dialog title
         'menubar'         ,'none', ...        % no menubar of course
         'toolbar'         ,'none', ...        % no toolbar
         'NumberTitle'     , 'off',...         % "Figure 1.4728...:" just looks corny
         'color'           , bgcolor);         % use default colorscheme
          
    %% draw all required uicontrols() and make it visible
    
    % define X-offsets
    % (different when separators are used)
    separator_offset_X = 2;
    if num_separators > 0
        text_offset_X = 20;
        text_width = (total_width-control_width-text_offset_X);        
    else
        text_offset_X = separator_offset_X;
        text_width = (total_width-control_width);
    end
    
    % check for description
    description_offset = 0;
    if ~isempty(description)
        % create textfield (negligible height initially)
        description_panel = uicontrol(...
            'parent'  , fighandle,...
            'style'   , 'text',...
            'Horizontalalignment', 'left',...
            'position', [separator_offset_X,...
                         total_height,total_width,1]);
        % wrap the description
        description = textwrap(description_panel, {description});        
        % adjust the height of the figure        
        textheight = size(description,1)*(fontsize+6);
        description_offset = textheight + 20;        
        total_height = total_height + description_offset;
        set(fighandle,...
            'position', [scx, scy, total_width, total_height])        
        % adjust the position of the textfield and insert the description        
        set(description_panel, ...
            'string'  , description,...
            'position', [separator_offset_X, total_height-textheight, ...
                         total_width, textheight]);
    end
    
    % define Y-offsets 
    % (different when descriptions is used)
    control_offset_Y = total_height-control_height-description_offset;
    
    % initialize loop
    controls = zeros(numel(tags)-num_separators,1);    
    ii = 1;             sep_ind = 1;
    enable = 'on';      separators = zeros(num_separators,1);
    
    % loop through the controls
    if numel(tags) > 0
        while true
            
            % should we draw a separator?
            if strcmpi(tags{ii}, 'Separator')
                % Print separator
                uicontrol(...
                    'style'   , 'text',...
                    'parent'  , fighandle,...
                    'string'  , values{ii},...
                    'horizontalalignment', 'left',...
                    'fontweight', 'bold',...
                    'position', [separator_offset_X,control_offset_Y-4, ...
                    total_width, control_height]);
                % remove separator, but save its position
                fields(ii) = [];
                tags(ii)   = [];  separators(sep_ind) = ii;
                values(ii) = [];  sep_ind = sep_ind + 1;
                % reset enable (when neccessary)
                if strcmpi(enable, 'off'), enable = 'on'; end
                
                % NOTE: DON'T increase loop index
                
                % or a setting?
            else
                % logicals: use checkbox
                if islogical(values{ii})
                    % first draw control
                    controls(ii) = uicontrol(...
                        'style'   , 'checkbox',...
                        'parent'  , fighandle,...
                        'enable'  , enable,...
                        'string'  , tags{ii},...
                        'value'   , values{ii}(1),...
                        'position', [text_offset_X,control_offset_Y-4, ...
                        total_width, control_height]);
                    % should everything below here be OFF?
                    if (length(values{ii})>1)
                        % turn next controls off when asked for
                        if values{ii}(2), enable = 'off'; end
                        % turn on callback function
                        set(controls(ii),...
                            'Callback', @(varargin) EnableDisable(ii,varargin{:}));
                    end
                    
                    % doubles: use edit box
                    % cells  : use popup
                else
                    % first print parameter
                    uicontrol(...
                        'style'   , 'text',...
                        'parent'  , fighandle,...
                        'string'  , [tags{ii}, ':'],...
                        'horizontalalignment', 'left',...
                        'position', [text_offset_X,control_offset_Y-4, ...
                        text_width, control_height]);
                    % popup or edit box?
                    style = 'edit'; if iscell(values{ii}), style = 'popup'; end
                    % draw appropriate control
                    controls(ii) = uicontrol(...
                        'enable'  , enable,...
                        'style'   , style,...
                        'Background', edit_bgcolor,...
                        'parent'  , fighandle,...
                        'string'  , values{ii},...
                        'position', [text_width,control_offset_Y,...
                        control_width, control_height]);
                end
                
                % increase loop index
                ii = ii + 1;
            end
            
            % end loop?
            if ii > numel(tags), break, end
            
            % decrease offset
            control_offset_Y = control_offset_Y - 1.25*control_height;
        end
    end
    
    % Cancel button
    uicontrol(...
        'style'   , 'pushbutton',...
        'parent'  , fighandle,...
        'string'  , 'Cancel',...
        'position', [separator_offset_X,2, total_width/2.5,control_height*1.5],...
        'Callback', @Cancel)
    
    % OK button
    uicontrol(...
        'style'   , 'pushbutton',...
        'parent'  , fighandle,...
        'string'  , 'OK',...
        'position', [total_width*(1-1/2.5)-separator_offset_X,200, ...
                     total_width/2.5,control_height*1.5],...
        'Callback', @OK)  
    % % total_width*(1-1/2.5)-separator_offset_X,2, ...
      % %                total_width/2.5,control_height*1.5
        
    % move to center of screen and make visible
    movegui(fighandle, 'center');  
    set(fighandle, 'Visible', 'on');  
    
    % WAIT until OK/Cancel is pressed
    uiwait(fighandle); 
    
    %% callback functions
    
    % enable/disable controls associated with (some) checkboxes
    function EnableDisable(which, varargin)
        
        % find proper range of controls to switch
        if (num_separators > 1)
             range = (which+1):(separators(separators > which)-1);
        else range = (which+1):numel(controls);
        end
        
        % enable/disable these controls
        if strcmpi(get(controls(range(1)), 'enable'), 'off')
            set(controls(range), 'enable', 'on')
        else
            set(controls(range), 'enable', 'off')
        end
    end
    
    % OK button: 
    % - update fields in [settings]
    % - assign [button] output argument ('ok')
    % - kill window
    function OK(varargin)
        
        % button pressed
        button = 'OK';
        
        % fill settings
        for i = 1:numel(controls)
            
            % extract current control's string, value & type            
            str   = get(controls(i), 'string');
            val   = get(controls(i), 'value');
            style = get(controls(i), 'style');
            
            % popups/edits
            if ~strcmpi(style, 'checkbox')
                % extract correct string (popups only)
                if strcmpi(style, 'popupmenu'), str = str{val}; end
                % try to convert string to double
                val = str2double(str); 
                % insert this double in [settings]. If it was not a 
                % double, insert string instead
                if ~isnan(val), settings.(fields{i}) = val;
                else            settings.(fields{i}) = str;
                end  
                
            % checkboxes
            else
                % we can insert value immediately
                settings.(fields{i}) = val;
            end
        end
        
        %  kill window
        delete(fighandle);
    end
    
    % Cancel button:
    % - assign [button] output argument ('cancel')
    % - delete figure (so: return default settings)
    function Cancel(varargin)
        button = 'cancel';
        delete(fighandle);
    end
    
end