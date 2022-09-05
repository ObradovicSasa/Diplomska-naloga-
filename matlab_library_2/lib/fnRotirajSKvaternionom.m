function S_out = fnRotirajSKvaternionom(S_in, q)    

Q = [-q(2) -q(3) -q(4);
      q(1) -q(4) q(3);
      q(4) q(1) -q(2);
      -q(3) q(2) q(1)];
  
QT = [-q(2) q(1) -q(4) q(3);
      -q(3) q(4) q(1) -q(2);
      -q(4) -q(3) q(2) q(1)];
  
S_out = S_in*QT*Q;