aspectRatio = 8;
taperRatio = 0.5;
% 0 degree sweep at c/2 equals 10.61 degrees at the leading edge
quarterChordSweep = quarter_chord_sweep(10.61, aspectRatio, taperRatio);
angleOfAttack = 0;
wingTipTwist = 0;
horseshoeShape = 'rectangular';
nPanels = 100;
% cLAlpha, clMax and alphaL0 taken from airfoil_data.pdf for NACA 2412
cLAlpha = 0.105;
clMax = 1.68;
alphaL0 = -2;
% We transform panels to wing span from -0.5 to 0.5
wingSpan = linspace(-0.5, 0.5, nPanels)';
% Find additional and basic lift distributions
[ cL1, cLY1, cDi, alpha_i ] = HVM(aspectRatio, taperRatio, quarterChordSweep, -2, wingTipTwist, horseshoeShape, nPanels);
[ cL2, cLY2 ] = HVM(aspectRatio, taperRatio, quarterChordSweep, 2, wingTipTwist, horseshoeShape, nPanels);
additionalLift = (cLY1-cLY2)/(cL1-cL2);
basicLift = cLY1 - cL1*additionalLift;
totalLift = basicLift + additionalLift*cL1;
csvwrite('data/hw2_5_lift.csv', [ wingSpan basicLift additionalLift totalLift ]);
% Find cLMax
cLYs = (clMax-basicLift)./additionalLift;
[ cLMax, panel ] = min(cLYs);
alphaMax = cLMax/cLAlpha + alpha_i(panel) + alphaL0;
csvwrite('data/hw2_5_max.csv', [ cLMax alphaMax ]);
% Find cLY variation for 10 degrees of flap
flapAngle = 10;
flapPosition = 0.8;
theta = acos(1-flapPosition*2);
deltaAlphaL0 = (1-theta/pi+sin(theta)/pi)*flapAngle;
deltaCl = deltaAlphaL0*cLAlpha;
% Find additional and basic lift distributions
cLY1 = cLY1 + deltaCl;
cL1 = sum(cLY1)/nPanels;
basicLift = cLY1 - cL1*additionalLift;
totalLift = basicLift + additionalLift*cL1;
csvwrite('data/hw2_5_lift_flap.csv', [ wingSpan basicLift additionalLift totalLift ]);
% Find cLMax again, for flap configuration
cLYs = (clMax-basicLift)./additionalLift;
[ cLMax, panel ] = min(cLYs);
alphaMax = cLMax/cLAlpha + alpha_i(panel) + alphaL0 + deltaAlphaL0;
csvwrite('data/hw2_5_max_flap.csv', [ cLMax alphaMax ]);
