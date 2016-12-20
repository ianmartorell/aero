[ clLinear, clErrorLinear, cmLELinear, nPanels ] = verification_helper('linear');
[ clFullCosine, clErrorFullCosine, cmLEFullCosine, nPanels ] = verification_helper('fullCosine');

csvwrite('data/cl_convergence.csv', [ nPanels clLinear clFullCosine clErrorLinear clErrorFullCosine ]);
