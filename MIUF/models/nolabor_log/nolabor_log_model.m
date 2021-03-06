function [model] = get_model()
    model = model_info;
    model.f = @f;
    model.g = @g;
    model.a = @a;
end

function [out1,out2,out3,out4,out5] = f(s,x,snext,xnext,p)
    n = size(s,1);

    % f
      out1 = zeros(n,4);
      out1(:,1) = -p(1).*p(2).*x(:,2)./xnext(:,1) + p(1)./x(:,1);
      out1(:,2) = -p(3).*snext(:,1).^p(3).*exp(snext(:,3))./snext(:,1) + p(4) + x(:,2) - 1;
      out1(:,3) = p(2).*x(:,1)./(xnext(:,1).*(xnext(:,3) + 1)) - 1 + x(:,1).*(-p(1) + 1).*(x(:,3) + 1)./(p(1).*s(:,2));
      out1(:,4) = x(:,4) - x(:,2).*(xnext(:,3) + 1);

if nargout >= 2

    % df/ds
      out2 = zeros(n,4,4);
      out2(:,1,1) = 0; % d eq_1 w.r.t. k
      out2(:,1,2) = 0; % d eq_1 w.r.t. mm
      out2(:,1,3) = 0; % d eq_1 w.r.t. z
      out2(:,1,4) = 0; % d eq_1 w.r.t. u
      out2(:,2,1) = 0; % d eq_2 w.r.t. k
      out2(:,2,2) = 0; % d eq_2 w.r.t. mm
      out2(:,2,3) = 0; % d eq_2 w.r.t. z
      out2(:,2,4) = 0; % d eq_2 w.r.t. u
      out2(:,3,1) = 0; % d eq_3 w.r.t. k
      out2(:,3,2) = -x(:,1).*(-p(1) + 1).*(x(:,3) + 1)./(p(1).*s(:,2).^2); % d eq_3 w.r.t. mm
      out2(:,3,3) = 0; % d eq_3 w.r.t. z
      out2(:,3,4) = 0; % d eq_3 w.r.t. u
      out2(:,4,1) = 0; % d eq_4 w.r.t. k
      out2(:,4,2) = 0; % d eq_4 w.r.t. mm
      out2(:,4,3) = 0; % d eq_4 w.r.t. z
      out2(:,4,4) = 0; % d eq_4 w.r.t. u

    % df/dx
      out3 = zeros(n,4,4);
      out3(:,1,1) = -p(1)./x(:,1).^2; % d eq_1 w.r.t. c
      out3(:,1,2) = -p(1).*p(2)./xnext(:,1); % d eq_1 w.r.t. R
      out3(:,1,3) = 0; % d eq_1 w.r.t. PI
      out3(:,1,4) = 0; % d eq_1 w.r.t. I
      out3(:,2,1) = 0; % d eq_2 w.r.t. c
      out3(:,2,2) = 1; % d eq_2 w.r.t. R
      out3(:,2,3) = 0; % d eq_2 w.r.t. PI
      out3(:,2,4) = 0; % d eq_2 w.r.t. I
      out3(:,3,1) = p(2)./(xnext(:,1).*(xnext(:,3) + 1)) + (-p(1) + 1).*(x(:,3) + 1)./(p(1).*s(:,2)); % d eq_3 w.r.t. c
      out3(:,3,2) = 0; % d eq_3 w.r.t. R
      out3(:,3,3) = x(:,1).*(-p(1) + 1)./(p(1).*s(:,2)); % d eq_3 w.r.t. PI
      out3(:,3,4) = 0; % d eq_3 w.r.t. I
      out3(:,4,1) = 0; % d eq_4 w.r.t. c
      out3(:,4,2) = -xnext(:,3) - 1; % d eq_4 w.r.t. R
      out3(:,4,3) = 0; % d eq_4 w.r.t. PI
      out3(:,4,4) = 1; % d eq_4 w.r.t. I

    % df/dsnext
      out4 = zeros(n,4,4);
      out4(:,1,1) = 0; % d eq_1 w.r.t. k(1)
      out4(:,1,2) = 0; % d eq_1 w.r.t. mm(1)
      out4(:,1,3) = 0; % d eq_1 w.r.t. z(1)
      out4(:,1,4) = 0; % d eq_1 w.r.t. u(1)
      out4(:,2,1) = -p(3).^2.*snext(:,1).^p(3).*exp(snext(:,3))./snext(:,1).^2 + p(3).*snext(:,1).^p(3).*exp(snext(:,3))./snext(:,1).^2; % d eq_2 w.r.t. k(1)
      out4(:,2,2) = 0; % d eq_2 w.r.t. mm(1)
      out4(:,2,3) = -p(3).*snext(:,1).^p(3).*exp(snext(:,3))./snext(:,1); % d eq_2 w.r.t. z(1)
      out4(:,2,4) = 0; % d eq_2 w.r.t. u(1)
      out4(:,3,1) = 0; % d eq_3 w.r.t. k(1)
      out4(:,3,2) = 0; % d eq_3 w.r.t. mm(1)
      out4(:,3,3) = 0; % d eq_3 w.r.t. z(1)
      out4(:,3,4) = 0; % d eq_3 w.r.t. u(1)
      out4(:,4,1) = 0; % d eq_4 w.r.t. k(1)
      out4(:,4,2) = 0; % d eq_4 w.r.t. mm(1)
      out4(:,4,3) = 0; % d eq_4 w.r.t. z(1)
      out4(:,4,4) = 0; % d eq_4 w.r.t. u(1)

    % df/dxnext
      out5 = zeros(n,4,4);
      out5(:,1,1) = p(1).*p(2).*x(:,2)./xnext(:,1).^2; % d eq_1 w.r.t. c(1)
      out5(:,1,2) = 0; % d eq_1 w.r.t. R(1)
      out5(:,1,3) = 0; % d eq_1 w.r.t. PI(1)
      out5(:,1,4) = 0; % d eq_1 w.r.t. I(1)
      out5(:,2,1) = 0; % d eq_2 w.r.t. c(1)
      out5(:,2,2) = 0; % d eq_2 w.r.t. R(1)
      out5(:,2,3) = 0; % d eq_2 w.r.t. PI(1)
      out5(:,2,4) = 0; % d eq_2 w.r.t. I(1)
      out5(:,3,1) = -p(2).*x(:,1)./(xnext(:,1).^2.*(xnext(:,3) + 1)); % d eq_3 w.r.t. c(1)
      out5(:,3,2) = 0; % d eq_3 w.r.t. R(1)
      out5(:,3,3) = -p(2).*x(:,1)./(xnext(:,1).*(xnext(:,3) + 1).^2); % d eq_3 w.r.t. PI(1)
      out5(:,3,4) = 0; % d eq_3 w.r.t. I(1)
      out5(:,4,1) = 0; % d eq_4 w.r.t. c(1)
      out5(:,4,2) = 0; % d eq_4 w.r.t. R(1)
      out5(:,4,3) = -x(:,2); % d eq_4 w.r.t. PI(1)
      out5(:,4,4) = 0; % d eq_4 w.r.t. I(1)

end

        
end

function [out1,out2,out3] = g(s,x,e,p)
    n = size(s,1);

    % g

      out1 = zeros(n,4);
      out1(:,1) = -x(:,1) + s(:,1).*(-p(4) + 1) + s(:,1).^p(3).*exp(s(:,3));
      out1(:,2) = s(:,2).*(p(6).*s(:,4) + p(5) + p(7).*s(:,3) + e(:,2) + 1)./(x(:,3) + 1);
      out1(:,3) = p(8).*s(:,3) + e(:,1);
      out1(:,4) = p(6).*s(:,4) + p(7).*s(:,3) + e(:,2);

if nargout >=2
    % dg/ds
          out2 = zeros(n,4,4);
      out2(:,1,1) = p(3).*s(:,1).^p(3).*exp(s(:,3))./s(:,1) - p(4) + 1; % d eq_1 w.r.t. k
      out2(:,1,2) = 0; % d eq_1 w.r.t. mm
      out2(:,1,3) = s(:,1).^p(3).*exp(s(:,3)); % d eq_1 w.r.t. z
      out2(:,1,4) = 0; % d eq_1 w.r.t. u
      out2(:,2,1) = 0; % d eq_2 w.r.t. k
      out2(:,2,2) = (p(6).*s(:,4) + p(5) + p(7).*s(:,3) + e(:,2) + 1)./(x(:,3) + 1); % d eq_2 w.r.t. mm
      out2(:,2,3) = p(7).*s(:,2)./(x(:,3) + 1); % d eq_2 w.r.t. z
      out2(:,2,4) = p(6).*s(:,2)./(x(:,3) + 1); % d eq_2 w.r.t. u
      out2(:,3,1) = 0; % d eq_3 w.r.t. k
      out2(:,3,2) = 0; % d eq_3 w.r.t. mm
      out2(:,3,3) = p(8); % d eq_3 w.r.t. z
      out2(:,3,4) = 0; % d eq_3 w.r.t. u
      out2(:,4,1) = 0; % d eq_4 w.r.t. k
      out2(:,4,2) = 0; % d eq_4 w.r.t. mm
      out2(:,4,3) = p(7); % d eq_4 w.r.t. z
      out2(:,4,4) = p(6); % d eq_4 w.r.t. u
    % dg/dx
          out3 = zeros(n,4,4);
      out3(:,1,1) = -1; % d eq_1 w.r.t. c
      out3(:,1,2) = 0; % d eq_1 w.r.t. R
      out3(:,1,3) = 0; % d eq_1 w.r.t. PI
      out3(:,1,4) = 0; % d eq_1 w.r.t. I
      out3(:,2,1) = 0; % d eq_2 w.r.t. c
      out3(:,2,2) = 0; % d eq_2 w.r.t. R
      out3(:,2,3) = -s(:,2).*(p(6).*s(:,4) + p(5) + p(7).*s(:,3) + e(:,2) + 1)./(x(:,3) + 1).^2; % d eq_2 w.r.t. PI
      out3(:,2,4) = 0; % d eq_2 w.r.t. I
      out3(:,3,1) = 0; % d eq_3 w.r.t. c
      out3(:,3,2) = 0; % d eq_3 w.r.t. R
      out3(:,3,3) = 0; % d eq_3 w.r.t. PI
      out3(:,3,4) = 0; % d eq_3 w.r.t. I
      out3(:,4,1) = 0; % d eq_4 w.r.t. c
      out3(:,4,2) = 0; % d eq_4 w.r.t. R
      out3(:,4,3) = 0; % d eq_4 w.r.t. PI
      out3(:,4,4) = 0; % d eq_4 w.r.t. I
end
        
end

function [out1,out2,out3] = a(s,x,p)
    n = size(s,1);

    % a

      out1 = zeros(n,5);
      out1(:,1) = s(:,1).^p(3).*exp(s(:,3));
      out1(:,2) = p(5) + s(:,4);
      out1(:,3) = s(:,2)./(x(:,3) + 1);
      out1(:,4) = p(1)./x(:,1);
      out1(:,5) = (-p(1) + 1).*(x(:,3) + 1)./s(:,2);

if nargout >=2
    % da/ds
          out2 = zeros(n,5,4);
      out2(:,1,1) = p(3).*s(:,1).^p(3).*exp(s(:,3))./s(:,1); % d eq_1 w.r.t. k
      out2(:,1,2) = 0; % d eq_1 w.r.t. mm
      out2(:,1,3) = s(:,1).^p(3).*exp(s(:,3)); % d eq_1 w.r.t. z
      out2(:,1,4) = 0; % d eq_1 w.r.t. u
      out2(:,2,1) = 0; % d eq_2 w.r.t. k
      out2(:,2,2) = 0; % d eq_2 w.r.t. mm
      out2(:,2,3) = 0; % d eq_2 w.r.t. z
      out2(:,2,4) = 1; % d eq_2 w.r.t. u
      out2(:,3,1) = 0; % d eq_3 w.r.t. k
      out2(:,3,2) = 1./(x(:,3) + 1); % d eq_3 w.r.t. mm
      out2(:,3,3) = 0; % d eq_3 w.r.t. z
      out2(:,3,4) = 0; % d eq_3 w.r.t. u
      out2(:,4,1) = 0; % d eq_4 w.r.t. k
      out2(:,4,2) = 0; % d eq_4 w.r.t. mm
      out2(:,4,3) = 0; % d eq_4 w.r.t. z
      out2(:,4,4) = 0; % d eq_4 w.r.t. u
      out2(:,5,1) = 0; % d eq_5 w.r.t. k
      out2(:,5,2) = -(-p(1) + 1).*(x(:,3) + 1)./s(:,2).^2; % d eq_5 w.r.t. mm
      out2(:,5,3) = 0; % d eq_5 w.r.t. z
      out2(:,5,4) = 0; % d eq_5 w.r.t. u
    % da/dx
          out3 = zeros(n,5,4);
      out3(:,1,1) = 0; % d eq_1 w.r.t. c
      out3(:,1,2) = 0; % d eq_1 w.r.t. R
      out3(:,1,3) = 0; % d eq_1 w.r.t. PI
      out3(:,1,4) = 0; % d eq_1 w.r.t. I
      out3(:,2,1) = 0; % d eq_2 w.r.t. c
      out3(:,2,2) = 0; % d eq_2 w.r.t. R
      out3(:,2,3) = 0; % d eq_2 w.r.t. PI
      out3(:,2,4) = 0; % d eq_2 w.r.t. I
      out3(:,3,1) = 0; % d eq_3 w.r.t. c
      out3(:,3,2) = 0; % d eq_3 w.r.t. R
      out3(:,3,3) = -s(:,2)./(x(:,3) + 1).^2; % d eq_3 w.r.t. PI
      out3(:,3,4) = 0; % d eq_3 w.r.t. I
      out3(:,4,1) = -p(1)./x(:,1).^2; % d eq_4 w.r.t. c
      out3(:,4,2) = 0; % d eq_4 w.r.t. R
      out3(:,4,3) = 0; % d eq_4 w.r.t. PI
      out3(:,4,4) = 0; % d eq_4 w.r.t. I
      out3(:,5,1) = 0; % d eq_5 w.r.t. c
      out3(:,5,2) = 0; % d eq_5 w.r.t. R
      out3(:,5,3) = (-p(1) + 1)./s(:,2); % d eq_5 w.r.t. PI
      out3(:,5,4) = 0; % d eq_5 w.r.t. I
end
                    
end

function [out1] = model_info() % informations about the model

    mod = struct;
    mod.states = { 'k','mm','z','u' };
    mod.controls = { 'c','R','PI','I' };
    mod.auxiliaries = { 'y','theta','m','uc','um' };
    mod.parameters = { 'a','beta','alpha','delta','theta_ss','gamma','varphi','rho','sigma_z','sigma_u' };
    mod.s_ss = [48.2457345745 ; 7.16393700614 ; 0.0 ; 0.0];
    mod.x_ss = [3.1202052109 ; 1.0111223458 ; 0.0125 ; 1.0111223458];
    mod.params = [ 0.95    0.989   0.36    0.019   0.0125  0.5     0.      0.95    0.007  0.0089];
    mod.X = cell(2,1);
    mod.X{1} = [ 3.12020521  1.01112235  0.0125      1.01112235];
    mod.X{2} = [[  4.05990678e-02  -2.61625767e-16   8.77304618e-01  -3.11748755e-15 ;  -3.87807137e-04  -4.72765937e-17   2.73537100e-02   1.89430667e-17 ;  -1.31743117e-02   1.41332901e-01  -2.84683495e-01   9.54633205e-01 ;   5.47383744e-17  -6.51724406e-17   1.65626200e-15   2.29356903e-02]];
    out1 = mod;

end
