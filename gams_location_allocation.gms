sets
i Candidate supplier /i1,i2,i3,i5/
j Candidate factory /j2*j7/
k Customers /k1*k7/
m Materials /m1/
g Goods /g1/;

parameters
D_kg(k,g) Average demand of customer k for product g (mT)
/
    k1.g1 0.25
*    k1.g2 0.4
    
    k2.g1 0.25
*    g2 0.6
    
    k3.g1 0.75
*    k3.g2 2
    
    k4.g1 0.5
*    k4.g2 2
    
    k5.g1 0.80
*    k5.g2 1.5
    
    k6.g1 0.65
*    k6.g2 1
    
    k7.g1 0.55
*    k7.g2 0.75
/
DFK_jk(j,k) Distance from factory j to customer k (km)
/ 
*    j2.k1 100
*    j2.k2 205
*    j2.k3 314
*    j2.k4 306
*    j2.k5 365
*    j2.k6 268
*    j2.k7 153   


    j3.k1 112
    j3.k2 239
    j3.k3 271
    j3.k4 215
    j3.k5 322
    j3.k6 176
    j3.k7 244
   
    j4.k1 214
    j4.k2 431
    j4.k3 304
    j4.k4 115
    j4.k5 432
    j4.k6 112
    j4.k7 432
    
    j5.k1 265
    j5.k2 306
    j5.k3 419
    j5.k4 193
    j5.k5 547
    j5.k6 111
    j5.k7 483
    
    j6.k1 202
    j6.k2 120
    j6.k3 444
    j6.k4 392
    j6.k5 495
    j6.k6 192
    j6.k7 329
    
    j7.k1 331
    j7.k2 580
    j7.k3 197
    j7.k4 428
    j7.k5 110
    j7.k6 499
    j7.k7 536    
/
DSF_ij(i,j) Distance from supplier i to factory j (km)
/
    i1.j2 230
    i1.j3 243
    i1.j4 449
    i1.j5 313
    i1.j6 100
    i1.j7 581
    
    i2.j2 315
    i2.j3 224
    i2.j4 100
    i2.j5 194
    i2.j6 396
    i2.j7 478

    i3.j2 359
    i3.j3 275
    i3.j4 199
    i3.j5 100
    i3.j6 263
    i3.j7 590

    i5.j2 404
    i5.j3 364
    i5.j4 475
    i5.j5 582
    i5.j6 530
    i5.j7 100
/
KS_im(i,m) Maximum supplier capacity i for raw material m (m_ton)
/
    i1.m1 1.65
    i2.m1 1.50   
    i3.m1 1.35
    i5.m1 1.25
/
KF_jg(j,g) Maximum capacity of factory j for manufacture product g(m_ton)
/
    j2.g1 0.95
    j3.g1 0.75
    j4.g1 0.80
    j5.g1 0.72 
    j6.g1 0.87  
    j7.g1 0.92

/
*CAHP_j(j) Coefficients obtained from the output of the AHP stage
*/
*    j2 0.1156
*    j3 0.0279
*    j4 0.0336
*    j5 0.0603
*    j6 0.0152
*    j7 0.0171
*/
Cpower Average cost of energy consumption ($ per ton)
/
    1000000
/
Cpur_m(m) Cost of purchasing each unit of raw materials m
/
    m1 500000
*    m2 450000
*    m3 550000
/
FC_j(j) Fixed cost of factory installation j($)
/
    j2 9000000
    j3 8000000
    j4 10000000
    j5 7500000
    j6 8500000
    j7 9500000
/
Cmanu Average variable cost of production ($ per ton)
/
    800000
/
C Shipping cost per unit of product or raw material ($ per km per unit of transport)
/
    2000
/
CEMP_j(j) Cost of employment per unit of factory construction j
/
    j2 6000
    j3 4500 
    j4 5500
    j5 6500
    j6 6000
    j7 7000
/
REMP_j(j) Employment rate per unit of factory construction j
/
    j2 125
    j3 200
    j4 175
    j5 180
    j6 150
    j7 200
/
PEMP Amount of employment planned by stakeholders or the government
/
    100000
/
R_mg(m,g) Percentage of raw materials used to produce each unit of product g
/
    m1.g1 1.00
/
M_big A very big number
/
    5554444
/
MSC Miscellaneous cost
/
    5000
/
H Maximum number of available location
/
    4
/
;

binary variables
y(j) If factory j is constructed or not
*x(i) If supplier i is activate or not
;

positive variables
v(j, g) The amount of product g produced bt factory j
z(i, j, m) Amount of raw materials of type m tat is sent to the factory j by the supplier i
w(j, k, g) Amount of products of type g that is sent to the customer k by the factory j
;

variable
obj_1;

equation minz_1,
c1(i,m), c2(j,g), c3(j,m), c4(k,g), c5, c8(j,g), c10(j), c11(i), c13;

minz_1..
obj_1 =e= sum(j, FC_j(j) * y(j))  + sum(j, REMP_j(j) * y(j) * CEMP_j(j)) +
sum((j, g), v(j, g) * Cmanu) + sum((i, j, m), Cpur_m(m) * z(i, j, m)) +
sum((j, k, g), v(j, g) * Cpower) + sum((i, j, m), z(i, j, m) * (C * DSF_ij(i, j) + MSC)) +
sum((j, k, g), w(j, k, g) * (C * DFK_jk(j,k) + MSC)) ;

*minz_2..
*obj_2 =e= sum(j, CAHP_j(j) * y(j));

c1(i, m)     .. KS_im(i,m) =g= sum(j, z(i, j, m));
c2(j, g)     .. KF_jg(j, g) * y(j) =g=  sum(k, w(j, k, g));
c3(j, m)     .. sum(i, z(i, j, m)) =g= sum(g, v(j, g) * R_mg(m, g));
c4(k, g)     .. sum(j, w(j, k, g)) =g= D_kg(k, g);
c5           .. sum(j, REMP_j(j) * y(j)) =g= PEMP;
*c6(j, k, g)  .. w(j, k, g) =l= M_big * y(j);
*c7(j, g)     .. v(j, g) =l= KF_jg(j, g) * y(j);
c8(j, g)     .. v(j, g) =e= sum(k, w(j, k, g));
*c9(j,g)      .. v(j,g) =l= M_big * y(j);
c10(j)       .. sum((k, g), w(j, k, g)) =g= 1;
c11(i)       .. sum((j, m), z(i, j, m)) =g= 1;
*c12(i, j, m) .. z(i, j, m) =l= M_big * x(i);
c13          .. sum(j,y(j)) =l= H;

model trial / all /;

solve trial using RMIP minimizing obj_1;