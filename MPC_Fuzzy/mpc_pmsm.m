function [sys,x0,str,ts,simStateCompliance] = mpc_pmsm(t,x,u,flag,Vdc,R,Ld,Lq,Phif)

switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes;

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case {1,2,4,9},
    sys=[];

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u,Vdc,R,Ld,Lq,Phif);

  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

% end sfuntmpl

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
% Note that in this example, the values are hard coded.  This is not a
% recommended practice as the characteristics of the block are typically
% defined by the S-function parameters.
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 2;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 6;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
x0  = [0];

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
Ts = 2e-6;
ts  = [Ts 0];

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'DisallowSimState' < Error out when saving or restoring the model sim state
simStateCompliance = 'UnknownSimState';

% end mdlInitializeSizes



%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u,Vdc,R,Ld,Lq,Phif)

Ts = 2e-6;

err = zeros(8,1);

Sw = [ 0,0,0 ; 0,0,1; 0,1,0; 0,1,1; 1,0,0; 1,0,1; 1,1,0; 1,1,1];

id_ref = u(1);
iq_ref = u(2);
id = u(3);
iq = u(4);
theta = u(5);
wr = u(6);

trans =2/3 * [ cos(theta) cos(theta-2*pi/3) cos(theta+2*pi/3); -sin(theta) -sin(theta-2*pi/3) -sin(theta+2*pi/3)];

for i=1:8
    Vabc = Sw(i,:)'*Vdc - Vdc/2;
    Vdq = trans*Vabc;
    
    Vd = Vdq(1);
    Vq = Vdq(2);
    
    did = 1/Ld*( Vd - R*id + wr*Lq*iq)*Ts;
    diq = 1/Lq*( Vq - R*iq - wr*(Phif+Ld*id))*Ts;
    
    id_next = id + did;
    iq_next = iq + diq;
    
    err(i) = (id_next-id_ref)^2 + (iq_next-iq_ref)^2;
    
end

[~,I] = min(err);
sys = Sw(I,:);

% end mdlOutputs
