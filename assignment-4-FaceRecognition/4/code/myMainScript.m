clear all;
clc;
a = randi([1 5]);
b = randi([6 10]);
A1 = rand(a,a);
A2 = rand(a,b);
A3 = rand(b,a);
[U1, S1, V1] = mySVD(A1);
[U2, S2, V2] = mySVD(A2);
[U3, S3, V3] = mySVD(A3);
B1 = U1*S1*V1';
B2 = U2*S2*V2';
B3 = U3*S3*V3';
err1 = max(max(A1-B1));
err2 = max(max(A2-B2));
err3 = max(max(A3-B3));
if(err1<1E-8 && err2<1E-8 && err3<1E-8)
    disp("all SVDs are correct");
else
    disp("error in SVD");
end