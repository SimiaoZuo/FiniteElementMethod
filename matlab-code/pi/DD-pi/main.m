function main(N)
% call function plotFEM & errorAnalysis & condAnalysisOfA & condAnalysisOfN

plotFEM(N);

errorAnalysis(N);

condAnalysisOfN(N);

condAnalysisOfA(N/2);

end

