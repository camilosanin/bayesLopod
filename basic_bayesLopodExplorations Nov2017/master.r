#
# SimSp100sq=stack("C:/GitHub/bayesLopod/simScenario/sim100Sampling_Biased.grd")
# SimSp50sq=stack("C:/GitHub/bayesLopod/simScenario/sim50Sampling_Biased.grd")
# SimSp25sq=stack("C:/GitHub/bayesLopod/simScenario/sim25Sampling_Biased.grd")
#
# devtools::use_data(SimSp100sq,SimSp50sq,SimSp25sq,overwrite = T)


#
# writeRaster(spData[["sampEff"]], "C:/GitHub/bayesLopod/simScenario/sim100Sampling_Biased_SamEff.tif")
# writeRaster(spData[["totalDetVarP"]], "C:/GitHub/bayesLopod/simScenario/sim100Sampling_Biased_totalDetVarP.tif")

rasterN = spData[["sampEff"]]
rasterY = spData[["totalDetVarP"]]

spplot(rasterStudyArea(rasterDistToRecords(rasterN,rasterY)))

LopodObject = rasterLopodData(rasterN, rasterY, Adjacency = T)
spplot(LopodObject@geoDataObject)

ModLopod = modelLopod(LopodObject, varP = F, q = NULL, CAR = T, pmin = 0, nChains = 1, warmup = 20, sampling = 10, nCores = 2)

modelParams(ModLopod)
lopodSummary(ModLopod, probs = NULL)
lopodDens(ModLopod)
spplot(lopodRaster(ModLopod, param="pp", metric="mean", extrapolate = F))


devtools::document()

devtools::install_github("camilosanin/bayesLopod/bayesLopod")
