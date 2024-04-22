#data cleaning
#PEV = BEV + PHEV
LDVdata$BEV <- as.numeric(gsub(",", "", as.character(LDVdata$BEV)))
LDVdata$PHEV <- as.numeric(gsub(",", "", as.character(LDVdata$PHEV)))
LDVdata$PEV <- LDVdata$BEV + LDVdata$PHEV
LDVdata$TotalLDV <- as.numeric(gsub(",", "", LDVdata$TotalLDV))
LDVdata$TotalLDV <- LDVdata$TotalLDV
anyNA(LDVdata$TotalLDV)
anyNA(LDVdata$PEV)
LDVdata <- na.omit(LDVdata)
LDVdata$share <- LDVdata$PEV / LDVdata$TotalLDV
